/** MODIFY statement, NOTSORTED, _IORC_ in data step**/

data houses;
set sashelp.class;
if age>15 then agegrp=2;else agegrp=1;
run;
data houses2;
set sashelp.class;
if age>11 then agegrp=1;
else agegrp=2;
 newage=agegrp;
run;
data houses;
modify houses houses2;;
by name notsorted;
select (_iorc_);
when(%sysrc(_sok)) do; /* A match was found - update master */
agegrp = newage;
replace;
end;
when (%sysrc(_dsenom)) do; /* No match was found, add trans obs */
actual = newage;
output;
_error_ = 0;
end;
otherwise;
end;
run;
/** RAITHEL's disk info tool  cool use of TEMP file and stdout redirection**/
*****************************************************************;
* SAS Options.                                                  *;
*****************************************************************;
options noxwait xmin xsync;


*****************************************************************;
* Set Drives to skip over. The default is the mountable drives  *;
* A: - diskette and D: - CD ROM. Make changes if you have these *;
* devices mounted or have alternate drives mapped for mountable *;
* devices. This program will hang if you attempt to map a       *;
* mountable drive that does not have media mounted in it.       *;
*****************************************************************;
%LET SKIPDEVS = 'A:' 'D:';


*****************************************************************;
* Set the output file that will contain the concatenated output *;
* of the DOS "DIR" command executed for each Drive. Change this *;
* value if you need an alternative.                             *;
*****************************************************************;
%LET DISKREPT = c:\Windows\temp\Disk_Drive_Information.txt;


*****************************************************************;
* Allocate DISK Drive information using the DRIVEMAP keyword.   *;
*****************************************************************;
filename diskinfo DRIVEMAP;


*****************************************************************;
* Allocate TEMPFILE to hold DOS commands that will be built in  *;
* the DATA step, below.                                         *;
*****************************************************************;
filename tempfile TEMP mod;


*****************************************************************;
* Input the DISK Drive names from diskinfo. Create DOS command  *
* lines (BIGLINE) and PUT them to TEMPFILE, so that they can be *;
* executed in a DATA _NULL_ step later.                         *;
*****************************************************************;
data mymap;

file tempfile;

infile diskinfo;
input drive $;

if drive in(&SKIPDEVS) then delete;

retain callsys      "call system('dir "
       slashcarrot  '\ >> '
       targetfile   "&DISKREPT'"
       leftparen    ');'
       ;

bigline = callsys || trim(left(drive)) || slashcarrot || targetfile || leftparen;

put bigline;

run;


*****************************************************************;
* INCLUDE TEMPFILE to execute the DOS commands built by the DATA*;
* step, above. They will execute a DOS "DIR" on the main direct-*;
* ory of each DISK Drive and store the results in a .txt file.  *;
*****************************************************************;
data _null_;

%INCLUDE tempfile;

run;


*****************************************************************;
* Clear TEMPFILE.                                               *;
*****************************************************************;
filename tempfile clear;


*****************************************************************;
* View the results via the FSLIST window. (Remember to close the*;
* FSLIST window if you are going to execute this again).        *;
*****************************************************************;
filename dirinfo "&DISKREPT";

proc fslist file=dirinfo;

run;

*******************************SUGI 30 *****************************************
This appendix contains the three SAS programs used for processing all data 
files found in a specified directory.
Driver_Program.sas
*****************************************************************************;
* Program: Driver_Program.sas *;
* *;
* Purpose: This program %INCLUDEs several SAS Macro programs and then *;
* executes them so that data files in specified directories may be *;
* processed. *;
*****************************************************************************;
*****************************************************************;
* SAS Options, Formats, etc. *;
*****************************************************************;
options noxwait xmin xsync;
*************************************************************************;
* INCLUDE the Process_Flat_Files.sas SAS program that contains the *;
* READFLAT SAS Macro. That Macro reads an individual data file’s records*;
* and stores the data in a permanent SAS data set. *;
*************************************************************************;
%include 'Q:\programs\Process_Flat_Files.sas';
*************************************************************************;
* INCLUDE the SAS Macro program that identifies individual data files *;
* in the specified data directory and builds macro calls that, in turn, *;
* execute the READFLAT SAS Macro in the Process_Flat_Files.sas SAS *;
* program for each file. *;
*************************************************************************;
%include 'Q:\programs\Identify_Flat_Files.sas';
**************************************************************************;
* Execute the IDENTIFY SAS Macro in the Identify_Flat_Files.sas program *;
* to identify and process the data files in each specified data directory*;
**************************************************************************;
%IDENTIFY(Q:\data,\\system1\input\datadir);
%IDENTIFY(Q:\data,\\system2\input\datadir);
%IDENTIFY(Q:\data,\\system3\input\datadir);
*******************************************************************
SUGI 30 Coders' Corner
Identify_Flat_Files.sas
******************************************************************************;
* Program: Identify_Flat_Files.sas *;
* *;
* Purpose: This program reads all of the data file names in a directory and *;
* creates calls to the READFLAT SAS Macro, located in the *;
* Process_Flat_Files.sas program. *;
* *;
* This Macro program accepts two parameters: *;
* *;
* SASLIB - This is the full path name of the production SAS data *;
* library. This value will be coded into the call for the*;
* READFLAT SAS macro, that is the output of this program *;
* DIRNAME - The full path name of the directory that contains the *;
* data files. *;
* *;
* NOTE: This program expects that all data files will have an *;
* extension of '.txt'! *;
******************************************************************************;
/****************************************************/
/* Beginning of the IDENTIFY SAS Macro. */
/****************************************************/
%MACRO IDENTIFY(SASLIB,DIRNAME);
********************************************************************;
* Pipe the names of data files to the SAS System for processing. *;
********************************************************************;
filename dircmd pipe "dir /b &DIRNAME\*.txt";
********************************************************************;
* Temporary file to hold the READFLAT SAS Macro call statements. *;
********************************************************************;
filename holdmacs TEMP;
********************************************************************;
* Process each specific file name, dropping unneeded ones. Format *;
* SAS READFLAT Macro calls for valid data files. *;
********************************************************************;
data _null_;
length outline $100;
file holdmacs;
infile dircmd missover length=length;
input @;
input bigline $varying200. length;
outline = '%READFLAT(' || "&SASLIB" || ',' || "&DIRNAME" || '\' || trim(left(bigline)) || ');'
;
put outline;
run;
********************************************************************
SUGI 30 Coders' Corner
********************************************************************;
* Include holdmacs, which is now a series of READFLAT SAS Macro *;
* invocations. This will execute Process_Flat_Files.sas once for *;
* each “.txt” flat file found in the target data directory. *;
********************************************************************;
%INCLUDE holdmacs;
/****************************************************/
/* End of the IDENTIFY SAS Macro. */
/****************************************************/
%MEND IDENTIFY;
********************************************************************************
Process_Flat_Files.sas
*********************************************************************************;
* Program: Process_Flat_Files.sas *;
* *;
* Purpose: This program processes each data file and updates the production SAS *;
* data set. *;
* *;
* This program is in the form of a SAS Macro and accepts two *;
* parameters: *;
* *;
* PRODFILE - This is the full path filename of the SAS data library *;
* where the production SAS data set used to store the *;
* processed data files resides. *;
* DATAFIL - This is the full path filename of the data file that *;
* will be processed by this program. *;
*********************************************************************************;
%MACRO READFLAT(PRODFILE,DATAFIL);
********************************************************************;
* Allocate the Data file. *;
********************************************************************;
filename DATAFIL "&DATAFIL";
********************************************************************;
* Determine if the Data file is in use. *;
********************************************************************;
data _null_;
inuse = fopen('DATAFIL');
call symput('INUSE',inuse);
if inuse = 0 then do;
put '*** Attention: the file below was in use ***';
put '*** and could not be processed ***';
put "&DATAFIL";
put _all_;
put '*** Attention: the file above was in use ***';
put '*** and could not be processed ***';
end;
run;

%IF &INUSE NE 0 %THEN %DO;
********************************************************************;
* Process the records in the data file. *;
********************************************************************;
data newdata;
… SAS code to extract the data from the data file…
run;
*********************************************************;
* Determine if there are any obs in NEWDATA. *;
*********************************************************;
proc sql noprint;
select nobs - delobs into :numbrobs
from dictionary.tables
where libname = "WORK" and
memname = "NEWDATA"
;
quit;
/*******************************************************/
/* Only do the following if there are obs in NEWDATA. */
/*******************************************************/
%IF &NUMBROBS NE 0 %THEN %DO;
********************************************************************;
* Sort the data. *;
********************************************************************;
proc sort data=newdata nodupkey;
by …;
run;
********************************************************************;
* Allocate the production SAS data set. *;
********************************************************************;
libname prodfile "&PRODFILE";
**************************************************************;
* Update the production SAS data set. *;
**************************************************************;
data prodfile.proddata;
set newdata;
modify prodfile.proddata key=…;
select(_iorc_);
when(%sysrc(_sok)) do; /* A match the key */
…Other SAS Statements…
replace;
end;
when (%sysrc(_dsenom)) do; /* Not a match on the key */
_error_ = 0;
output;
end;
otherwise;
end;
run;

********************************************************************;
* Deallocate the production SAS data set. *;
********************************************************************;
libname prodfile clear;
/*******************************************************/
/* End of DO stmt. to process obs in NEWDATA. */
/*******************************************************/
%END;
%ELSE %DO;
********************************************************************;
* Make note in log that no valid data were found in the data file. *;
********************************************************************;
data _null_;
put '*** Attention: No data records were found in this file ***';
put "Data File: &DATAFIL";
put '*** Attention: No data records were found in this file ***';
run;
/********************************************************/
/* End of DO stmt. to flag no data records found in file*/
/********************************************************/
%END;
********************************************************************;
* Delete the data file. *;
********************************************************************;
data _null_;
rc = fdelete('DATAFIL');
put '********************************************';
put 'FILE DELETE RETURN CODE = ' rc;
put '********************************************';
run;
/*******************************************************/
/* End of DO stmt. to process data files not in use. */
/*******************************************************/
%END;
********************************************************************;
* Deallocate the data file fileref. *;
********************************************************************;
filename DATAFIL clear;
%MEND READFLAT;
