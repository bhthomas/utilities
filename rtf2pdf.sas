%*-------------------------------------------------------------
Sponsor:   		Delcath

Program:			rtf2pdf.sas

Protocol:     C:\projects\delcath\phase2\macros\


Purpose:			convert RTF doc to PDF

Inputs:
Depends:

Outputs:

Parameters:


Author:       Bruce Thomas
Date:	             04/01/10


Usage:        Need to provide
					ROOT -- location of read file
					FILENAME-- name of firl to read & convert
					TARGET-- location of target FILE
					OUTFILE-- name of target file ( must be pdf)

History:



-----------------------------------------------------------------;
%macro rtf2pdf (root=,filename=,target=,outfile=);

/* parser not needed YET
%let FILER=%sysfunc(REVERSE("&filename"));
%let FILEs=%sysfunc(SCAN(&filer,1,"\"));
%let FILEn=%sysfunc(REVERSE(&files));
%let froot=%sysfunc(SCAN(&filen,1,'.'));

%let extension=%sysfunc(SCAN(&filen,2,'.'));
%let pathn=%sysfunc(tranwrd(&filename,&filen,));
%let docname=&Froot..&outext;

*/

%let pathn=&root;
%let docname=&target.&outfile;

%*------------------------------------------------
DDE filename
--------------------------------------------------;
options noxsync noxwait xmin;
filename sas2word dde 'winword|system';

%*------------------------------------------------
Open Word
--------------------------------------------------;
data _null_;
		length fid rc start stop time 8;
		fid=fopen('sas2word','s');
		if (fid le 0) then do;
				rc=system('start winword');
				start=datetime();
				stop=start+10;
				do while (fid le 0);
					fid=fopen('sas2word','s');
					time=datetime();
					if (time ge stop) then fid=1;
				end;
		end;
		rc=fclose(fid);
run;

%*------------------------------------------------
Generate commands
FileSaveAS format= 17 is the pdf enumeration
--------------------------------------------------;
data _null_;
		file 'saswd.cmds';
		pathn=trim(left(symget('pathn')));
		filename=symget('filename');
		docname=symget('docname');
		put '[AppMinimize]';
		**put '[FileClose 2]';
		put '[ChDefaultDir "' pathn+(-1)'",0]';
		put '[FileOpen "' filename+(-1)'",.ReadOnly = 1]';
		put '[FileSaveAs.Name="' docname+(-1)'",.Format=17]';
		put '[FileExit 2]';
run;

%*------------------------------------------------
Include commands, send to DDE
--------------------------------------------------;
data _null_;
	infile 'saswd.cmds';
	file sas2word;
	input;
	put _INFILE_;
run;

filename sas2word clear;

%sysexec(del saswd.cmds);

%mend;

%*------------------------------------------------
USAGE:
let root=C:\projects\delcath\phase2\listings\
let target=C:\projects\delcath\phase2\tests\
rtf2pdf(root=&root,filename=L_12_ttph.rtf,
					outfile=L_12_ttph.pdf,target=&target)
--------------------------------------------------;

