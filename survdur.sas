%*-------------------------------------------------------------
Sponsor:   		

Program:			survdur.sas

Protocol:     C:\projects\\phase2\macros\


Purpose:			Figures for PFS Survival Wrapper for STEPLOT.sas

Inputs:
Depends:

Outputs:

Parameters:


Author:       Bruce Thomas
Date:	             03/25/10


Usage:			Survival estimates for response duration
						requires steplot.sas

History:

3/25/2010 BT added Big N replaced count of survival observations in title.
Since Survival is % of patients, had to multi[ply _CENSOR_ the same way.
Since using template in STEPLOT.sas created CENSOR variable, set to 
.1 if censored but had some survival.

-----------------------------------------------------------------;

%macro survdur(
							inds=,          /**INPUT Dataset**/
							outds=,         /**Output Dataset**/
							trt=cohortn,    /**Stratum variable **/
							where=%str(where 1),  /**options subset on INDS**/
							showp=,         /** >0 turns on pvalue, median reporting*/
							showpct=Y,      /** Display surv probability as percent of subjects*/
							OUT=&outfile,   /** ODS RTF file name without extension */
							tabno=          /** figure number **/
							);

%let trt=%upcase(&trt);
%let inds=%upcase(&inds);

%LET NOBS=0;
data in_;
	set &inds NOBS=NOBS;
	&where;
	CALL SYMPUTX ('NOBS',NOBS);
run;	

%IF &NOBS GT 0 %THEN %DO;
 ** use + to mark censored value **;
proc format;
  value event
  0 = '+'
  1 = ' '
  ;
run;
%let trtfmt_=;

proc sql noprint;
	select trim(left(format)) into :trtfmt_
	from dictionary.columns
	where upcase(name) eq "&TRT" and memname eq "&inds" and libname eq 'WORK';
quit;

	  *** survival analysis ***;
ods output quartiles=qurt1(rename=(LowerLimit=LowerL  upperLimit=upperL));
ods output homtests=logrk1(rename=(probchisq=probch));

proc lifetest data=in_ outsurv=osurv1  method=km;
  strata &trt;
  time tim*event(0);
  format &trt &trtfmt_;
run;

%let nobs_=0;

%let cohortval=;		

%*------------------------------------------------
Big N
--------------------------------------------------;
proc sql noprint;
	select distinct count(*) into :nobs_
	from OSURV1 /*where survival>0;* and*/ where tim>0;
	select distinct put(&trt,&trtfmt_.) into :cohortval
	from OSURV1 ;
quit; 
		
%PUT &trt : &COHORTVAL;	
%*------------------------------------------------
Prepend Figure number and second title from &TRT
--------------------------------------------------;	
%let ttl1=Figure &tabno: &title1;
%put TTL1:&TTL1;

%let ttl2=%str(%trim(&cohortval)[N=%trim(&nobs_)]); 
%put &TTL2;
		

data _null_;
	set osurv1;
	if _N_=1 then call symput('legendtitle',vlabel(&trt));
	stop;
run;

%**override Legend looks like crap;
%let legendtitle=;
%put &LEGENDTITLE;
%let legendvalign=Top;
%let legendhalign=Right;

data osurv1;
  set osurv1;
  stratnum=_N_;
  *if survival>.;
  %if &showpct ne %then %do;
		  s=survival*100;
		  if nmiss(s)=0 and _censor_>0 then censor=_censor_*s;
		  else if _censor_=0 then censor=.;
		  else if _CENSOR_=1 then censor=0.1;
		 call symput('ylabel',"% of Patients");
		  label s= "% of Patients";
  		format s 3.0;
 %end;
 
run;


 ************ deal with censoring at tail **************;
proc sort data=osurv1;
  by &trt tim;
run;

data osurv2;
  set osurv1;
  by &trt tim;
  retain surv 1 ;
  if survival ne . then surv=survival;
  else surv=0;
 
run;

data &outds;
  set osurv2;
  %if &showpct ne %then %do;
		  if surv>. then s=surv*100;
		  else s=0;
		  label s= "% of Patients";
		  format s 3.0;
 %end;
 %else %do;
 		rename surv=s;
 		format surv 3.0;
 %end;


  trtn=&trt;
  format trtn cohortn.;
run;

title 'Survival Result';
proc print data=&outds; 
run;

  ******************************************************;
proc print data=qurt1;
run;

data med;
  set qurt1;
  if percent=50;
  LL=lowerL;
  UL=upperL;
  med=estimate;
  format med LL UL 4.0;
run;

%if %sysfunc(exist(work.logrk1))>0 %then %do;

	data pval;
	  set logrk1;
	  if test='Log-Rank';
	  pval=probch;
	  format pval 6.4;
	run;

%end;

proc sql noprint;
	select distinct &trt format=best. into :trt_1-:trt_999
	from &outds;
quit;

%let num_=&sqlobs;

%do i= 1 %to &num_;	
title "medians for cohort";
		proc sql;* noprint;
		  select med, LL, UL
		  into :med&i, :LL&i, :UL&i
		  from med
		  where &trt=&&trt_&i;
		quit;

%end;
%if &med1 eq %then %let med1=n/a;
%if &ul1 eq %then %let ul1=n/a;
%if &ll1 eq %then %let ll1=n/a;

%let pval=%str(p=n/a          );
%if %sysfunc(exist(work.logrk1)) >0 %then %do;

		proc sql noprint;
		  select 'p='||trim(put(pval,4.3)) into: pval
		  from pval;
		quit;
%end;	



proc contents data=&outds;
run;	
		
		options nodate nonumber;
		ods rtf file="..\figures\&out..rtf" style=projstyl.RTFSTYL notoc_data headery=725 footery=925;*bodytitle nokeepn notoc_data;
				
				options orientation=landscape 
								topmargin=1in
								bottommargin=1.0in
								missing=' ';
				
				title1 &RTFTITLE1;
				title2 &RTFTITLE2;
				footnote1 &RTFFOOTNOTE1 ;
				footnote2 &RTFFOOTNOTE2;
					
				ods graphics on;
				ods noptitle;
				data _null_;
					set &outds;
					file print ods=(template="Plot" dynamic =(showp="&showp"));
					put _ods_;
				run;
				ods graphics off;

		ods rtf close;
%END;

%mend;	