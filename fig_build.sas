%*-----------------------------------------------
Program:    fig_build.sas

Purpose:    reads a lookup file with program names 
						and converts rtf to pdf

Author:			Bruce Thomas

Project:    Delcath 

Inputs:     program names  in T_NUM_NUM2_NUM3_REST.sas form

Outputs:    rtf reports saved in TARGET as separate pdf files

Parameters:  	outds-- name of output dataset (default is T_BUILD)
			 				pgmpath -- required. path to programs to run to gether
			 				outpath_-- directory folder where you want to send reports
							type: Tables or Listings, corresponding to the excel worksheet label
							where: sas where clause
							config: full path to the excel lookup for the type
							
							
Usage:       open code OK. depends on ..\macro\reportRTF.sas

Revisions:
3/4/2010 BT dbsastype added to ensure char read in
4/1/2010 BT wrapper for rtf2pdf macro.
---------------------------------------------------;

%macro fig_build(
			type_=figures
			,config=%str(C:\projects\delcath\melmel\CONFIG\TABLES.XLS)
			,where= %str(where number)
			,outds=pdf_build
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
%*------------------------------------------------
RTF Style here
--------------------------------------------------;
filename styls "..\styles\styles.sas";
%inc styls;
%styles;
filename styls clear;

%do i_= 1 %to &nobs_;

%PUT PROCESSING: &&prog&I_ ;
proc printto log="&prgmpath.&&prog&i_...log" print="&prgmpath.&&prog&i_...lst" NEW;
run;

%include "&&prog&I_...sas";
run;
proc printto log=log print=print;
run;

%put  Program: &&prog&i_ Number in Sequence:&i_;
%put  RETURNED: CC:&syscc E:&syserr;
%let &returnc=%eval(&&&returnc + &syscc);
%end;
%fini:

LIBNAME METADATA CLEAR;



%mend;



