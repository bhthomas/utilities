%*------------------------------------------------
Sponsor:	

Program:	reportRTF.sas    
Protocol: 04C-273M

Purpose:	generate RTF reports

Inputs:
Outputs:

Parameters:   inds			input dataset for report (WORK DATASETS ONLY!)
							,metadata	 name of report config dataset	
												 containing titles, etc.
							,outpath_	
							,pgm			
							,type			
							,colmeta	 tables n= expression
							,bygroup   BY statement to sort with
									
             
Author:       Bruce Thomas			
Date:        11/7/2009 
             
Usage:

History:
12/9/2009 BT added span logic

--------------------------------------------------;
%macro reportRTF(
									 inds			=FINALB
									,metadata	=CONFIG
									,outpath_	=
									,pgm			=
									,type			=Table
									,colmeta	=
									,ORIENTATION=LANDSCAPE
									);


options nodate nonumber obs=max;

%*------------------------------------------------
GET PROGRAM-SPECIFIC TITLES FROM CONFIG DATASET
--------------------------------------------------;
%let table=;

proc sql noprint;
	create table CONFIG 
	as select * 
	from &metadata 
	where upcase(program) in ("%upcase(&outfile..sas)");
	select "&TYPE "||trim(TABNO)||": "||trim(left(title)) into:table 
	from CONFIG; 

quit;

%let table=%sysfunc(compbl(%quote(&table)));
%*------------------------------------------------
PORTRAIT OR LANDSCAPE?
--------------------------------------------------;

proc sql noprint;
	select  name into :orient_
	from dictionary.columns
	where libname eq 'WORK' and
	memname eq 'CONFIG' and
	upcase(name) like 'ORIENT%';
quit;

%if &sqlobs gt 0 %then %do;

		proc sql noprint;
			select &orient_ into:orientation
				from WORK.CONFIG
				where &orient_ is not null;
		quit;
	
%end;
%*------------------------------------------------
PICK UP  BYGROUP PARAMETER IF SPECIFIED IN CONFIG FILE
--------------------------------------------------;
%let byg=;
%let bygroup=;

proc sql noprint;
	select bygroup into :byg from CONFIG 
	where bygroup is not null;
quit;

%if &byg ne %then %let bygroup=%str( BY &byg;);

%*------------------------------------------------
GET GLOBAL TITLES AND FOOTNOTES FROM CALLING PROGRAM 
THESE APPEAR IN HEADERS AND FOOTERS ON THE OUTPUT RTF 
THEN A BLANK THEN THE REPORT TITLE
--------------------------------------------------;
title1 &RTFTITLE1;
title2 &RTFTITLE2;
footnote1 &RTFFOOTNOTE1 ;
footnote2 &RTFFOOTNOTE2;

*title3 " ";
*title4 .j=c &table;

/*  prints line under title before bygroup. not so hot
** Underline utility **;
%let ls=134;
%macro  line(ls);
put &ls*'_';
%mend;

*** apply 80% of the line **;
%let ul=;
%do i= 1 %to %eval(&ls*8/10);
%let ul=&ul._;
%end;

%if &byg ne %then %str(title5 .j=c  "&ul";);
*/

%*------------------------------------------------
GET FOOTNOTES FROM CONFIG DATASET 
--------------------------------------------------;
%let numfooters=0;

proc sql noprint;
	select  name into :footr1-:footr999
	from dictionary.columns
	where libname eq 'WORK' and
	memname eq 'CONFIG' and
	upcase(name) like 'FOOT%';
quit;

%*------------------------------------------------
PUT THESE FOOTERS IN COMPUTE BLOCK
iF THERE ARE ANY
--------------------------------------------------;
%let numfooters=&sqlobs;
%let ftnum=0;
%do ftr=1 %to &numfooters;
	proc sql noprint;
		select &&footr&ftr into:foot&ftr
		from WORK.CONFIG
		where &&footr&ftr is not null;
	quit;
	%let ftnum=%eval(&ftnum+&sqlobs);

%end;
%let numfooters=&ftnum;

%*------------------------------------------------
GET COLUMNS FOR REPORT FROM CONFIG DATASET
--------------------------------------------------;
%let NUMCOLS=0;

proc sql noprint;
		select  %quote(name)into :colname1-:colname999
		from dictionary.columns
		where libname eq 'WORK' and
					memname eq 'CONFIG' and
					upcase(name) like 'RC%';
quit;

%let cols=&sqlobs;

%do ci=1 %to &cols;

	proc sql noprint;
			select &&colname&ci into :col&CI 
			from WORK.CONFIG 
			where &&colname&ci ne '';
	quit;

	%let numcols=%eval(&numcols+&sqlobs);

%end;
%*------------------------------------------------
GET SPANNING COLUMN HEADERS FOR REPORT 
FROM CONFIG DATASET
--------------------------------------------------;
%let spans=0;
%let numspans=0;
proc sql noprint;
		select  %quote(name)into :span1-:span999
		from dictionary.columns
		where libname eq 'WORK' and
					memname eq 'CONFIG' and
					upcase(name) like 'SPAN%';
quit;
%let spans=&sqlobs;

%*------------------------------------------------
GENERATE LABELS FOR TABLES WHERE A TOTAL DATASET 
IS PROVIDED VIA &CONMETA
--------------------------------------------------;
%let lblstmt=;
%if &colmeta ne %then %do;

		*** read in COLMETA for this table to get the totals for C1-C9 **;
		data labels;
		  set &colmeta;
		  length labl $50;
		
		  select (trt);
		
		    when ('ALL')  do;col='C9' ;labl= 'All Groups |(N = '||trim(left(put(TOTN,best.)))||')';end;
		    when ('BAC')  do;col='C2' ;labl= 'Best Alternative Care |(N = '||trim(left(put(TOTN,best.)))||')';end;
		    when ('PHP')  do;col='C1' ;labl= ' | (N = '||trim(left(put(TOTN,best.)))||')';end;
				when('1') do;col='C1' ;labl= 'Neuroendocrine| Tumors | (N = '||trim(left(put(TOTN,best.)))||')';end;
				when('2') do;col='C2' ;labl= 'Primary |Hepatic |Malignancies | (N = '||trim(left(put(TOTN,best.)))||')';end;
				when('3') do;col='C3' ;labl= 'Adenocarcinoma|Of Gastrointestinal|And Other Origins | (N = '||trim(left(put(TOTN,best.)))||')';end;
				when('4') do;col='C4' ;labl= 'Melanoma| | (N = '||trim(left(put(TOTN,best.)))||')';end;
				
			otherwise;
			end;
		run;
		
		proc sql noprint;
			select "label "||col||"='"||trim(labl)||"';" into :lblstmt separated by ' '  from labels ;
		quit;
		
%end;
%else %do;
		** NULL **;
		data labels;
		labl='Testing';
		run;

%end;

%*------------------------------------------------
APPLY COLMETA LABELS IF THEY EXIST 
(NOT USUALLY IN LISTINGS)
--------------------------------------------------;
data report;
		set &inds ;
		&lblstmt;
		*label itema=' ';
		
run;

%*------------------------------------------------
DEFAULT NUMBER OF REPORT ROWS
--------------------------------------------------;
%let countr=10;
proc sql noprint;
	select rows into :countr from CONFIG where rows is not null;
quit;

%*------------------------------------------------
 GET COLUMNS FROM REPORT DATASET THAT ARE 
 IN SORT ORDER. IF NONE THEN SORT BY BYGROUP
 IF IT S PASSED IN.
 THEN CALCULATE PAGE BREAKS
--------------------------------------------------;
%let names_=;
%let numnames=0;

		proc sql noprint;
		create table tst as 
						select name ,sortedby from dictionary.columns 
						where libname eq 'WORK' and memname eq "%upcase(&INDS)" 
						and sortedby >0
						order by sortedby;
					select name into :names_  separated by ' ' from tst;
		quit;
		
		%put Sorted by NAMES: &names_;
		%let numnames=&sqlobs;
		
	options nobyline ;

%if &numnames eq 0 %then %do;
		%if &bygroup ne %then %do;
			
				proc sort data=report;
					&bygroup;
				run;
	
				data report;
						set report;
						&bygroup;
						if _n_=1 then counter=0;
						counter+1;
						if first.&byg or counter >&countr then do;
								mypage+1;
								counter=1;
						end;
				run;	
				
		%end;
		%else %do;
		
				data report;
				   set report;
				   if _n_=1 then counter=0;
				   counter+1;
				   if counter >&countr then do;
				   mypage+1;
				   counter=1;
				   end;
				   
				run;
				
		%end;

%end;
%else %do;

		%let bygroup=%str(by &names_;);
		%let byg=%scan(&bygroup,2);%** skip over keyword BY;
		data report;
		   set report;
		   &bygroup;
		   if _n_=1 then counter=0;
		   counter+1;
		   if first.&byg or counter >&countr then do;
				   mypage+1;
				   counter=1;
		   end;
		run;	

%end;

%*------------------------------------------------
JUSTIFICATION AND COLUMN WIDTHS FOR RTF
--------------------------------------------------;
%if &numcols ge 10 %then %let maxwidth=1200;
%else %let maxwidth=1100;
%do ri= 1 %to &numcols;
%put processing: &&COL&RI;

	%let w=%scan(&&col&ri,2,' ');
	%let lbl&ri="";

	proc sql noprint ;
			select '"'||trim(left(label))||'"'  into :lbl&ri 
			from
			dictionary.columns where libname eq 'WORK' and memname eq 'REPORT' 
			and upcase(name) in ("%upcase(%scan(&&col&ri,1))");
			quit;
	
		** 0RDER FOR VARIABLES WITH WIDTH=0;		
		%if &w eq 0 %then %let disp&ri=order order=internal noprint;
		%else %let disp&ri=display;
		%if &ri eq 1 and &w eq %then %Do;
		   **dEFAULT WIDTH FOR COLUMN1;
			%let cw&ri=60;
		%end;
		%else %if &ri ne 1 and &w eq %then %let cw&ri=10;
		
		%else %if &w ne %then %let cw&ri=%eval(&w*&maxwidth/100);
		%let j=%scan(&&col&ri,3);
		%let j&ri=&j;
		
		%if &&j&ri eq %Then %let j&ri=c;
		%put &&col&ri &&lbl&ri cellwidth =&&cw&ri;

%end;

%*------------------------------------------------
FORMAT THE BYLINE IF THERE IS ONE. THIS WILL GO
INTO THE REPORT BODY
--------------------------------------------------;
%let byfmt=;
%let bylabel=;
%let bygp_=;** Use for proc report by grouping;

** BYGROUP MUST HAVE SAME NAMES FOR VARIABLE AND FORMAT<EG COHORTN **;

%if &byg ne %then %do;
		proc sql noprint;
				select distinct trim(propcase(label)) into:bylabel 
				from dictionary.columns
				where libname eq 'WORK' and memname eq 'REPORT' and 
							upcase(name) eq "%upcase(&byg.)";
		
				select trim(left(coalesce(compress(format,'.'),"$100"))) into:bygfmt 
				from dictionary.columns
				where libname eq 'WORK' and memname eq 'REPORT' and 
							upcase(name) eq "%upcase(&byg.)";
		quit;
		
		%put &BYgFMT=;
		%if &bygfmt ne %then %let byfmt=format &byg %trim(&bygfmt.).;
				
		%let bygfmt=%trim(&bygfmt.).;
		%let _title5="^R/RTF'\brdrb\brdrs\brdrw15\ql \b\fs20 ' %trim(&bylabel):  " &byg  %trim(&bygfmt.);
		%let bygp_=%str(by &byg.;);

%end;

%*------------------------------------------------
See if there are observations
--------------------------------------------------;
%let nobs=0;

proc sql noprint;
   select distinct nobs into:nobs
   from dictionary.tables where libname eq 'WORK'
   and memname eq 'REPORT';
quit;   

%*------------------------------------------------
APPLY ALL THIS MACRO TO A REPORT STEP
--------------------------------------------------;

ods rtf file="&outpath_.&outfile..rtf" style=projstyl.RTFSTYL notoc_data headery=725 footery=925;*bodytitle nokeepn notoc_data;

options orientation=&ORIENTATION
				topmargin=1.0in
				bottommargin=0.5in
				missing=' ';
				
/*  this was for BODYTITLE, but My knowledge of rtf inline is kind of limited
%let _title1= "^R/RTF'\brdrb\brdrs\brdrw15\ql\b\fs24 '  Systems Inc. - DSI 04-C-0273M ^R/RTF'\tab\tab\tab\tab\tab\tab\tab\tab\tab' %sysfunc(date(),date9.)    %sysfunc(time(),time5.)  ";
%let _title2= "^R/RTF'\brdrb\brdrs\brdrw15\ql\b\fs24 ' DSI MEPHALAN Melanoma ^R/RTF'\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab\tab' Page ^{pageof}";
%let _footer1= "^R/RTF'\brdrb\brdrs\brdrw15\ql\ 'Program: ^R/RTF'\tab' &pgmname..sas"; 
%let _footer2= "^R/RTF'\brdrb\brdrs\brdrw15\ql\ 'File:          ^R/RTF'\tab' &outfile..rtf"; ;
*/

%let _title3= "^R/RTF'\b\fs20 ' &table";

%if %upcase(&orientation) eq LANDSCAPE %then %do;
		%if &numcols gt 7 %then %let ls=160;
		%else %let ls=155;
		%let outputwidth=9.5in ;
%end;
%else %do;
	%let ls=80;
	%let outputwidth=6.5in ;
%end;

%if &nobs gt 0 %then %do;

proc report  data=report nowd headline  headskip nofs 
		missing ls=&ls ps=%eval(&countr*5) split='|' list 
		style(report)={asis=on protectspecialchars=off outputwidth=&outputwidth}
;
		COLUMNS mypage 
		%do ri= 1 %to &numcols;
				%scan(&&col&ri,1)
		%end;  ; 
		&bygp_;
		&byfmt.;
		define mypage /order  noprint;
		*define counter/display ' ' style(column)={cellwidth=80};
		%do ri= 1 %to &numcols;
					%if &ri eq 1 %then %do ; 
								define %sysfunc(compress(%scan(&&col&ri,1))) 
								/&&disp&ri flow width=40 	&&lbl&ri style(header)={just=&&j&ri} 
																				style(column)={cellwidth=&&cw&ri just=&&j&ri };
					%end;
					%else %do; 
								define %sysfunc(compress(%scan(&&col&ri,1))) 
								/&&disp&ri  &&lbl&ri  width=20 style(column)={cellwidth=&&cw&ri just=&&j&ri} style(header)={just=&&j&ri} ;
					%end;
		%end;
		
		compute before _page_;
				line '^R/RTF"\brdrt\brdrs\brdrw15\ {\qc\b\ "' &_title3 ;
				line  '^R/RTF"\qc\b\ \cell}{\row}\trowd\trkeep\trhdr\trqc\trgaph20\cltxlrtb\clvertalb\cellx12330\pard\plain\intbl\keepn\b\sb20\sa20\ql\f1\fs18\cf1 "';
				%if &byg ne %then %do;
						line   %sysfunc(compbl(&_title5));
				%end;
		endcomp;
		
		compute after mypage;
				line @1 "  ";
				%if &numfooters gt 0 %then %do;
				line @1 "_______________________________________________________";
				%do ftr=1 %to &numfooters;
					line "^R/RTF'\TAB ' &&foot&ftr";
				%end;
				*line  &_footer1;
				*line &_footer2;
				**line " ";
				%end;
				line '^R/RTF"\brdrt\brdrs\brdrw15"';
		endcomp;

		break after mypage/ PAGE;
		
run;
%end;
%else %do;
data test;
Message="No Observations to Report in this dataset." ;
run;
proc report  data=test nowd headline  headskip nofs  missing ls=&ls ps=45 split='|' list 
style(report)={asis=on protectspecialchars=off outputwidth=9.5in};
columns message;
define message /display " " ;
		compute before _page_;
				line '^R/RTF"\brdrt\brdrs\brdrw15\ {\qc\b\ "' &_title3 ;
				line  '^R/RTF"\qc\b\ \cell}{\row}\trowd\trkeep\trhdr\trqc\trgaph20\cltxlrtb\clvertalb\cellx12330\pard\plain\intbl\keepn\b\sb20\sa20\ql\f1\fs18\cf1 "';
				%if &byg ne %then %do;
						line   %sysfunc(compbl(&_title5));
				%end;
		endcomp;run;

%end;
ods rtf close;

%fini:

%put RETURNING: &SYSERR;

%mend;



