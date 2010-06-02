***********************************************;
* CONVERTER.sas                                 *;
* description: COnvert FILETYPE outputs to PDF*;
***********************************************;
%let filetype=tables;** has to correspond to worksheet tab;

data start ;
Message="   START of Program %sysfunc(datetime(),datetime24.)  ";
run;

proc print data=start noobs;
run;

%let pgmname=PDFs;
%let outfile=PDFs;
%LET DATASOURCES=;

%inc param;;
%global test;

options mprint mprintnest;

%*------------------------------------------------
Read config worksheet, get FILETYPE tab programs
that have NUMBER ne missing.
--------------------------------------------------;
%pdf_build(
			type_=&filetype
			,config=%str(..\CONFIG\PhaseII.XLS)
			,where= %str(where number is not missing)
			,outds=x_build
			,prgmpath=C:\projects\delcath\phase2\&filetype\
			,outPath_=C:\projects\delcath\phase2\tests\
			,returnc=TEST
			
			);

title;
data end ;
	
Message="Returned: &TEST  End of Program: %sysfunc(datetime(),datetime24.)  ";
run;

proc print data=end noobs;
run;
*---*---*---*---*---*---*-->>>>    End of Program    <<<<--*---*---*---*---*---*---*;


