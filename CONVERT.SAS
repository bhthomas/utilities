 %macro CONVERT(
			type_=	LISTINGS
			,config=%str(PHASEII.XLS)
			,where= %str(where NUMBER is not missing)
			,outds=t_build
			,prgmpath=%str(F:\Data\Phase III data\Programs\To \Table pgm\tables)
			,outPath_=%str(C:\projects\\melmel\output)
			,returnc=TEST
			);

**PGMPATH: location of table programs **;
**OUTPATH: Location of table outputs **;
**CONFIG : path to excel config file **;

LIBNAME METADATA  "&config" ;

libname temp '..\config';

** Read in the desired tables from the configuration file**;
data temp.config(rename=(item=tabno));
	set metadata."&type_$"n;
	length item $5;
	&where;;
	IF F5 ^=. THEN item=trim(left(put(tabno,best.)))||'.'||trim(left(put(f5,best.)));
	ELSE ITEM=trim(left(put(tabno,best.)));
	drop tabno;
run;

** include the programs **;
proc sql noprint;
		select trim(scan(program,1,'.')) into :prog1-:prog999
		from TEMP.CONFIG
		&where;;
quit;
%let TYPE_= &type_.s;
%put &type_;

%let nobs_=&sqlobs;
DATA _NULL_;
	FILE "&TYPE_.VBA" lrecl=32000;
%do i_= 1 %to &nobs_;

%PUT PROCESSING: &&prog&I_ ;
 
 
put 'Documents.Open FileName:="'"..\&type_\&&PROG&I_...RTF"'"';
/*put 'ActiveDocument.ExportAsFixedFormat OutputFileName:= "'"..\&type_\&&PROG&I_...pdf"'" _';
put ', ExportFormat:=wdExportFormatPDF, OpenAfterExport:=True, OptimizeFor:= wdExportOptimizeForPrint, _';
put 'Range:=wdExportAllDocument, From:=1, To:=1, Item:=wdExportDocumentContent, _';
put 'IncludeDocProps:=True, KeepIRM:=True, CreateBookmarks:=wdExportCreateNoBookmarks, _';
put 'DocStructureTags:=True, BitmapMissingFonts:=True, UseISO19005_1:=False';
*/
 %END;
RUN;       
        
      %MEND;
	libname temp '..\config';
	%CONVERT(	type_=	Listing
			,config=%str(..\config\PhaseII.xls)
			,where= %str(where tabno is not missing)
			,outds=t_build
			,prgmpath=%str(F:\Data\Phase III data\Programs\To \Table pgm\tables)
			,outPath_=%str(C:\projects\\melmel\output)
			,returnc=TEST);
		