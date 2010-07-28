%*----------------------------------------------------------------
Program Name:		dataDictionary.sas

Project:		General

purpose:		create a PDF Table of contents linked to
			basic frequencies for Discrete Vars
			and distributions and boxplots for
			Continuous vars
			
inputs:			&DSLIB  = library
			&DSNAME = dataset name

author:			Bruce Thomas

usage:			have to %INCLUDE as this is a collection
			call:
			%dictionary(dslib=,dsname=,keepf=,dropf=,dropc=,title=,phi=)

revisions:

7/23/2010- BT Dropped InsetGroup from plot , lengthen VARLABEL
7.29.2010 BT Added error trapping to missing routine for all missing values
of key, now reading freq output to add frequencies for 5 highest and 5 lowest.
Also added where >0 to boxplot for better imaging.  ADded imaging improvement
to exclude outliers.
------------------------------------------------------------------;

***********************MACROS**************************************************;

%macro frqs(inds=inds_,contents=contents,typevar=Discrete);

	**********************************************************;
	** Regular Discrete categorical vars**;
	**********************************************************;

	proc sql noprint;
	   create table cont_ as 
	 	select * from &contents 
		where trim(typevar) eq "&typevar";		
	   select count(*),lowcase(name),format 
	   	into :num_,:name1-:name999, :fmt1-:fmt999 
	    	from cont_; 
	   drop table cont_;	
	quit;

	%do i= 1 %to &num_;
		%put Variable: &&name&i FORMAT: &&fmt&i;

		ods pdf anchor="&&name&i" startpage=now;
		ods proclabel="&&name&i";

		proc freq data=&inds page;
		tables &&name&i/list missing;
		title3 "Frequencies for Variable: &&name&i";
		%if &&fmt&i ne  %then %str(format &&name&i &&fmt&i;);
		run;
		
		ods pdf text="^S={just=C URL='#contents'}Return to Contents ";
	
	%end;

%mend;

%macro missrange(inds=dropds_,contents=contents,typevar=Range);

	**********************************************************;
	** Long Discrete Variables top and bottom 5 and Missings**;
	**********************************************************;

	proc sql NOPRINT;
	   create table cont_ as 
		select * from &contents 
		where typevar eq "&typevar";		
	   select count(*),lowcase(name),label,format,type 
		into :nm_,:nme1-:nme999,:lbl1-:lbl999,:fmt1-:fmt999 ,:typ1-:typ999
		from cont_; 
	   drop table cont_;	
	quit;

	%do i= 1 %to &nm_;
		%put Variable: &&nme&i FORMAT: &&fmt&i &&typ&i;
	
	        ods pdf anchor="&&nme&i" startpage=now;
		ods proclabel="&&nme&i";

		proc freq data =&inds NOPRINT;
		tables &&nme&i /list nofreq nopct nocum out=frq_;
		where &&nme&i is not missing;
		run;
		
		data top bot;
		** Initialize**;
		if 0 then set &inds(keep=&&nme&i);
			if _n_=1 then do;
				dcl hash h(dataset:"frq_ ",ordered:'A');
				h.defineKey("count");
				h.defineData("&&nme&i",'count');
				h.defineDone();
				call missing (&&nme&i,count);
				declare hiter hi('h');
			end;
			**Iterate top 5**;
			hi.first();
			do i = 1 to 5 until (rc ne 0);
				output bot;
				rc=hi.next();
			
			end;
			
			**Iterate bottom 5**;
			hi.last();
			do i = 1 to 5 until (rc ne 0);
				output top;
				rc=hi.prev();
			end;
			drop i rc;
			stop;**prevent Looping;
		run;
		%let nummiss=;
		%let allobs=;
	
	         proc sql noprint;
		   select count(*) "# Missing for &&nme&i" into :nummiss
			from &inds
			where &&nme&i is missing;
		   select trim(left(put(count(*),best.))) 
		   	into :allobs from &inds;
		quit;
		
		data &&nme&i;
			length var $10 varlabel $200 desc $20;
			retain var "&&nme&i" varlabel "&&lbl&i";
			set top (in=in1) bot (in=in2) ;
			if in1 then desc='Highest 5';
			if in2 then desc='Lowest 5';
			label var="Variable Name" varlabel="Variable Label" desc='Description ';
			rename &&nme&i=value;
			%if &&fmt&i ne  %then %str(format &&nme&i &&fmt&i;);	
		run;
		title3 "Ranges For Variable: &&nme&i";
		title4 " &&lbl&i ";
		title5 "Missing values : &nummiss / &allobs";
		
		proc print data=&&nme&i label noobs;
		var desc value count;
		run;
		
		
		ods pdf text="^S={just=C URL='#contents'}Return to Contents ";
	%FINI:
	%end;

%mend;

%macro conts(inds=conds_,contents=contents,typevar=Continuous,showinset=);

	**********************************************************;
	**Continuous Variables add boxplot                      **;
	**********************************************************;

	proc sql NOPRINT;
	   create table cont_ as 
		select * from &contents 
		where typevar eq "&typevar";		
	   select count(*),lowcase(name),label 
	   	into :nm_,:nme1-:nme999,:lbl1-:lbl999 
	   	from cont_; 
	   drop table cont_;	
	quit;

	%do i= 1 %to &nm_;

	**********************************************************;
	**Basic distribution Statistics                         **;
	**********************************************************;
		proc means data=&inds nway noprint;
			var &&nme&i;
			output out=&&nme&i n=n mean=mean std=std median=median 
					q1=q1 q3=q3 p10=p10 p90=p90 min=min max=max;
				
		run;
	
		data &&nme&i;
			length var $10 varlabel $200;
			retain var "&&nme&i" varlabel "&&lbl&i";
			set &&nme&i;
			label var="Variable Name" varlabel="Variable Label"
			n= "N" mean="mean" median="Median" std="Standard Deviation"
			q1="Q1" q3="Q3" P10="P10" p90="P90" min="Minimum" max="Maximum";
			drop _:;
			format mean std 6.2;	
		run;

		
		ods pdf anchor="&&nme&i"  startpage=now;
		ods proclabel="&&nme&i";
		title3 "Distribution for &&lbl&i";
		footnote3 ' ';
		
		proc print data=&&nme&i;
		run;
		
		ods pdf text="^S={just=C URL='#contents'}Return to Contents ";
		*** take out extremes to improve visualization **;
		%let upperlimit=;
		proc sql noprint;
		select round(mean+(2*std),1) into :upperlimit
		from &&nme&i;
		quit;
		ods pdf startpage=NO;
		goptions interpol=boxt device=pdfc;
		
		axis1	label=(height=1.25 "&&lbl&i" )
			minor=(number=1);
		axis2	label=(height=1.25 'excludes missing and >+2SD' );
		symbol	value=dot
			height=0.5;
			
		proc boxplot data=&inds;
			plot &&nme&i*dummy/ vaxis=axis1
						haxis=axis2;
		where &&nme&i gt 0 and &&nme&i le &upperlimit;;
		*	insetgroup mean stddev  q1 q3 min  max / format=6.2 header="Statistics : &&nme&i" pos=top;
		run;			
		
		

	%end;
%mend;

%macro dictionary(
	 dslib = WORK		/** Optional Libname 				**/
	,dsname=		/** Dataset to document				**/
	,keepf = _ALL_		/** List of vars for basic frequencies		**/
	,dropf =		/** list of LONG Discrete vars, e.g. dates 	**/
	,dropc = 		/** list of continuous variables 		**/
	,title = Data Dictionary /** Title for Page 1 				**/
	,phi   = 		/** Protected information do not show 		**/
	);

data inds_ ;
set &dslib..&dsname(keep=&keepf);
drop &dropf &dropc &phi;
run;

data dropds_;
set &dslib..&dsname(keep=&dropf);
%if &dropf eq %then %str(drop _ALL_);
run;

******************************************************;
*** Distributions for continuous vars              ***;
******************************************************;

data CONDS_ ;
set &dslib..&dsname(keep=&dropc);
%if &dropc eq %then %str(drop _ALL_;);
run;

******************************************************;
** Proc contents: Build links to frequency tables  ***;
******************************************************;
proc sql;
	create table contents as 
	select a.*,
	case (b.memname)
	when ('INDS_') then 'Discrete'
	when ('CONDS_') then 'Continuous'
	when ('DROPDS_') then 'Range'
	else ''
	end as typevar
	from 
	(
		(select  lowcase(name) as name,tranwrd(label,'<IN>',' ') as label 'Description',
		type,format,varnum
		from dictionary.columns
		where libname eq "%upcase(&dslib)" and upcase(memname) in( "%upcase(&dsname)") 
		)a
	inner join 
		(select lowcase(name) as name,memname from dictionary.columns where libname eq 'WORK' and memname in('INDS_','CONDS_','DROPDS_')
		)b
	on a.name=b.name)
	order by a.name, varnum ;

quit;

options mprint;


******************************************************;
** PDF output                                      ***;
******************************************************;
proc template; 
	define style styles.newprinter; 
	parent=styles.printer; 
	style body from document /
	          linkcolor=blue;
	          
	replace color_list "Colors used in the default style" 
	/ 'link'= blue 'bgH'= white /* default is graybb */ 'fg' = black 'bg' = white; end;
	edit base.freq.onewayfreqs; 
	contents=off; /* to get rid of "One-Way Frequencies" subbookmark in PDF */ 
	end; 
	
	
run;

ODS NOPTITLE;
goptions reset=all dev=sasprtc ftext="Courier/oblique";
ods listing close;
ods pdf body="../documentation/&pgmname..pdf"  style=newprinter 
		TITLE="&title Data Dictionary" UNIFORM
		AUTHOR="Bruce Thomas, VAMC Providence"
		KEYWORDS="CLC,Nursing Homes"
		bookmarklist=hide
		;

options orientation=landscape;
options obs=max;

goptions reset=all device=pdfc ;
ods proclabel='Title';

proc gslide ;
	note height=20;
	note height=3
        justify=center 
                       color="Green" 
                      "&title"
        justify=center 
                      "Data Dictionary";

run;

ods pdf startpage=NOW;
ods proclabel="Contents";
ods pdf anchor='contents';
title 'Table of Contents';
proc report data=contents headline headskip nowd contents=' ';
	columns varnum typevar name label type format;
	define varnum /order order=data noprint;
	define typevar/order order=data 'Variable Type';
	define name/display style(column)={foreground=blue linkcolor=_undef_};
	define type /display;
	define format /display;
	define label / display flow width=50 'Variable Label';
	compute name; 
		rtag = "#"||trim(name); 
		call define(_col_,'url',rtag);
		
	endcomp;
run;
title;

%missrange(inds=dropds_,contents=contents,typevar=Range);

%frqs;

**add a dummy variable for boxplots **;
data conds_;
	set conds_;
	retain dummy 1;
run;

goptions reset=all;
%conts;

ods pdf close;

%mend;

