%inc param;
proc datasets kill;
run;quit;
****************************;
** JOIN Demog and urines  **;
****************************;
data derivedxdemog /view=derivedxdemog;
	set derived.xdemog(keep=trtgrp age gender race pid finitdt);
run;	
**** creates two sorted datasets **;
data _null_;
  	/**build hash H in ascending porder **/
length trt $3;
  	dcl hash h ( hashexp:0 ,ordered: 'A');
  	dcl hiter hi ('h');
  	h.definekey ('pid');
  	h.defineData ('pid','trtgrp', 'trt','gender','age','race','_f');
  	h.definedone();

	/**build hash HD in decending porder **/
	dcl hash hd ( hashexp:0 ,ordered: 'd');;
	dcl hiter hid ('hd');    
   	hd.definekey ('pid');
  	hd.defineData ('pid','trtgrp','trt', 'gender','age','race','_f');
  	hd.definedone();

/**  create a variable  add to the hash **/
do until (eof1);
   set derivedxdemog(keep=trtgrp age gender race pid finitdt where=(trtgrp='PHP')) end=eof1;
	_f+1;  ** holds original sort order;
	trt='';
	trt=trtgrp;
	rc=h.add();
end;
do until (eof2);
   set derivedxdemog(keep=trtgrp age gender race pid finitdt where=(trtgrp='BAC')) end=eof2;
	_f+1;  ** holds original sort order;
	trt='';
	trt=trtgrp;
	rc=hd.add(); ** adding BACS to HD Hash;
end;
/** output a sorted dataset **/
do rc=hi.first() by 0 while(rc=0);
	rc=hi.next();
end;
rc=h.output(dataset: 'sample'||trim(trt));
/** output a sorted dataset **/
do rc=hid.last() by 0 while(rc=0);
	rc=hid.prev();
end;
rc=hd.output(dataset: 'sample'||trim(trt));
stop;
run;
proc sort data=derived.xdemog(keep=trtgrp age gender race pid finitdt where=(trtgrp='PHP')) out=samp1;
by pid;
run;
data Labs;
if 0 then set derivedxdemog;
  dcl hash h ( hashexp:10 ,ordered: 'A',dataset:'derivedxdemog');
  dcl hiter hi ('h');
  h.definekey ('pid');
  h.defineData ('pid','trtgrp', 'gender','age','race');
  h.definedone();

do until(eof2);
	set raw.lballab(where=( lbtest like 'PTT' and lbvalchr ne "")) end=eof2;
	if h.find() =0 then output; /** outputs LABS***/
;
end;
stop;
run;

proc print;run;
*************************************
Summarization 
*************************************;
data input;
DO tst= 1 to 3;
do k1= 1e6 to 1 by -1;
	k2=put(k1,z7.);
	do num= 1 to ceil(ranuni(1)*6);
		output;
	end;
end;
end;
run;
proc summary data=input nway;
class k1 k2;
var num;
output out= summary (drop=_:) sum=sum;
run;
data _null_;

/** each output dataset named after TST variable 
is an object containing other objects**/
dcl hash hoh (ordered:'a');
dcl hiter hih('hoh');
hoh.definekey('tst');
hoh.definedata('tst','hh');
hoh.definedone();

/* declare HH here, but instantiate below for each new value of TST. 
This holds k1,k2 and sum of NUM variable*/
dcl hash hh ();

do _n_ =1 by 1 until(eof);
	set input end=eof;
	/** if the TST variable  is not found yet, instantiate the HH hash **/	
	if hoh.find() ne 0 then do;
		hh=_new_ hash(ordered:'a', hashexp:16);
		hh.definekey('k1','k2');
		hh.definedata('k1','k2','sum');
		hh.definedone();
		hoh.replace();
	end;

if hh.find() ne 0 then sum=0;
		sum ++ num;
	hh.replace();
end;
do rc=hih.next() by 0 while(rc=0);
rc=hh.output(dataset:'hash_sum'||put(tst,best. -L));
rc=hih.next();
end;
stop;
run;
