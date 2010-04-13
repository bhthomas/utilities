
%macro steplot; 
%*------------------------------------------------
Show the medians and p alues with file print ODS
to pick up the dynamic values. set macro SHOWP=1.
Use with SURVDUR.sas
--------------------------------------------------;
proc template;                                                                
	define statgraph Plot;
	MVAR LEGENDTITLE;    
	MVAR TTL1;
	MVAR TTL2;
	MVAR PVAL;
	MVAR LegendHALIGN;/**legend alignment*/
	MVAR LegendVALIGN;/**legend alignment*/
	MVAR MED1;
	MVAR LL1;
	MVAR UL1;

	MVAR FOOT1;
	MVAR FOOT2;
	MVAR FOOT3;
	MVAR YLABEL;
	dynamic SHOWP PVAL MED1 LL1 UL1;
	layout Gridded;
		entryTITLE TTL1 / fontsize=12pt;
		entry TTL2 / fontsize=10pt fontweight=normal;
		layout gridded / padbottom=5 padleft=0;
				layout lattice / rows=2 rowweight=(.8 .2) columns=1 border=false;
						layout overlay/yaxisopts=(label=YLABEL ticks=(0 10 20 30 40 50 60 70 80 90 100)); 	 
						 	stepplot x=Tim y=S / group=STRATUM  index=STRATUMNUM name="step"; 
						  scatterplot x=Tim y=CENSOR/ group=STRATUM  index=STRATUMNUM  name="scat" 
						 			legendlabel="Censored" markersymbol=plus 
						 			markersize=StatGraphData:markersize; 
						 endlayout;
		        cell;
							 
							 layout gridded / columns=1 halign=LegendHALIGN vAlign=LegendVALIGN ;
							if (legendtitle)
								discretelegend "scat" / 
							 			halign=center valign=top across=1;
							 			 
								discretelegend "step" / 
							  		halign=center vAlign=LALIGN across=1 border=
												true ; 
							endif;
		        	
		        	if (showp>0)
          				layout gridded / columns=8 halign=right vAlign=top PADTOP=4 padbottom=4 border=
												true ;
		          					
				                 entry  'Median:' MED1  'UL:' UL1 'LL:' LL1; 
				                                               
		             	 endlayout;			
		           		layout gridded / columns=3 halign=right vAlign=top padtop=4;
				       				              	                                                     
				                     entry  PVAL / padright=0 format=pvalue6.4;                         
				             
				          endlayout;
		            
		             
		            endif;
		            
		           	 
		       	 endcell; 
		    	 endlayout;
    	endlayout;  
			
		
			EntryFootnote FOOT1 /hAlign=left  fontsize=8pt fontweight=normal;
			EntryFootnote FOOT2 /hAlign=left fontsize=8pt fontweight=normal;
			EntryFootnote FOOT3 /hAlign=left fontsize=8pt fontweight=normal;
		endlayout;  
	endlayout;  
end;                                                         
run;  


%mend;