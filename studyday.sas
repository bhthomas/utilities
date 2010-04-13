%*------------------------------------------------
Sponsor:   Delcath

Program:			Studyday.sas(v9.1)
Protocol:     04C-273M

Purpose:			calculated relative study day

Parameters:	Date is a positional parameter


Author:       Bruce Thomas
Date:

Usage:				uses date of first dose dosedtn

History:


--------------------------------------------------;
%macro studyday(date,dosevar);
		%if &dosevar eq %then %let dosevar=dosedtn;
 		if &date>. and &date<&dosevar then studyday=&date-&dosevar;
	 	if &date>=&dosevar>. then studyday=&date-&dosevar+1;	
%mend;
