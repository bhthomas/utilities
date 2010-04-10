 
      %macro ll(line);  
      	%let ll=%sysfunc(length("&line"));
        
        %do j=1 %to &ll;%left(%str(*))%end;
        
      %mend;

 %macro chk_dir(dir=,force=N) ; 
   options noxwait; 
   %local rc fileref ; 
   %let rc = %sysfunc(filename(fileref,&dir)) ; 
   %if %sysfunc(fexist(&fileref))  and %upcase(&force) ne Y  %then 
      %put NOTE: The directory "&dir" exists ; 
   %else  %do ; 
         %sysexec( md   &dir ); 
         %put %sysfunc(sysmsg()) The directory has been created. ; 
   %end ; 
   %let rc=%sysfunc(filename(fileref)) ; 
%mend chk_dir ;
 
 %macro chk_file(filen=,keys=,values=,scope=,force=N) ; 
   options noxwait; 
   %local rc fileref1 num; 
   %let rc = %sysfunc(filename(fileref1,&filen)) ; 
   %if %sysfunc(fileexist(&fileref1)) and %upcase(&force) ne Y  %then 
      %put NOTE: The file "&filen" exists ; 
   %else %do ; 
        data _null_;
        	keys=symget('keys');
        	length k $40;
        	k='dummy';
        	n=0;
        	do while (k ^="");
        		n+1;
        		k=scan(keys,n);
        	end;
        call symputx('Num',n-1);
      run;
        data _null_;
        	file &fileref1;
        	put "%*------------------------------------";
        	put "&scope METAFILE";
        	put "--------------------------------------;";
        	
        	array key(&num) $40 _TEMPORARY_ (&keys);
        	array value(&num) $40 _TEMPORARY_ (&values);
        	do i= 1 to dim(key);
        		if key(i) ne "" then put key(i) " = " value(i);
        	end;
        run;
        %let line=	The &scope metafile has been created at &filen.. ; 
        
         %put  %ll(&line);;
         %put  The &scope metafile has been created at &filen.. ; 
         %put  %ll(&line);;
         
   %end ; 
   %let rc=%sysfunc(filename(fileref1)) ; 
%mend chk_file ; 

%macro setupdirs(
						domainlist=DM CM 
						,datasets= DM CM
						,tables=
						,listing=
						,figures=
						,project=
						,protocol=
						,submission=
						,root=c:\
						,force=N
						);
%*------------------------------------------------
Build file structure based on 
project/submission/protocol
--------------------------------------------------;	
options noxsync noxwait xmin;



%chk_dir(force=&force,dir=&root.&project) ;    %*   <==  your directory specification goes here ; 
%chk_dir(force=&force,dir= &root.&project&slash&submission );
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol );
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol );
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.config);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.data );
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.analysis);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.formats);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.macros);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.programs);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.styles);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.tables);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.listings);
%chk_dir(force=&force,dir= &root.&project&slash&submission&slash&protocol&slash.figures);
%mend;

%macro setupmeta(
						keys=
						,values=
						,scope=
						,project=
						,protocol=
						,submission=
						,root=c:\
						);

%*------------------------------------------------
Set up metafiles
project
submission
Protocol
--------------------------------------------------;
%local filen;
%if %upcase(&scope) eq PROJECT %then %let filen=&root.&project.&slash.project.meta;
%if %upcase(&scope) eq SUBMISSION %then %let filen=&root.&project&slash&submission&slash.submission.meta;
%if %upcase(&scope) eq PROTOCOL %then %let filen=&root.&project.&slash&submission&slash&protocol&slash.protocol.meta;
%if &filen ne %then %do;
%chk_file(filen= &filen
					,keys=&keys 
					,values=&values
					,scope=&scope
					,force=&force
					) ; 
%end;					
%mend;									
%macro junk;
%*------------------------------------------------
build shells for dataset programs
--------------------------------------------------;

%*------------------------------------------------
Build shells for TLFs
--------------------------------------------------;						
%FINI:
%mend;			


%macro copyModel(root=c:\,modelPath=,project=test,submission=sub1,protocol=prot1);

%*------------------------------------------------
verify model Location and copy config spreadsheet

--------------------------------------------------;
%local rc fileref2 ; 
   %let rc = %sysfunc(filename(fileref2,&modelpath)) ; 
   %if %sysfunc(fexist(&fileref2))   %then %do;
			%put NOTE: The directory "&modelpath" exists ; 
			%let  copy=  copy "&modelpath&slash.config&slash.config.xls" ; 
		%sysexec cd "&root.&project&slash&submission&slash&protocol&slash.config&slash";
		%sysexec &copy;
			%put  The Model CONFIG file has been copied. ; 
   %end ; 
   %let rc=%sysfunc(filename(fileref2)) ; 
	%*------------------------------------------------
	verify target destination copy macros
	--------------------------------------------------;
 %let rc = %sysfunc(filename(fileref2,&modelpath)) ; 
   %if %sysfunc(fexist(&fileref2))   %then %do;
			%put NOTE: The directory "&modelpath" exists ; 
			%let  copy=  copy "&modelpath&slash.macros&slash.*" ; 
		%sysexec cd "&root.&project&slash&submission&slash&protocol&slash.macros&slash";
		%sysexec &copy;
			%put  The Model Macros have been copied. ; 
   %end ; 
   %let rc=%sysfunc(filename(fileref2)) ; 
	%*------------------------------------------------
	verify target destination copy programss
	--------------------------------------------------;
 %let rc = %sysfunc(filename(fileref2,&modelpath)) ; 
   %if %sysfunc(fexist(&fileref2))   %then %do;
			%put NOTE: copying Programs The directory "&modelpath" exists ; 
			%let  copy=  copy "&modelpath&slash.programs&slash.*" ; 
		%sysexec cd "&root.&project&slash&submission&slash&protocol&slash.programs&slash";
		%sysexec &copy;
			%put  The Model programs have been copied. ; 
   %end ; 
   %let rc=%sysfunc(filename(fileref2)) ; 
%mend;	

%macro setupglobals(r);
		options nomlogic nomprint nosymbolgen;	
		%global slash force root;
		%let slash=\;
		%let force=;
		%let root=&r;
%mend;

*********************************************************;
**MODIFY These Programs as necessary **;
** Order is important **;
** assumes root=c:\**;
********************************************************;
%setupglobals(c:\);
%setupdirs(root=&root,project=test,submission=sub1,protocol=prot1,force=&force);
%setupmeta(root=&root,project=test,submission=sub1,protocol=prot1
					,scope=project
					,keys='PROJNAME' 'DESCRIPTION' 
					,values='TEST Project' 'DEFLOGRIMIDE DF !23' 
					) ; 
%setupmeta(root=&root,project=test,submission=sub1,protocol=prot1
					,scope=protocol					
					,keys='NAME' 'DESCRIPTION' 
					,values='Protocol ABC' 'Test of Wonder Drug A vs B' 
					) ; 	
%setupmeta(root=&root,project=test,submission=sub1,protocol=prot1
					,scope=submission					
					,keys='TYPE' 'DESCRIPTION' 'DATE' 'IND'
					,values='AR' 'Annual Report' 'JAN 25,1999' '123-456'
					);
%copyModel(modelPath=C:\projects\model PROJECT directory\PROTOCOL,root=&root,
						project=test,submission=sub1,protocol=prot1);
					