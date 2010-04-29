%*-------------------------------------------------------------
Sponsor:   		

Program:			hash_match.sas

Protocol:     general


Purpose:			Combines small and large datasets on common keys
							without sorts.  Uses Version 9 Data Step Component
							Interface. 	

Inputs:				SMALL dataset containing the names of the keys 
							(KEYNAMES) to match a LARGE dataset with and 
							'satellite' VARNAMES to add to the LARGE dataset
Depends:

Outputs:			OUT dataset containing matches
							optional NONMATCH dataset containing non nmatching records.
							generated code in the current directory named 'generated_code.sas'

Parameters:   HASHDIM indicates how many hash 'buckets'
						  will be created in memory  e.g. 10=2**10=1024.  These will
						  each contain a  


Author:       Bruce Thomas, from Dorfman et.al., SUGI30
Date:	             04/06/10


Usage:

History:



-----------------------------------------------------------------;
%macro hash_match(
								keynames=pt ,
								varnames=age gender,
								out=MATCH,
								nonmatch=NOMATCH,
								small=WORK.SMALL,
								large=LARGE,
								hashdim=16,
								keepCode=0,
								order=no  /** no, a or d **/
								);
								
%if %upcase(&keynames) ne ALL %then %do;
%let tst=0;
%let scan=DUMMY;
%do %while(&scan ne  );
	%let tst=%eval(&tst+1);
	%let scan=%trim( %scan(&keynames,&tst));
	%if &scan ne %then %do;
				%*------------------------------------------------
				Quoting is kind of picky here
				--------------------------------------------------;
			%if &tst gt 1 %then  %let keys= %trIM(&keys)%str(,)%bquote('&scan');
			%else %let keys=%bquote('&scan');
	%end;	
	
%end;
%let keys="&keys";
%end;
%else %let keys="all:'yes'";

%if %upcase(&varnames) ne ALL %then %do;
%let vars=;
%let tst=0;
%let scan1=DUMMY;
%do %while(&scan1 ne  );
	%let tst=%eval(&tst+1);
	%let scan1=%trim( %scan(&varnames,&tst));
	%**put TST : &tst SCAN1: &scan1;
	%if &scan1 ne %then %do;
			%*------------------------------------------------
			More quoting strangeness
			--------------------------------------------------;
			%if &tst gt 1 %then  %let vars= %trim(&vars)%str(,)%bquote('&scan1');
			%else %let vars=%bquote('&scan1');
	%**PUT VARS: &vars;
	%end;	
%end;
%let vars="&vars";
%end;
%else %let vars="all:'yes'";
%PUT KEYS: &keys  DATA VARS: &vars;

data _null_;
file "generated_code.sas";
put "DATA &out(drop= dsn x ) &nonmatch;";
put	" retain dsn '&small' x &hashdim ordr '%lowcase(&order)';";
put "	if _n_=1 then do;";
put "if 0 then 	set &small (obs=1);";

put ' dcl hash hh (dataset: dsn,hashexp:x, ordered:ordr);';
put "	hh.DefineKey(" &keys ");";
put "	hh.DefineData(" &vars	");";
put ' hh.DefineDone ();';
put 'end;';
/*put '	do until (eof1);';
put "		  set &small end=eof2;";
put '		  rc= hh.add();';
put '	end;';
*/
put '	do until (eof2);';
put "		  set &large end=eof2;";
put '		  if hh.find()=0 then output match;';
%if &nonmatch ne %then  %str(put "		  else output &nonmatch;";);
put '	end;';
put '	stop;';
put 'run;';
run;

%*------------------------------------------------
OK, get the code
--------------------------------------------------;
%include generated_code;
%if &keepcode eq 0 %then %sysexec(del generated_code.sas);
%mend;
%*------------------------------------------------
Usage:
--------------------------------------------------;
/*
%inc param;
%*------------------------------------------------
Demo speedy match using direct addressing
in Data step component interface.
--------------------------------------------------;
proc sort data= derived.xdemog(keep= age gender pt mitt invsite) out=small;
	by gender age;
run;

%let small=work.small;
%let large=derived.xlb(keep=pt lbtest testdt cycle lbvalchr invsite);

options mprint nomlogic nosymbolgen;
%*------------------------------------------------
add small dataset vars to large dataset
on key=pt
--------------------------------------------------;
%hash_match(large=&large, /** larger dataset: all variables will be kept* **/ 
						small=&small, /**smaller dataset,usually a lookup :all variables will be kept**/
						out=MATCH,    /**outputs a dataset named MATCH (required)**/
						nonmatch=,    /** optional name of all other dataset**/
						varnames=all, 			/** variable names to store in the hash object. Not needed yet**/
						order=no,       /** order of the has output dataset **/
						keynames=pt,   /** keys in order of use for lookup**/
						keepcode=1     /** keep generated_code.sas 1=yes 0=no**/
						);			  
*/