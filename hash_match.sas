%*-------------------------------------------------------------
Sponsor:   		Delcath

Program:			hash_match.sas

Protocol:     C:\projects\delcath\phase2\programs\


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
								keynames=pt invsite,
								varnames=age gender,
								out=MATCH,
								nonmatch=NOMATCH,
								small=WORK.SMALL,
								large=LARGE,
								hashdim=0
								);
								
%let tst=0;
%let scan=DUMMY;
%do %while(&scan ne  );
	%let tst=%eval(&tst+1);
	%let scan=%trim( %scan(&keynames,&tst));
	%if &scan ne %then %do;
				%*------------------------------------------------
				Quoting is kind of picky here
				--------------------------------------------------;
			%if &tst gt 1 %then  %let keys= "%trIM(&keys)%str(,)%bquote('&scan')";
			%else %let keys=%bquote('&scan');
	%end;	
%end;

%let tst=0;
%let scan=DUMMY;
%do %while(&scan ne  );
	%let tst=%eval(&tst+1);
	%let scan=%trim( %scan(&varnames,&tst));
	%if &scan ne %then %do;
			%*------------------------------------------------
			More quoting strangeness
			--------------------------------------------------;
			%if &tst gt 1 %then  %let vars= "%trim(&vars)%str(,)%bquote('&scan')";
			%else %let vars=%bquote('&scan');
	%end;	
%end;

data _null_;
file "generated_code.sas";
put "DATA &out(drop= dsn x ) &nonmatch;";
put "	set &small (obs=1);";
put	" retain dsn '&small' x &hashdim;";
put '	dcl hash hh (dataset: dsn,hashexp:x);';
put "	hh.DefineKey(" &keys ");";
put "	hh.DefineData(" &vars	");";
put ' hh.DefineDone ();';
	
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
%sysexec(del generated_code.sas);
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
data small;
	set derived.xdemog(keep= age gender pt mitt invsite);
	where mitt='N';
run;

%let small=work.small;
%let large=derived.xlb(keep=pt lbtest testdt cycle lbvalchr invsite);

options mprint;

%hash_match(large=&large,small=&small);			  
*/