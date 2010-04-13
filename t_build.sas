%*-----------------------------------------------
Program:    t_build.sas

Purpose:    reads a lookup file with program names and launches the program

Author:		Bruce Thomas

Project:    Delcath Phase III

Inputs:     program names  in T_NUM_NUM2_NUM3_REST.sas form

Outputs:    reports in separate rtf files

Parameters:  	outds-- name of output dataset (default is T_BUILD)
			 				pgmpath -- required. path to programs to run to gether
			 				outpath_-- directory folder where you want to send reports
							type: Tables or Listings, corresponding to the excel worksheet label
							where: sas where clause
							config: full path to the excel lookup for the type
							
							
Usage:       open code OK. depends on ..\macro\reportRTF.sas

Revisions:
3/4/2010 BT dbsastype added to ensure char read in
---------------------------------------------------;

%macro t_build(
			type_=tables
			,config=%str(C:\projects\delcath\melmel\CONFIG\TABLES.XLS)
			,where= %str(where tabno is not missing)
			,outds=t_build
			,prgmpath=%str(F:\Data\Phase III data\Programs\To Delcath\Table pgm\tables)
			,outPath_=%str(C:\projects\delcath\melmel\output)
			,returnc=TEST
			);

**PGMPATH: location of table programs **;
**OUTPATH: Location of table outputs **;
**CONFIG : path to excel config file **;

LIBNAME METADATA  "&config" ver=2002 mixed=yes;

libname temp '..\config';

** Read in the desired tables from the configuration file**;
data temp.config(rename=(item=tabno));
	set metadata."&type_$"n(dbSAStype=(tabno=char5 f5=char3));
	length item $15;
	&where;;
 ITEM=tabno;*trim(left(tabno));
 if f5 ne '' then item=trim(left(item))||'.'||trim(left(f5));
	drop tabno;
run;

** include the programs **;
proc sql noprint;
		select trim(scan(program,1,'.')) into :prog1-:prog999
		from TEMP.CONFIG
		&where;;
quit;

%let nobs_=&sqlobs;

%do i_= 1 %to &nobs_;

%PUT PROCESSING: &&prog&I_ ;
proc printto log="&prgmpath.&&prog&i_...log" print="&prgmpath.&&prog&i_...lst" NEW;
run;

%let pgmname=&&prog&i_;
%include "&prgmpath.&&prog&i_...sas";

ods listing close;
%if %upcase(&type_) eq TABLES or %upcase(&type_) eq LISTINGS %then %do;
		%**include "..\macros\reportRTF.sas";
		%reportRTF(metadata=TEMP.config,outpath_=&outpath_\,pgm=&&prog&I_,type=&type_);
%end;


%if %upcase(&type_) eq FIGURE %then %do;
		%figRTF(metadata=TEMP.config,outpath_=&outpath_\,pgm=&&prog&I_,type=&type_);
%end;
ods listing ;

proc printto log=log print=print;
run;
%put  Program: &&prog&i_ Number in Sequence:&i_;
%put  RETURNED: CC:&syscc E:&syserr;
%let &returnc=%eval(&&&returnc + &syscc);
%end;
%fini:

LIBNAME METADATA CLEAR;



%mend;



