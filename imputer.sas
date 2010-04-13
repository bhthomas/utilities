%*------------------------------------------------
Sponsor:   	Delcath

Program:	  imputer.sas
Protocol:     04C-273M


Purpose:		imputes a date from character to sas
Author:	`		Bruce Thomas

Parameters:		inds=input dataset
							chardate=name of character variable
							numdate=name of imputed SAS date
							outds=output dataset	

Author:       Bruce Thomas
Date:

Usage:				assumes CHARDATE IN YYYYMMDD form

History:


--------------------------------------------------;

%macro imputer(inds=,chardate=, numdate=,outds=);	

	data &outds;
	   set &inds;
	   length imputed $3;
	   imputed='';
	__yyc=substr(&chardate, 1, 4);
	__mmc=substr(&chardate, 5, 2);
	__ddc=substr(&chardate, 7, 2);
	if __yyc ne '' then __yy=input(__yyc, 4.);
	if __mmc ne '' then __mm=input(__mmc, 2.);
	if __ddc ne '' then __dd=input(__ddc, 2.);
	if __yy ne . then do; * imputing missing month and day part;
	
		if __mm=. then do;
		imputed=trim(imputed)||'M';
			  __mm=7; __dd=1;
		end;
		else if __mm ne . and __dd=. then do;
				__dd=15;
				imputed=trim(imputed)||'D';
		end;
		&numdate=mdy(__mm, __dd, __yy);
	end;
  drop __mm __dd __yy __YYC __mmc __ddc;
  format &numdate date9.;
  run; 
%mend;