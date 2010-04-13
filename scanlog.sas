%*--------------------------------------
Macro:   SCANLOG.SAS 

Author:	 Bruce Thomas, SGEN
Date:    Feb 02,2006
Purpose:  Scan logs for QC

Usage:    PC SAS Version 9, open code OK

Parameters:  
		PGM    =  location of program log
		Level  =1 (default)-  (maximum)
        Outfile=  name of output file to
				  hold scan results

Output:  Lines containing scan results.
         if blank, goes to sas log.

Revisions:
	

----------------------------------------;
%macro scanlog(log=,level=16);

options mprint;

%put ;
%put *** SCANNING LOG=&log (level=&level) ***;
%put ;
%put *** %sysfunc(date(),worddate.)***;
%put;
%let N_=0;
%if &level= %then %let level=16;

%if %sysfunc(fileexist(&log)) gt 0 %then %do;
	%*----------------------------------
	Add words to parse for, based on level
	------------------------------------;
	%let i_=0;
	%let string_=;
	%let errstr= _\bError\b uninitialized \bwarning\b duplicate missing_values not_found invalid_argument lost_card has_not_been_compiled fatal invalid converted  More_than_one overwritten truncated repeats_of_by note;
	%do %until (%eval(&i_=&level));
		%let i_= %eval(&i_+1);
		%if %scan(&errstr,&i_) ne %then %let string_=&string_.|%scan(&errstr,&i_);
	%end;

	%let string_=%sysfunc(translate(&string_,' ','_'));

	%let string_=%substr(&string_,2);
	%put &string_;

	%*---------------------------------
	use PRXPARSE to find log problems
	-----------------------------------;

	data _null_;
		infile "&log" lrecl=10000 end=eof;
		input;
		if _n_= 1 then do;
	   		retain patternID n_ 0;
	         /* The i option specifies a case insensitive search. */
	      	pattern = "/&string_/i";
	      	put;
	      	put 'Search pattern = ' ;
	      	put pattern;
	      	put;
	      	patternID = prxparse(pattern);
    	end;
 		call prxsubstr(patternID, _INFILE_, position, length);
		if position ^= 0 then   do;
	  		match = substr(_INFILE_, position, length);
	  		infile=trim(left(_INFILE_));
	 		put  "line:" _n_  "--->  " infile: $QUOTE.;
   	  		n_=n_+1;
  		end; 
    	call symput('N_',trim(left(put(n_,best.))));
		if eof then do;
       		call prxfree(patternid);
       		put;
       		put;
		end;
	run;

%end;

%put;
%put Completed SCAN of &log: there were &N_ occurrences;
%put;
%*USAGE: scanlog(log=logfilename.log,level=6);

%mend;






