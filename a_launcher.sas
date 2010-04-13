%*-------------------------------------------------------------
Sponsor:   		Delcath

Program:			a_launcher.sas

Protocol:     C:\projects\delcath\Phase III\import\


Purpose:			build datasets from ASCII files

Inputs:				*.dat files in .../\data/ascii

Outputs:			sas7bdat files in ..\data\current


Author:       Bruce Thomas
Date:	             04/13/10


Usage:				requires *.sas programs in current directory
							to read and write data

History:



-----------------------------------------------------------------;
%*------------------------------------------------
Now, compare with what is in the data directory
..\data vs ..\data\current
--------------------------------------------------;
%macro compare;
	libname base '..\data';
	libname compare '..\data\current';
	libname library '..\formats';
	
	proc sql noprint;
		select distinct a.memname into :mem1-:mem999
		from ((select distinct memname from 
					dictionary.tables
					where libname eq 'BASE')a
					inner join
					(select distinct memname from 
					dictionary.tables
					where libname eq 'BASE') b
					on a.memname=b.memname);
	quit;
	%let num_=&sqlobs;
	%do i= 1 %to &num_;
	proc sort data= base.&&mem&i out=base;
		by _ALL_;
	run;
	proc sort data= compare.&&mem&i out=compare;
		by _ALL_;
	run;	

	title "Dataset Comparison for &&mem&i";
	title2 "Base=..\data compare=..\data\compare";
			proc compare base=base compare=compare out=result  
					outnoequal outbase outcomp outdif noprint;
				id PID INVSITE ;
			run;
			
			data cresult(keep=m _OBS_ _TYPE_ var pid varname invsite);
				set result(where =(_TYPE_='DIF'));
				array chr(*) _CHARACTER_;
				length var $40 varname $10;
				 n=_N_;
				 put n=;
				do i= 1 to dim(chr);
					if index(chr(i),'X')>0 then do;
						set result point=n; 
						put chr(i)=;
						var=chr(i);
						m=n;
						varname=vname(chr(i));
						output;
					end;	
				end;
			run;
			
			title3 "Character Variable Differences";
			proc print data=cresult;
			run;
			
			data ndif nbase ncmpare;
				set result;
				array nm(*) _NUMERIC_;
				do i= 1 to dim(nm);
					if index(nm(i),'E')=0  then do;
						put nm(i)=;
						var=nm(i);
						varname=vname(nm(i));
						format=vformat(nm(i));
						if varname ne '_OBS_' then do;
								if _TYPE_='DIF' then output ndif;
								if _TYPE_='BASE' then output nbase;
								if _TYPE_='COMPARE' then output ncmpare;
						end;	
					end;
				end;
				keep _OBS_ _TYPE_  var pid varname format invsite;
			run;		

			proc sort data=ndif;
				by pid invsite _OBS_ varname;
			run;	
			proc sort data=nbase;
				by pid invsite _OBS_ varname;
			run;	

			proc sort data=ncmpare;
				by pid invsite _OBS_ varname;
			run;	

			data numerics;
				merge nbase(rename=(var=base)) ndif(in=indif rename=(var=diff)) ncmpare(rename=(var=compare));
				by pid invsite _OBS_ varname;
				if indif;
				drop _TYPE_;
			run;
			
			title3 "Numeric Variable Differences";
			
			proc print data =numerics;
			run;
	%end;

%mend;
%compare;					
endsas;
%*------------------------------------------------
Make sure that librefs in all the programs are
defined the same way.
e.g. libname dataset '..\data\current'

Also make sure that the infile statements use the 
correct path for the ascii data:
e.g. infile '..\data\ascii\S06_C_0088_AEAEAE.dat'

--------------------------------------------------;

%*------------------------------------------------
Get the programs to read in ASCII files and
create datasets.
--------------------------------------------------;
filename in pipe "dir /B *.sas";
data in;
	infile in missover;
	input ;
		in=trim(left(_INFILE_));
		if index(IN,"Convert") or index(IN,'keyvars') or
		index(IN,'launcher') then delete;

run;

data _null_;
	set IN; 
	call execute("%include '"||trim(left(IN))||"';");
	put 'Processing: ' IN;
run;

%let result=&syscc;
%put Run Result: &result;

%*------------------------------------------------
Now, run ConvertToRealName.sas
--------------------------------------------------;
%macro test(reslt=&result);
	
	%if &reslt eq 0 %then %include 'ConvertToRealName.sas';
	
%mend;	
%test;

