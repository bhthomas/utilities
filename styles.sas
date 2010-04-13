%*------------------------------------------------
Sponsor:	Delcath

Program:	styles.sas
Protocol:	 04C-273M

Purpose:	set basic report style

Inputs:			None
Outputs:   rtf style named STYLES.test

Parameters:	None


Author:  Bruce Thomas
Date:		 11/7/2009 

Usage:

History:


--------------------------------------------------;
%macro styles;
proc template;
		define style pharma;
				parent = styles.rtf;
				style body from body /
				leftmargin = 1.0in
				rightmargin = 1.25in
				topmargin = 1.3in
				bottommargin = 0.8in;
				
				style heading from heading /
				cellpadding = 0
				cellspacing = 0;
				
				style table from table /
				rules = groups
				frame = void
				cellpadding = 1.5pt
				cellspacing = .25pt
					
		background=_undef_
		Rules=none;
	
		style header from header /
		frame=void
		background=_undef_;
		
		style rowheader from rowheader /
		background=_undef_;
		
		replace fonts / 
		'TitleFont2' = ("Arial, Helvetica",11pt) 
		'TitleFont' = ("Arial, Helvetica",11pt) 
		'StrongFont' = ("Arial, Helvetica",10pt,Bold) 
		'EmphasisFont' = ("Arial, Helvetica",10pt,Italic) 
		'FixedEmphasisFont' = ("Courier",9pt,Italic) 
		'FixedStrongFont' = ("Courier",9pt,Bold) 
		'FixedHeadingFont' = ("Courier",9pt) 
		'BatchFixedFont' = ("SAS Monospace, Courier",7pt) 
		'FixedFont' = ("Courier",9pt) 
		'headingEmphasisFont' = ("Arial, Helvetica",11pt) 
		'headingFont' = ("Times Roman",11pt) 
		'docFont' = ("Arial, Helvetica",10pt);
				
				replace headersAndFooters from cell /
				font = fonts('HeadingFont')
				foreground = colors('headerfg')
				background = white;
		end;
run;

proc template;
define style projstyl.rtfstyl;
		parent = styles.Rtf;;
	replace fonts /
		'TitleFont' = ("Times Roman",11pt,Bold ) 	
		'TitleFont2' = ("Times Roman",11pt,Bold ) 	
		'StrongFont' = ("Times Roman",10pt,Bold)        	
		'EmphasisFont' = ("Times Roman",10pt,Italic)    	
		'headingEmphasisFont' = ("Times Roman",11pt,Bold Italic)	
		'headingFont' = ("Times Roman",10pt,Bold)	
		'docFont' =("Times Roman",10pt) 	
		'footFont' = ("Times Roman",9pt) 	
		'FixedEmphasisFont' = ("Courier",9pt,Italic)	
		'FixedStrongFont' = ("Courier",9pt,Bold)	
		'FixedHeadingFont' = ("Courier",9pt,Bold)	
		'BatchFixedFont' =("Courier",6.7pt)	
		'FixedFont' = ("Courier",9pt); 
		replace color_list /	 
		'link' = blue	 
		'bgH' = white	 
		'fg' = black 	 
		'bg' = white;  

		replace Body from Document /	
		bottommargin = _undef_	
		topmargin = _undef_	
		rightmargin = 1.0in	
		leftmargin = .75in; 
		replace Table from Output /	
		frame = void		
		rules = groups	
		cellpadding = 1pt		
		cellspacing = 0pt		
		borderwidth = 3pt; 

		end;
run;
%mend;