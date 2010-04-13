proc template;

%macro ExcelXP;

     %if  %substr(&sysvlong,1,7) = 9.02.01 %then %do;

              define Tagset Tagsets.ExcelXP;
                   parent = Tagsets.ExcelBase;
                   proc_report_widths = no; 
              end;

      %end;

     %else %do;

              define Tagset Tagsets.ExcelXP;
                   parent = Tagsets.ExcelBase;
             end;

     %end;
%mend;


define tagset Tagsets.ExcelBase;
    /*-----------------------------------------------------------eric-*/
    /*-- "This product may incorporate intellectual property owned  --*/
    /*-- by Microsoft Corporation. The terms and conditions upon    --*/
    /*-- which Microsoft is licensing such intellectual property    --*/
    /*-- may be found at                                            --*/
    /*-- http://msdn.microsoft.com/library/en-us/odcXMLRef/html/odcXMLRefLegalNotice.asp."--*/
    /*--------------------------------------------------------1Aug 05-*/
    log_note = "NOTE: This is the Excel XP tagset (SAS 9.1.3, v1.86, 04/15/08). Add options(doc='help') to the ods statement for more information.";


    /*-----------------------------------------------------------eric-*/
    /*-- A - causes a dashed line.  A line beginning with a .       --*/
    /*-- causes that line to be left justified with no              --*/
    /*-- bullet. lines that start with text will have a bullet.     --*/
    /*-- lines that start with a space will be indented.            --*/
    /*--------------------------------------------------------8May 07-*/
    define event changes;
        start:
            set $changelog[] '-';
            set $changelog[] '.v1.86, 04/15/08';
            set $changelog[] 'Added ByContentFolder to the list of needed styles.';
            set $changelog[] '-';
            set $changelog[] '.v1.85, 04/10/08';
            set $changelog[] '-';
            set $changelog[] 'Style of unknown now includes justification in the style definition.  This occurs with proc print';
            set $changelog[] 'when a justification over ride is done in this way: proc print data=sashelp.class style(header)={just=c};';
            set $changelog[] '.v1.84, 04/09/08';
            set $changelog[] 'Changed proc print byline parsing so that it will use everything after the equals sign for';
            set $changelog[] 'the worksheet name, if there is only one by variable.  Otherwise it still looks for spaces.';
            set $changelog[] 'Decremented the worksheet counter when a worksheet turns out to be empty.';
            set $changelog[] 'initialized tmp_value at the end of calculate header so that the header would not reappear';
            set $changelog[] ' as a title on the next worksheet.';
            set $changelog[] '-';
            set $changelog[] '.v1.83, 04/08/08';
            set $changelog[] 'Added DataEmphasis to the list of needed styles.';
            set $changelog[] '-';
            set $changelog[] '.v1.82, 04/01/08';
            set $changelog[] 'Changed Ascii_dots = no so that it would print the batch text.';
            set $changelog[] '-';
            set $changelog[] '.v1.81, 02/28/08';
            set $changelog[] 'Added mergeAcross: as another option for tagattr over rides';
            set $changelog[] '-';
            set $changelog[] '.v1.80, 02/12/08';
            set $changelog[] 'Added triggering of empty_style in style_class to cause empty';
            set $changelog[] 'styles to be generated for header and data when they do exist';
            set $changelog[] '-';
            set $changelog[] '.v1.79, 10/03/07';
            set $changelog[] 'Removed quotes from index worksheet urls that do not have spaces.';
            set $changelog[] 'Removed a trigger for worksheet_tabs it was doing it to quick to catch.';
            set $changelog[] ' the worksheet name from the byline, when using proc print and ';
            set $changelog[] ' sheet_intrval="bygroup"';
            set $changelog[] '-';
            set $changelog[] '.v1.78, 10/03/07';
            set $changelog[] 'Removed quotes from contents worksheet urls that do not have spaces.';
            set $changelog[] 'One word worksheet name urls in the index or contents did not work.';
            set $changelog[] '-';
            set $changelog[] '.v1.77, 09/30/07';
            set $changelog[] 'Added a span event to handle color, font_face, bold and underline';
            set $changelog[] ' with inline formatting.';
            set $changelog[] '-';
            set $changelog[] '.v1.76, 09/30/07';
            set $changelog[] 'Added Hidden_Columns option to specify columns that should be hidden.';
            set $changelog[] 'Added Blank_Sheet option to create blank worksheets.';
            set $changelog[] '-';
            set $changelog[] '.v1.75, 07/26/07';
            set $changelog[] 'Convert_to_points returned no value if the original value had units of pt';
            set $changelog[] '-';
            set $changelog[] '.v1.74, 06/15/07';
            set $changelog[] 'Added unset of style_overides list when starting a new style section.';
            set $changelog[] " Style overrides were not creating new styles when they existed in a previous file";
            set $changelog[] " created by a previous ods statement that did not have an ods close in between.";
            set $changelog[] 'Added an explicit match on pt in convert_to_scale. Because of a change in substr() behavior.';
            set $changelog[] " This does not effect SAS 9.1.3 but does fix missing border definitions in SAS 9.2.";
            set $changelog[] 'And another one.  proc_print_bvars used substr which cound have a 0 start point. Substr was returning';
            set $changelog[] " nothing where it used to return the value.  Put an if around it to prevent 0 indexing";
            set $changelog[] '-';
            set $changelog[] '.v1.73, 06/13/07';
            set $changelog[] 'Added an explicit match on pt in convert_to_points. Because of a change in substr() behavior.';
            set $changelog[] " This does not effect SAS 9.1.3 but does fix missing '.' font sizes in SAS 9.2.";
            set $changelog[] '-';
            set $changelog[] '.v1.72, 06/09/07';
            set $changelog[] 'Added set from $mvar for option parsing routines, do_yes_no, do_numeric, do_string.';
            set $changelog[] 'Added embedded_footers macro variable.';
            set $changelog[] '-';
            set $changelog[] '.v1.71, 06/08/07';
            set $changelog[] 'Refined the help html output to look nicer.';
            set $changelog[] '-';
            set $changelog[] '.v1.70, 06/05/07';
            set $changelog[] 'Added text_decoration to the list of style overrides used to reduce duplicate style definitions.';
            set $changelog[] '-';
            set $changelog[] '.v1.69, 06/04/07';
            set $changelog[] 'Added hidden:yes to valid values for tagattr.  Any cell with this setting will cause';
            set $changelog[] ' the entire row to be hidden.';
            set $changelog[] 'Added trigger of get_global_margins to each new worksheet so the margins can change.';
            set $changelog[] '-';
            set $changelog[] '.v1.68, 05/29/07';
            set $changelog[] 'Added Ascii_dots option to turn off leading dots on batch/ascii output.';
            set $changelog[] '-';
            set $changelog[] '.v1.67, 05/22/07';
            set $changelog[] 'Style class stream was not getting cleared when a format override followed a style override';
            set $changelog[] ' from a previous cell in the table.';
            set $changelog[] 'Fixed copy/paste error. $row_repeat misspelled as $col_repeat. Row_repeat was not working.';
            set $changelog[] 'Removed empty alignment tag for headers that was eliminating the inheritance of';
            set $changelog[] ' justification from the parent style.';
            set $changelog[] '-';
            set $changelog[] '.v1.65, 05/17/07';
            set $changelog[] 'Fixed misspelling of column_repeat so the option now works again.';
            set $changelog[] 'Decremented numberOfWorksheets when the worksheetname is a space.  It was causing';
            set $changelog[] ' the count to go off when using sheet_interval of bygroup. Test: t118.sas.';
            set $changelog[] 'Changed misspelled name for the default value for debug_level.';
            set $changelog[] '-';
            set $changelog[] '.v1.64, 05/16/07';
            set $changelog[] 'Unset $just after use to prevent unwanted justifications later on. Test: t116.sas.';
            set $changelog[] 'Changed style processing to eliminate duplicate style definitions.';
            set $changelog[] '-';
            set $changelog[] '.v1.63, 05/15/07';
            set $changelog[] 'Fixed bad default variable name for the config_debug options.';
            set $changelog[] '-';
            set $changelog[] '.v1.62, 05/11/07';
            set $changelog[] 'Changed the input format for mergedown rows to 5. ';
            set $changelog[] ' Thanks to the patch submitted by: "Team JRS" - three hard-working elves :-)';
            set $changelog[] ' Added frame file for HTML help text.  Added Frame="help.html" to the ods statement.';
            set $changelog[] '-';
            set $changelog[] '.v1.61, 05/10/07';
            set $changelog[] 'Added doc="all".';
            set $changelog[] 'Changed default value for datamissing_align to "r" from "right".';
            set $changelog[] '-';
            set $changelog[] '.v1.60, 05/08/07';
            set $changelog[] 'Print headers, x:header, was missing a space between attributes under certain conditions.';
            set $changelog[] 'Changed to alphabetical list of options with short descriptions for the Doc="Quick" option.';
            set $changelog[] 'Added option validation.  Unrecognized options will be printed to the log.';
            set $changelog[] 'Yes/no options now take yes/no or on/off and complain otherwise.';
            set $changelog[] '-';
            set $changelog[] '.v1.59, 05/08/07';
            set $changelog[] 'Added Doc="changelog" option.';
            set $changelog[] 'Options nocenter now left-justifies titles no matter what. Options center uses justifications provided.';
            set $changelog[] 'The print_header option was getting lost.';
            set $changelog[] 'Columns without headers were sometimes getting a width from a previous header.';
            set $changelog[] 'Changed automatic justified style names (i.e., data_c --> data__c ) to prevent clashes';
            set $changelog[] ' with user-defined style names that control justification.';
            set $changelog[] '-';
            set $changelog[] '.Some changes that came with the March 2007 release.';
            set $changelog[] '-';
            set $changelog[] '.v1.52, 03/05/07';
            set $changelog[] 'Added several options, print_header_margin, print_footer_margin, Gridlines, BlackAndWhite, DraftQuality,';
            set $changelog[] ' RowColHeadings.';
            set $changelog[] 'Added SystemFooter2-10 and SystemTitle2-10 to list of needed styles.';
            set $changelog[] 'Automatically generated justified styles.  Allows for justification to work as it should.';
            set $changelog[] "The body style is now used for the worksheet's overall style instead of the table style.";
            set $changelog[] "The body style is now used for the parent style for titles, footnotes, bylines, and notes.";
            set $changelog[] "The table style is now only used as a parent to the cell styles, so borders look more as intended.";
            set $changelog[] 'The borders are derived from cellspacing and table background as necessary.';
            set $changelog[] 'Styles like minimal, get automatically generated body and table styles so they look reasonable.';
            set $changelog[] 'Fixed bug where vertical justification attribute was missing a value.';
            set $changelog[] 'Fixed bug with worksheet naming with bygroups being off by one.';
            set $changelog[] 'Added rotate: option to tagattr processing.';
            set $changelog[] 'Added lookup table to track style elements created from style overrides.  This minimizes the';
            set $changelog[] ' creation of style elements by reusing elements that match previous styles with the same overrides.';
            set $changelog[] ' The attributes that are tracked are: font_face, font_size, font_style, font_weight, foreground,';
            set $changelog[] ' background, borderwidth, bordercolor.';
            set $changelog[] 'Left-justified titles are no longer merged cells. This allows them to flow.';
            set $changelog[] 'Changed newline in print headers and footers to &amp;#13;.';
            set $changelog[] 'Added inline formatting functions, sup, sub, newline, style.  These work fairly well, title and footnote';
            set $changelog[] ' processing still needs refinement.';
            set $changelog[] 'Better column width and row height calculations.';
            set $changelog[] 'Type attribute added to tagattr to allow better control over data types and formats.';
            set $changelog[] 'Rotate attribute added to tagattr to allow for text rotation.';
            set $changelog[] 'Various changes to worksheet labels.  worksheet_label=" " with interval=bygroup shows only the value.';
            set $changelog[] '-';
            set $changelog[] '.v1.41, 10/18/06';
            set $changelog[] 'Added text decoration style processing.  Underline, strikethrough, overline and blink.';
            set $changelog[] 'Added text decoration support for border styles.';
            set $changelog[] "Reset frozen header count so it wouldn't erroneously carry over to the next worksheet when the";
            set $changelog[] " next worksheet didn't qualify for frozen headers.";
            set $changelog[] "Added datamissing style to make missing values justify correctly.";
            set $changelog[] "Added support for the indent style attribute.";
            set $changelog[] 'Added data_note support for proc report line statements.';
            set $changelog[] 'Added an event called option that allows for pre-SAS 9.1.3 users to set options.';
            set $changelog[] 'Paper size conversion from the SAS option to the Excel equivalent.  Thanks to Chris Wright.';
            set $changelog[] '-';
            set $changelog[] '.v1.39, 07/29/06';
            set $changelog[] 'Automatic generation of parskip and pagebreak styles when they are missing.';
        finish:
            unset $changelog;
    end;

    Notes "Excel XP (2002) XML format.";
    Parent = tagsets.config_debug;
    output_type = "xml";
    indent = 0;
    split = "&#10;";
    default_event = '';
    /*-----------------------------------------------------------eric-*/
    /*-- This seems to act like a preferred split but only works if --*/
    /*-- Wrapit is set on the style.  But if wrapit is set on the   --*/
    /*-- style everything wraps if it doesn't fit.  Very strange.   --*/
    /*-- It's best to not wrap.                                     --*/
    /*--------------------------------------------------------29Jul03-*/

    /*----------------------------------------------------------Vince-*/
    /*-- Using &#10; for the split for column headings will work    --*/
    /*-- providing WrapText is set to 1 on the Alignment element    --*/
    /*-- for that cell.  Added the logic for this in the            --*/
    /*-- xl_style_elements event and modified the width calculation --*/
    /*-- in the sub_colspec_header and colspec_entry events.        --*/
    /*--------------------------------------------------------20Dec04-*/

    map = '<>&';
    mapsub = '/&lt;/&gt;/&amp;/';
    copyright='&copy;';
    trademark='&trade;';
    registered_tm='&reg;';
    nobreakspace = ' ';
    stacked_columns = no;
    embedded_stylesheet = yes;
    pure_style=no;

    /*
    breaktext_ratio = 2.5;
    breaktext_width = 40;
    breaktext_length = 80;
    */

    /*    default_event = "default"; */

    /*-----------------------------------------------------------eric-*/
    /*-- If 'yes' system titles and footnotes will be placed as     --*/
    /*-- spanning cells above and below each table. - A part of     --*/
    /*-- the table really.                                          --*/
    /*--------------------------------------------------------22Aug03-*/
    mvar embedded_titles;
    mvar embedded_footers;

    /*-----------------------------------------------------------eric-*/
    /*-- If yes, cause the top of the worksheet to be stationary    --*/
    /*-- while the data scrolls.                                    --*/
    /*--------------------------------------------------------4Aug 04-*/
    mvar frozen_headers;

    /*-----------------------------------------------------------eric-*/
    /*-- If yes, cause the left of the worksheet to be stationary    --*/
    /*-- while the data scrolls.                                    --*/
    /*--------------------------------------------------------4Aug 04-*/
    mvar frozen_rowheaders;

    /*-----------------------------------------------------------eric-*/
    /*-- If all or a range like 1-10, causes autofilter to be       --*/
    /*-- turned on for all or some of the columns in the table      --*/
    /*--------------------------------------------------------4Aug 04-*/
    mvar autofilter;
    mvar width_points;
    mvar width_fudge;
    mvar default_column_width;
    mvar formulas;

    /*-----------------------------------------------------------eric-*/
    /*-- If 'no' do not turn percentages into numbers.              --*/
    /*-- Display them as strings.  The default behavior             --*/
    /*-- is to divide them by 100 before displaying as              --*/
    /*-- Percent format.                                            --*/
    /*--------------------------------------------------------23Aug03-*/
    mvar convert_percentages;

    /*-----------------------------------------------------------eric-*/
    /*-- Set orientation to landscape to get landscape oriented printing.--*/
    /*--------------------------------------------------------14Jun04-*/
    mvar orientation;

    /*-----------------------------------------------------------eric-*/
    /*-- Set sheetname to this macro var instead of anything else   --*/
    /*--------------------------------------------------------20Apr06-*/
    mvar override_sheetname;

    /*-----------------------------------------------------------eric-*/
    /*-- Supposedly there is a 31 worksheet limit.  But we have     --*/
    /*-- not seen that to be the case.                              --*/
    /*--------------------------------------------------------25Jul03-*/
    /*-----------------------------------------------------------Eric-*/
    /*-- The excel xml specification is here.                       --*/
    /*--                                                            --*/
    /*-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnexcl2k2/html/odc_xlsmlinss.asp--*/
    /*--------------------------------------------------------24Jul03-*/

    notes "http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnexcl2k2/html/odc_xlsmlinss.asp";

    define event default;
        start:
            put "<" event_name ">" nl;
        finish:
            put "</" event_name ">" nl;
    end;


    define event changelog;
        trigger changes start;
        putlog "============================================================================================";
        putlog "History of changes for this tagset";
        putlog "============================================================================================";
        iterate $changelog;
        do /while _value_;

            set $ctrl substr(_value_, 1, 1);

            do /if cmp(_value_, '-');  /* dashed line */
                putlog "--------------------------------------------------------------------------------------------";
            else /if cmp($ctrl, '.');  /* flush with margin line */
                putlog substr(_value_, 2);
            else /if cmp($ctrl, ' ');  /* indented line */
                putlog "       " strip(_value_);
            else;
                putlog " * " _value_;  /* bulleted  line */
            done;
            next $changelog;
            unset $ctrl;
        done;
        putlog "============================================================================================";
        trigger changes finish;
    end;

    define event initialize;
        trigger setup_lists;
        trigger set_options_defaults;
        trigger set_valid_options;
        trigger set_options;
    end;

    /*--------------------------------------------------------------eric-*/
    /*-- This one happens when options(...) are given on the ods markup--*/
    /*-- statement.                                                    --*/
    /*-----------------------------------------------------------14Jun04-*/
    define event options_set;
        trigger set_options;
    end;

    define event set_options;
        trigger nls_numbers;
        trigger check_valid_options;
        trigger options_setup;
        trigger set_textdecorations;
        trigger documentation;
        trigger compile_regexp;
    end;

    define event check_valid_options;
        break /if ^$options;
        iterate $options;
        do /while _name_;
            do /if ^$valid_options[_name_];
                putlog "Unrecognized option: " _name_;
            done;
            next $options;
        done;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- Each new option should be added in three places before     --*/
    /*-- using it in the underlying code.                           --*/
    /*-- 1. Add the option to the $valid_options array              --*/
    /*-- 2. Add the option to the set_options event to set the      --*/
    /*--        appropriate variable, if necessary.                 --*/
    /*-- 3. Add the option to the quick reference event's help text.--*/
    /*--------------------------------------------------------11Mar07-*/

    define event set_valid_options;
        set $valid_options["ASCII_DOTS"] "Turn off/on leading dots in textual 'batch' output";
        set $valid_options["AUTOFILTER"] "Turn on auto filter for all columns or a range of columns";
        set $valid_options["AUTOFILTER_TABLE"] "Which table on the worksheet should get the filters";
        set $valid_options["ABSOLUTE_COLUMN_WIDTH"] "List of widths to use for each column in a table no matter what";
        set $valid_options["AUTOFIT_HEIGHT"] "If yes, no row heights will be specified";
        set $valid_options["AUTO_SUBTOTALS"] "Add a subtotal function to the summary line of proc print";
        set $valid_options["BLACKANDWHITE"] "This value turns on black and white for printing";
        set $valid_options["BLANK_SHEET"] "Create a Blank Worksheet with the name given";
        set $valid_options["CENTER_VERTICAL"] "This value controls vertical centering for printing";
        set $valid_options["CENTER_HORIZONTAL"] "This value controls horizontal centering for printing";
        set $valid_options["COLUMN_REPEAT"] "Repeat columns across pages when printing";
        set $valid_options["CONTENTS"] "Create a worksheet that will contain a table of contents";
        set $valid_options["CONTENTS_WORKBOOK"] "Create a workbook with a table of contents and/or an index of workbooks and/or an index of worksheets";
        set $valid_options["CONVERT_PERCENTAGES"] "Remove percent symbol, apply Excel percent format, and multiply by 100";
        set $valid_options["CURRENCY_SYMBOL"] "Used for detection of currency formats and for removing symbols so Excel will see currency as numbers";
        set $valid_options["CURRENCY_FORMAT"] "The currency format specified for Excel to use";
        set $valid_options["DECIMAL_SEPARATOR"] "The character used for the decimal point";
        set $valid_options["DEFAULT_COLUMN_WIDTH"] "List of widths to use for each column in a table, if there are no widths";
        set $valid_options['DOC'] 'Documentation for this tagset. Values are Help, Options, Quick, Settings, and Changelog';
        set $valid_options["DPI"] "This value determines the dots per inch for printing";
        set $valid_options["DRAFTQUALITY"] "This value turns on draft quality for printing";
        set $valid_options["EMBED_TITLES_ONCE"] "If yes, embedded titles will only appear at the top of each worksheet";
        set $valid_options["EMBEDDED_FOOTNOTES"] "Put footnotes in the worksheet";
        set $valid_options["EMBEDDED_TITLES"] "Put titles in the worksheet";
        set $valid_options["FITTOPAGE"] "Fit to Page when printing";
        set $valid_options["FORMULAS"] "Data values that start with an '=' will become formulas";
        set $valid_options["FROZEN_HEADERS"] "Freeze rows from scrolling with the scrollbar";
        set $valid_options["FROZEN_ROWHEADERS"] "Freeze columns from scrolling with the scrollbar";
        set $valid_options["GRIDLINES"] "This value turns on gridlines for printing";
        set $valid_options["HIDDEN_COLUMNS"] "range or list of column numbers to hide";
        set $valid_options["INDEX"] "Create a worksheet that will contain a index of worksheets";
        set $valid_options["MINIMIZE_STYLE"] "Minimize the styles written to the stylesheet. Can cause unloadable XML files";
        set $valid_options["MISSING_ALIGN"] "Sets the alignment for missing values";
        set $valid_options["NUMERIC_TEST_FORMAT"] "Used for determining if a value is numeric or not";
        set $valid_options["ORIENTATION"] "Print orientation for the worksheet, Portrait or Landscape";
        set $valid_options["PAGE_ORDER_ACROSS"] "If set to yes, the worksheet page order will be set to print across, then down";
        set $valid_options["PAGEBREAKS"] "Insert page break lines in the worksheet";
        set $valid_options["PAGES_FITWIDTH"] "This value determines the number of pages to fit the worksheet across when printing";
        set $valid_options["PAGES_FITHEIGHT"] "This value determines the number of pages down to fit the worksheet when printing";
        set $valid_options["PRINT_FOOTER"] "If embedded footers are on, this value will be used as the footer for printing" ;
        set $valid_options["PRINT_FOOTER_MARGIN"] "This is the footer margin as set in the page setup dialog window";
        set $valid_options["PRINT_HEADER"] "If embedded titles are on, this value will be used as the header for printing";
        set $valid_options["PRINT_HEADER_MARGIN"] "This is the header margin as set in the page setup dialog window";
        set $valid_options["ROW_HEIGHT_FUDGE"] "A fudge value to add to the row height for each row";
        set $valid_options["ROW_HEIGHTS"] "Positional list of point sizes to use for row heights";
        set $valid_options["ROW_REPEAT"] "Repeat rows across pages when printing";
        set $valid_options["ROWCOLHEADINGS"] "This value turns on row and column headings for printing";
        set $valid_options["SCALE"] "This value determines the scale level for printing";
        set $valid_options["SHEET_INTERVAL"] "Interval to divide the output between worksheets. Values are Table, Page, Bygroup, Proc, or None";
        set $valid_options["SHEET_NAME"] "Worksheet name to use for the next worksheet";
        set $valid_options["SHEET_LABEL"] "Replace the prefix of the worksheet name with this value";
        set $valid_options["SKIP_SPACE"] "Multiplier for the space that follows the different types of output";
        set $valid_options["SUPPRESS_BYLINES"] "Suppresses bylines in the worksheet" ;
        set $valid_options["THOUSANDS_SEPARATOR"] "The character used for indicating thousands in numeric values";
        set $valid_options["WIDTH_FUDGE"] "This value is used along with Width_Points and column width to calculate an approximate width for the table columns";
        set $valid_options["WIDTH_POINTS"] "Override value for width calculations";
        set $valid_options["ZOOM"] "This value determines the zoom level on the worksheet";
        set $valid_options["#$bogus"] "place holder for nonexistent options";
        trigger config_debug_set_valid_options;
    end;

    define event set_options_defaults;
        set $option_defaults['DOC'] 'none';
        set $option_defaults["ASCII_DOTS"] 'yes';
        set $option_defaults["AUTOFILTER"] 'none';
        set $option_defaults["AUTOFILTER_TABLE"] '1';
        set $option_defaults["ABSOLUTE_COLUMN_WIDTH"] 'none';
        set $option_defaults["AUTOFIT_HEIGHT"] 'no';
        set $option_defaults["AUTO_SUBTOTALS"] 'no';
        set $option_defaults["BLACKANDWHITE"] 'no';
        set $option_defaults["CENTER_VERTICAL"] 'no';
        set $option_defaults["CENTER_HORIZONTAL"] 'no';
        set $option_defaults["COLUMN_REPEAT"] 'none';
        set $option_defaults["CONTENTS"] 'no';
        set $option_defaults["CONTENTS_WORKBOOK"] 'Contents, Index';
        set $option_defaults["CONVERT_PERCENTAGES"] 'yes';
        set $option_defaults["CURRENCY_SYMBOL"] '$';
        set $option_defaults["CURRENCY_FORMAT"] 'Currency';
        set $option_defaults["DECIMAL_SEPARATOR"] '.';
        set $option_defaults["DEFAULT_COLUMN_WIDTH"] 'none';
        set $option_defaults['DOC'] 'none';
        set $option_defaults["DPI"] '300';
        set $option_defaults["DRAFTQUALITY"] 'no';
        set $option_defaults["EMBED_TITLES_ONCE"] 'no';
        set $option_defaults["EMBEDDED_FOOTNOTES"] 'no';
        set $option_defaults["EMBEDDED_TITLES"] 'no';
        set $option_defaults["FITTOPAGE"] 'no';
        set $option_defaults["FORMULAS"] 'yes';
        set $option_defaults["FROZEN_HEADERS"] 'no';
        set $option_defaults["FROZEN_ROWHEADERS"] 'no';
        set $option_defaults["GRIDLINES"] 'no';
        set $option_defaults["HIDDEN_COLUMNS"] 'none';
        set $option_defaults["INDEX"] 'no';
        set $option_defaults["MINIMIZE_STYLE"] 'no';
        set $option_defaults["MISSING_ALIGN"] 'r';
        set $option_defaults["NUMERIC_TEST_FORMAT"] '12.';
        set $option_defaults["ORIENTATION"] 'Portrait';
        set $option_defaults["PAGE_ORDER_ACROSS"] 'no';
        set $option_defaults["PAGEBREAKS"] 'no';
        set $option_defaults["PAGES_FITWIDTH"] '1';
        set $option_defaults["PAGES_FITHEIGHT"] '1';
        set $option_defaults["PRINT_FOOTER"] 'None';
        set $option_defaults["PRINT_FOOTER_MARGIN"] 'none';
        set $option_defaults["PRINT_HEADER"] 'None';
        set $option_defaults["PRINT_HEADER_MARGIN"] 'none';
        set $option_defaults["ROW_HEIGHT_FUDGE"] '4';
        set $option_defaults["ROW_HEIGHTS"] '0,0,0,0,0,0,0';
        set $option_defaults["ROW_REPEAT"] 'none';
        set $option_defaults["ROWCOLHEADINGS"] 'no';
        set $option_defaults["SCALE"] '100';
        set $option_defaults["SHEET_INTERVAL"] 'Table';
        set $option_defaults["SHEET_NAME"] 'none';
        set $option_defaults["SHEET_LABEL"] 'none';
        set $option_defaults["SKIP_SPACE"] '1,0,1,1,1';
        set $option_defaults["SUPPRESS_BYLINES"] 'no';
        set $option_defaults["THOUSANDS_SEPARATOR"] ',';
        set $option_defaults["WIDTH_FUDGE"] '0.75';
        set $option_defaults["WIDTH_POINTS"] 'none';
        set $option_defaults["ZOOM"] '100';

        trigger config_debug_set_options_defaults;
        trigger set_valid_option_values;
    end;

    define event set_valid_option_values;
        trigger set_yes_no_option_values;
    end;

    define event set_yes_no_option_values;
        eval $yes_no['yes'] 1;
        eval $yes_no['on'] 1;
        eval $yes_no['no'] 0;
        eval $yes_no['off'] 0;
    end;

    define event check_yes_no;
        unset $answer;
        break /if ^$option;
        set $no_answer "true";
        iterate $yes_no;
        do /while _name_;
            do /if cmp($option, _name_);
                eval $answer _value_;
                unset $no_answer;
            done;
            next $yes_no;
        done;
        do /if $no_answer;
            putlog "Warning: Yes/No options only take, yes, no, on, or off as valid values";
            /*putlog "%3z Yes/No options only take, yes, no, on, or off as valid values";*/
        done;
    end;

    define event do_yes_no;
        unset $option;
        set $option $options[$option_key];
        set $option $mvar /if ^$option;
        set $option $option_defaults[$option_key] /if ^$option;
        
        trigger check_yes_no;
        unset $mvar;
    end;


    define event check_numeric;
        unset $answer;
        break /if ^$option;
        eval $answer inputn($option, 'BEST');
        do /if missing($answer);
            set $option $optionDefault;
            eval $answer inputn($option, 'BEST');
        done;
    end;

    define event do_numeric;
        unset $option;
        unset $optionDefault;
        set $option $options[$option_key];
        set $option $mvar /if ^$option;
        set $optionDefault $option_defaults[$option_key];
        set $option $optionDefault /if ^$option;

        trigger check_numeric;
        unset $mvar;
    end;

    define event do_none_numeric;
        unset $option;
        unset $optionDefault;
        set $option $options[$option_key];
        set $optionDefault $option_defaults[$option_key];
        set $option $optionDefault /if ^$option;

        do /if ^cmp($option, 'none');
            trigger check_numeric;
        done;
        do /if cmp($option, 'none');
            unset $answer;
        done;
    end;

    define event do_string_option;
        unset $option;
        unset $answer;
        set $option $options[$option_key];
        set $option $mvar /if ^$option;
        set $option $option_defaults[$option_key] /if ^$option;

        do /if ^cmp($option, 'none');
            set $answer $option;
        done;
        unset $mvar;
    end;

    define event top_file;
        start:
            put HTMLDOCTYPE nl;
            put "<html>" nl;
        finish:
            put "</body>" nl;
            put "</html>" nl;
    end;

    define event top_head;
        start:
            put "<head>" nl;
            put VALUE nl;
        finish:
            put "</head>" nl;
            put "<body>" nl;
    end;

    define event top_title;
        put "<title>";
        put tagset " Help "  / if !exists(value);
        put VALUE;
        put "</title>" nl;
    end;

    define event top_code;

        put "<h1>Quick Reference for " tagset "</h1>" nl;


        put "<p>This document is a quick reference to options for " tagset "." nl;
        put "Included at the bottom of the page is a ";
        put '<a href="#changelog">history of the changes</a> that have been made to the tagset.' nl;


       put "<p>" nl;
       put "<hr>" nl;
       put "<h2>Short Descriptions of the Supported Options</h2>" nl;

        put "<table><thead>" nl;
        put '<tr><th style="text-align:left">Name</th>' nl;
        put '<th style="text-align:left">Default Value</th><th style="text-align:left">Description</th></tr>' nl;

        put "</thead><tbody>" nl;

        iterate $valid_options;
        do /while _name_;
            unset $option;
            do /if ^cmp(_name_,"#$bogus");
                put '<tr><th style="text-align: left">' _name_ '</th><td>' $option_defaults[_name_] '</td>' ;
                put '<td>' _value_ '</td></tr>' nl;
            done;
            next $valid_options;
        done;
        put "</tbody>" nl;
        put "</table>" nl;

        put "<p>";
        trigger changes start;
        put "<hr>" nl;
        put '<p><a name="changelog"></a>' nl;
        put "<h2>History of Changes for This Tagset</h2>";

        iterate $changelog;
        do /while _value_;

            set $ctrl substr(_value_, 1, 1);

            do /if cmp(_value_, '-');  /* dashed line */
                put "</li>" /if $li;
                put "</ul><p>" nl /if $ul;
                unset $li;
                unset $ul;
                put "<hr>";
            else /if cmp($ctrl, '.');  /* flush with margin line */
                put "</li>" /if $li;
                put "</ul></ul>" nl /if $ul;
                unset $li;
                put "<p>" substr(_value_, 2) '<ul>' nl;
                set $ul 'true';
            else /if cmp($ctrl, ' ');  /* indented line */
                put strip(_value_) nl;
            else;
                put "</li>" nl /if $li;
                put "<li>" _value_ nl;  /* bulleted  line */
                set $li 'true';
            done;
            next $changelog;
            unset $ctrl;
        done;
        put "</li>" /if $li;
        put "</ul></ul>" nl /if $ul;
        put "<hr>" nl;
        trigger changes finish;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- An event to call from the ods statement.  This is so that  --*/
    /*-- 9.1 users can set options since they don't have an         --*/
    /*-- options(..) on the ods statement.                          --*/
    /*--                                                            --*/
    /*-- Use it like this.                                          --*/
    /*--                                                            --*/
    /*-- ods tagsets.excelxp event=option(name="doc" text="help");  --*/
    /*--                                                            --*/
    /*-- Be sure to look at using a configuration_file.  That can   --*/
    /*-- set a lot of options easily.                               --*/
    /*--------------------------------------------------------17Oct06-*/
    define event option;
        set $name upcase(name);
        set $options[$name] value;
        trigger options_setup;
        trigger documentation;
    end;
    /*-----------------------------------------------------------eric-*/
    /*-- excel can currently only handle one table per worksheet so --*/
    /*-- any options other than table or bygroup will not work.     --*/
    /*-- The specification reads like that may change in the future --*/
    /*-- so I'll leave the code in place for now.                   --*/
    /*--------------------------------------------------------21Jul03-*/
    /*
    log_note = 'NOTE: Experimental Excel XP tagset. Use alias=("proc" | "page" | "bygroup" | "table" | "none") to determine how worksheets will be created.  The default is page.';
    */

    /*-------------------------------------------------------------eric-*/
    /*-- The specification for this xml is here.                      --*/
    /*-- http://msdn.microsoft.com/library/default.asp?               --*/
    /*--        url=/library/en-us/dnexcl2k2/html/odc_xlsmlinss.asp   --*/
    /*----------------------------------------------------------4Jul 03-*/

    /*-------------------------------------------------------------eric-*/
    /*-- Use this event to reset the worksheet interval to what was   --*/
    /*-- given on the ods statement or to the default.  If no value   --*/
    /*-- is given then it will reset.  If a value of proc, page,      --*/
    /*-- bygroup, table, or none is given then the interval will be   --*/
    /*-- set to the value given.                                      --*/
    /*-- Use like this:                                               --*/
    /*--                                                              --*/
    /*-- ods tagsets.excelxp event=sheet_interval(text="bygroup");    --*/
    /*--                                                              --*/
    /*-- or to reset the interval                                     --*/
    /*--                                                              --*/
    /*-- ods tagsets.excelxp event=sheet_interval;                    --*/
    /*----------------------------------------------------------4Jul 03-*/
    define event documentation;
        break /if ^$options;
        do /if cmp($options['DOC'], 'quick');
            trigger help;
            trigger list_options;
        done;
        do /if cmp($options['DOC'], 'help');
            trigger help;
            trigger reference;
        done;
        do /if cmp($options['DOC'], 'all');
            trigger help;
            trigger changelog;
            trigger list_options;
            trigger reference;
            trigger settings;
        done;
        trigger settings /if cmp($options['DOC'], 'settings');
        trigger changelog /if cmp($options['DOC'], 'changelog');
    end;

    define event list_options;
        iterate $valid_options;
        putlog "==============================================================================";
        putlog "Short descriptions of the supported options";
        putlog "==============================================================================";
        putlog "Name     : Current value  :  Description";
        putlog " ";
        do /while _name_;
            unset $option;
            set $option $options[_name_];
            set $option $option_defaults[_name_] /if ^$option;
            do /if ^cmp(_name_,"#$bogus");
                putlog _name_ " : " $option  " : " _value_;
            done;
            next $valid_options;
        done;
        putlog " ";
    end;

    define event help;
        putlog "==============================================================================";
        putlog "The EXCELXP Tagset Help Text.";
        putlog " ";
        putlog "This Tagset/Destination creates Microsoft's spreadsheetML XML.";
        putlog "It is used specifically for importing data into Excel.";
        putlog " ";
        putlog "Each table will be placed in its own worksheet within a workbook.";
        putlog "This destination supports ODS styles, traffic lighting, and custom formats.";
        putlog " ";
        putlog "Numbers, Currency and percentages are correctly detected and displayed.";
        putlog "Custom formats can be given by supplying a style override on the tagattr";
        putlog "style element.";
        putlog " ";
        putlog "By default, titles and footnotes are part of the spreadsheet, but are part";
        putlog "of the header and footer.";
        putlog " ";
        putlog "Also by default, printing will be in 'Portrait'.";
        putlog "The orientation can be changed to landscape.";
        putlog " ";
        putlog "The specification for this xml is here.";
        putlog "http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnexcl2k2/html/odc_xlsmlinss.asp";
        putlog " ";
        putlog "See Also:";
        putlog "http://support.sas.com/rnd/base/topics/odsmarkup/";
        putlog "http://support.sas.com/rnd/papers/index.html#excelxml";
        putlog " ";
        putlog " ";
        putlog "Sample usage:";
        putlog " ";
        putlog "ods tagsets.excelxp file='test.xml' contents='index.xml' data='test.ini' options(doc='Help'); ";
        putlog " ";
        putlog "ods tagsets.excelxp options(doc='Quick'); ";
        putlog " ";
        putlog "ods tagsets.excelxp options(embedded_titles='No' Orientation='Landscape'); ";
        putlog " ";
    end;

    define event reference;
        putlog "==============================================================================";
        putlog " ";
        putlog "Long descriptions of the supported options";
        putlog " ";
        putlog "Doc:  No default value.";
        putlog "     Help: Displays introductory text and available options in full detail.";
        putlog "     Quick: Displays introductory text and an alphabetical list of options,";
        putlog "            their current value, and a short description";
        putlog "     Settings: Displays config/debug settings.";
        putlog "     Changelog: Lists the changes in reverse chronological order.";
        putlog "     All: Shows the output from all the help options.";
        putlog " ";
        putlog "Orientation:   Default Value 'Portrait'";
        putlog "     Tells excel how to format the page when printing.";
        putlog "     The only other value is 'landscape'.";
        putlog "     Also available as a macro variable.";
        putlog " ";
        putlog "Embedded_Titles:   Default Value 'No'";
        putlog "     If 'Yes' titles will appear in the worksheet.";
        putlog "     By default, titles are a part of the print header and footer.";
        putlog "     Also available as the macro variable, embedded_titles.";
        putlog " ";
        putlog "Embedded_Footnotes:   Default Value 'No'";
        putlog "     If 'Yes' footnotes will appear in the worksheet.";
        putlog "     By default, footnotes are a part of the print header and footer.";
        putlog "     Also available as the macro variable,  embedded_footers";
        putlog " ";
        putlog "Embed_Titles_Once:   Default Value 'No'";
        putlog "     If 'Yes' Embedded titles will only appear at the top of each worksheet.";
        putlog " ";
        putlog "Print_Header:   Default Value ''";
        putlog "     If Embedded titles are on, this value will be used as the header for";
        putlog "     printing.  Everything about the appearance of the 3 part header can";
        putlog "     be controlled with this value.  The Excel syntax for this string follows.";
        putlog "     Of course the easiest way to create a header or footer is to do it in";
        putlog "     Excel.  Then save the workbook to xml.  Search the XML for <Header or" ;
        putlog "     <footer.  A simple cut and past will make it a part of your SAS program.";
        putlog " ";
        putlog '          &amp;L <Left header>  &amp;C  <Center header>  &ampR  <Right Header>';
        putlog " ";
        putlog "     A very simple example is this:";
        putlog " ";
        putlog '          &amp;LLeft header text&amp;CCenter header text&ampRRight Header Text';
        putlog " ";
        putlog '     Newlines can be introduced by inserting &#13; within the text.';
        Putlog "     Other special values follow ";
        putlog " ";
        putlog '          Newline:     &#13;';
        putlog '          Page Number: &amp;P';
        putlog '          Pages:       &amp;N';
        putlog '          Date:        &amp;D';
        putlog '          Time:        &amp;T';
        putlog '          File Path:   &amp;Z&amp;F';
        putlog '          File:        &amp;F';
        putlog '          Sheet Name:  &amp;A';
        putlog '          Underline:   &amp;U    One to start underlining, another to stop it.';
        putlog '          Font Size:   &amp;8';
        putlog " ";
        putlog "     The font size can be controlled by placing the font size in points right";
        putlog "     before the text.  This is a left sided header with a font size of 8.";
        putlog " ";
        putlog '          &amp;L&amp;&amp;8This is a test;';
        putlog " ";
        putlog "     The font, bold and Italic can be changed using this syntax.";
        putlog " ";
        putlog '          &quot; <font name>, <Bold><Italic> &quot;';
        putlog " ";
        putlog "     This example changes the font, turns on bold and Italic, changes the font size";
        putlog "     and turns underline on and off.";
        putlog " ";
        putlog '     &amp;L&amp;&quot;Palatino,Bold Italic&quot;&amp;9&amp;UThis is a test&amp;U';
        putlog " ";
        putlog "     This is a complete example, showing the various possibilities";
        putlog " ";
        putlog '&amp;L&amp;&quot;Palatino,Bold Italic&quot;&amp;9&amp;UThis is underlined &amp;U';
        putlog 'This is not &#13;&amp;12This is bigger&amp;CThis is the Center&#13;Page: &amp;P&#13;';
        putlog 'Pages: &amp;N&#13;Date: &amp;D&#13;Time: &amp;T&#13;Path: &amp;Z&amp;F&#13;';
        putlog 'File: &amp;F&#13;Sheet: &amp;A&amp;R&amp;14This is bigger and on the right&#13;&amp;P';
        putlog " ";
        putlog " ";
        putlog "Print_Footer:   Default Value ''";
        putlog "     If Embedded footers are on, this value will be used as the footer for";
        putlog "     printing.  Everything about the appearance of the 3 part header can";
        putlog "     be controlled with this value.  The syntax for this value is the same";
        putlog "     as that for the Print_Header option.";
        putlog " ";
        putlog "Print_Header_margin:   Default Value ''";
        putlog "     This is the header margin as set in the page setup dialog window.";
        putlog "     Valid values are measurements in inches.  The default is 0.5.";
        putlog " ";
        putlog "Print_Footer_margin:   Default Value ''";
        putlog "     This is the footer margin as set in the page setup dialog window.";
        putlog "     Valid values are measurements in inches.  The default is 0.5.";
        putlog " ";
        putlog "Suppress_Bylines:   Default Value 'No'";
        putlog "     If 'Yes' Bylines will not appear in the worksheet.  This is useful with";
        putlog "     Proc Print because turning off bylines will defeat the tagset's bygroup";
        putlog "     processing abilities when using proc print.";
        putlog " ";
        putlog "Zoom:   Default Value '100'";
        putlog "     This value determines the zoom level on the worksheet.";
        putlog " ";
        putlog "Scale:   Default Value '100'";
        putlog "     This value determines the scale level for printing";
        putlog " ";
        putlog "DPI:   Default Value '300'";
        putlog "     This value determines the dots per inch for printing";
        putlog " ";
        putlog "Pages_FitWidth:   Default Value '1'";
        putlog "     This value determines the number of pages to fit the worksheet across";
        putlog "     when printing.";
        putlog " ";
        putlog "Pages_FitHeight:   Default Value '1'";
        putlog "     This value determines the number of pages down to fit the worksheet";
        putlog "     when printing.";
        putlog " ";
        putlog "FitToPage:   Default Value 'no'";
        putlog "     Fit to Page when printing.";
        putlog " ";
        putlog "Page_Order_Across:   Default Value 'no'";
        putlog "     If set to yes, the worksheet page order will be set to print across,";
        putlog "     then down.";
        putlog " ";
        putlog "Center_Vertical:   Default Value 'no'";
        putlog "     This value controls vertical centering for printing";
        putlog " ";
        putlog "Center_Horizontal:   Default Value 'no'";
        putlog "     This value controls horizontal centering for printing";
        putlog " ";
        putlog "Gridlines:   Default Value 'no'";
        putlog "     This value turns on gridlines for printing.";
        putlog " ";
        putlog "Hidden_Columns:   Default Value 'none'";
        putlog "     Values: None, number, number list, number range.";
        putlog "     All columns listed will be marked as hidden.";
        putlog "     The value can be a comma separated list of numbers or ranges";
        putlog "     Spaces will be ignored.";
        putlog "     ie.  Hidden_Columns='3,4,9-10'";
        putlog " ";
        putlog "BlackAndWhite:   Default Value 'no'";
        putlog "     This value turns on black and White for printing.";
        putlog " ";
        putlog "DraftQuality:   Default Value 'no'";
        putlog "     This value turns on draft quality for printing.";
        putlog " ";
        putlog "RowColHeadings:   Default Value 'no'";
        putlog "     This value turns on row and Column headings for printing.";
        putlog " ";
        putlog "Row_Repeat:   Default Value 'none'";
        putlog "     Values: None, number, range, header.";
        putlog "     If a number is specified that row will be repeated across pages.";
        putlog "     When a worksheet breaks across pages when printing.";
        putlog "     If a range such as '3-5' is given, that range of rows will be";
        putlog "     repeated.  If 'header' is given,  the table headers for the first";
        putlog "     table of the worksheet will be repeated.";
        putlog " ";
        putlog "Column_Repeat:   Default Value 'none'";
        putlog "     Values: None, number, range, header.";
        putlog "     If a number is specified that column will be repeated across pages.";
        putlog "     When a worksheet breaks across pages when printing.";
        putlog "     If a range such as '3-5' is given, that range of columns will be";
        putlog "     repeated.  If 'header' is given,  the columns that contain the";
        putlog "     row headers for the first table of the worksheet will be repeated.";
        putlog " ";
        putlog "Frozen_Headers:   Default Value 'No'";
        putlog "     Values: Yes, No, number.";
        putlog "     If 'Yes' The rows down to the bottom of the headers will be frozen when";
        putlog "     the table data scrolls.  This includes any titles created with the";
        putlog "     embedded titles option.  If a number is given, that is the row count";
        putlog "     that will be frozen.";
        putlog "     Also available as a macro variable.";
        putlog " ";
        putlog "Frozen_RowHeaders:   Default Value 'No'";
        putlog "     Values: Yes, No, number.";
        putlog "     If 'Yes' The header columns on the left will be frozen when";
        putlog "     the table data scrolls.  If a number is given, that is the column";
        putlog "     count that will be frozen.";
        putlog "     Also available as a macro variable.";
        putlog " ";
        putlog "AutoFilter:   Default Value 'none'";
        putlog "     Values: None, All, range.";
        putlog "     If 'all' An auto filter will be applied to all columns.";
        putlog "     If a range such as '3-5' The auto filter will be applied to the";
        putlog "          in that range of columns.";
        putlog " ";
        putlog "AutoFilter_Table:   Default Value '1'";
        putlog "     Values: Any number";
        putlog "     If sheet interval is anything but table or bygroup, this value";
        putlog "     Determines which table gets the autofilter applied.  If the sheet";
        putlog "     interval is table, or bygroup the only table get's the autofilter";
        putlog "     regardless of this setting.";
        putlog " ";
        putlog "Formulas:   Default Value 'yes'";
        putlog "     Values: yes, no";
        putlog "     By default, data values that start with an '=' will become formulas";
        putlog "     instead of cell values.  This behavior can be turned off by setting";
        putlog "     this option to 'no'.  Excel only understands relative column references";
        putlog "     in it's XML.  A formula like sum(C2,C3) or A2+B3 will not work.";
        putlog "     An equivalent might be sum(R[-2]C,R[-1]C) or RC[-2]+RC[-1].";
        putlog "     See the Proc Print example under Default_Column_Width.";
        putlog " ";
        putlog "Width_Fudge:   Default Value '0.75'";
        putlog "     Values: None, Number.";
        putlog "     By default this value is used along with Width_Points and column width";
        putlog "     to calculate an approximate width for the table columns.";
        putlog "     width = Data_Font_Points * number_Of_Chars * Width_Fudge.";
        putlog "     If 'none' this feature is turned off.";
        putlog " ";
        putlog "Width_Points:   Default Value 'None'";
        putlog "     Values: None, Number.";
        putlog "     By Default the point size from the data or header style";
        putlog "     elements are used to calculate a pseudo column width.";
        putlog "     The column width is calculated from the given column width or";
        putlog "     the length of the column's header text.  If the header is bigger.";
        putlog "     In the case the header length is used, so is the header's point size.";
        putlog "     This value overrides that point size.";
        putlog "     This value is used along with WidthFudge and column width";
        putlog "     to calculate an approximate width for the table columns.";
        putlog "     width = Width_Points * number_Of_Chars * Width_Fudge.";
        putlog " ";
        putlog "Default_Column_Width:   Default Value 'None'";
        putlog "     Values: None, Number, list of numbers.";
        putlog "     Most procedures provide column widths, but occasionally a column";
        putlog "     will not have a width.  Excel will resize the column to fit any";
        putlog "     numbers but will not auto-size for character string headings.";
        putlog "     In the case that a column does not have a width, this value will be";
        putlog "     used instead.  The value should be the width in characters.";
        putlog "     If the value of this option is a comma separated list.";
        putlog "     Each number will be used for the column in the same position.  If";
        putlog "     the table has more columns, the list will start over again.";
        putlog " ";
        putlog "Absolute_Column_Width:   Default Value 'None'";
        putlog "     Values: None, Number, list of numbers.";
        putlog "     This option works similarly to the default column width option";
        putlog "     The difference is that these widths will be used regardless";
        putlog "     of any column widths the procedure might provide.";
        putlog "     The value should be the width in characters.";
        putlog "     If the value of this option is a comma separated list.";
        putlog "     Each number will be used for the column in the same position.  If";
        putlog "     the table has more columns, the list will start over again.";
        putlog " ";
        putlog "Row_Heights:   Default Value '0,0,0,0,0,0,0'";
        putlog "     This option controls how tall the rows will be for each type of row.";
        putlog "     The numbers are in points.  By default the values will be taken from the";
        putlog "     font size used for the row.  The font sizes are collected from the style";
        putlog "     definitions for each item.  The table row height is defined by the font";
        putlog "     size in the header style.";
        putlog " ";
        putlog "     The parameters of this option are positional, but not all values must be";
        putlog "     specified.   A value of 0 means that the height should be taken from the style.";
        putlog "     The first value is the height for table header rows. The next is the height ";
        putlog "     for the table body rows. ";
        putlog "     The next value is the row height for bylines.  The fourth is for titles,  ";
        putlog "     the fifth is for footers, the sixth is the pagebreak height, ";
        putlog "     and the last value is the height for paragraph skip";
        putlog " ";
        putlog "     The default values are:";
        putlog "     Table_head  : 0 ";
        putlog "     Table  : 0 ";
        putlog "     Byline : 0 ";
        putlog "     Title  : 0 ";
        putlog "     Footer : 0 ";
        putlog "     PageBreak : 0 ";
        putlog "     Parskip : 0 ";
        putlog " ";
        putlog "row_height_fudge:   Default Value '4'";
        putlog "     Values: Number.";
        putlog "     This value is added to the row height for each row.  The additional height";
        putlog "     makes the spreadsheet easier to read.";
        putlog " ";
        putlog "Autofit_height:   Default Value 'no'";
        putlog "     Values: yes, no";
        putlog "     If yes no row heights will be specified.  This allows the auto fit height";
        putlog "     of Excel to do it's job, sometimes not so well.";
        putlog " ";
        putlog "Sheet_Interval:   Default Value 'Table'";
        putlog "     Values: Table, Page, Bygroup, Proc, None.";
        putlog "     This option controls how many tables will go in a worksheet.";
        putlog "     In reality only one table is allowed per worksheet.  To get more";
        putlog "     than one table, the tables are actually combined into one.";
        putlog " ";
        putlog "     Specifying a sheet interval will cause the current worksheet to close.";
        putlog "     It is recommended that this always be the first option to insure that";
        putlog "     The options following it apply to the new worksheet rather than the";
        putlog "     last worksheet.";
        putlog " ";
        putlog "Sheet_Name:   Default Value 'None'";
        putlog "     Values: Any string ";
        putlog "     Worksheet names can be up to 31 characters long.  This name will";
        putlog "     be used in combination with a worksheet counter to create a unique name.";
        putlog " ";
        putlog "Blank_Sheet:   Default Value 'None'";
        putlog "     Values: Any string ";
        putlog "     Create a blank worksheet with the name given.";
        putlog "     Worksheet names can be up to 31 characters long.  This name will";
        putlog "     be used in combination with a worksheet counter to create a unique name.";
        putlog " ";
        putlog "Sheet_Label:   Default Value 'None'";
        putlog "     Values: Any String";
        putlog "     This option is used in combination with the various worksheet naming.";
        putlog "     heuristics which are based on the sheet interval.";
        putlog "     This string will be used as the first part of the name instead of the";
        putlog "     predefined string it would normally use.";
        putlog " ";
        putlog "     These are the defaults:";
        putlog " ";
        putlog "     'Proc ' total_Proc_count  - label";
        putlog "     'Page ' total_page_count  - label";
        putlog "     'By '   numberOfWorksheets byGroupLabel - label";
        putlog "     'Table ' numberOfWorksheets  - label";
        putlog " ";
        putlog "Contents_Workbook:   Default Value 'Contents, Index'";
        putlog "     Values: Contents, Index, Workbooks, All";
        putlog "     If set to all, The contents file will contain 3 worksheets,";
        putlog "     a list of workbooks,  a hierarchical table of contents, and a";
        putlog "     list of worksheets. ";
        putlog " ";
        putlog "Contents:   Default Value 'No'";
        putlog "     Values: Yes, No";
        putlog "     If set to yes, The first worksheet will contain a table of contents";
        putlog "     With links to each worksheet in the workbook.";
        putlog " ";
        putlog "Index:   Default Value 'No'";
        putlog "     Values: Yes, No";
        putlog "     If set to yes, The first worksheet will contain a table of contents";
        putlog "     With a single link to each worksheet in the workbook. If both this";
        putlog "     option and the Contents option are set, then the index of worksheets";
        putlog "     will be the second worksheet and it will be named 'Worksheets'.";
        putlog " ";
        putlog "Missing_Align:   Default Value 'right'";
        putlog "     Values: left, center, right";
        putlog "     Sets the alignment for missing values.";
        putlog "     By default a dataMissing style is created from the data style, the ";
        putlog "     dataMissing style is created in 3 versions.  One for each justification.";
        putlog "     When a style has the string 'data' in it's name, the value is checked.";
        putlog "     If it is missing then the dataMissing style will be used instead.";
        putlog "     A dataMissing style can be provided in the style.  If found, the tagset";
        putlog "     will use that style as a basis for the 3 dataMissing styles.";
        putlog " ";
        putlog "Auto_SubTotals:   Default Value 'No'";
        putlog "     Values: Yes, No";
        putlog "     If yes, this option causes a subtotal formula to be placed in the";
        putlog "     subtotal cells on the last table row of the Print Procedure's tables.";
        putlog "     WARNING: This does not work with Sum By.  It only works if the ";
        putlog "     totals only happen once per table.  It also does not work if the by value";
        putlog "     and the id value match.";
        putlog " ";
        putlog "Convert_Percentages:   Default Value 'Yes'";
        putlog "     Remove percent symbol, apply excel percent format, and multiply by 100.";
        putlog "     This causes percentage values to display as numeric percentages in Excel.";
        putlog "     If 'No' percentage values will be untouched and will appear as";
        putlog "     strings in Excel.";
        putlog "     Will be deprecated in a future release when it is no longer needed.";
        putlog " ";
        putlog "Currency_symbol:   Default Value '$'";
        putlog "     Used for detection of currency formats and for ";
        putlog "     removing those symbols so excel will like them.";
        putlog "     Will be deprecated in a future release when it is";
        putlog "     no longer needed.        ";
        putlog " ";
        putlog "Currency_format:   Default Value 'Currency'";
        putlog "     The currency format specified for excel to use.";
        putlog "     Another possible value is 'Euro Currency'.";
        putlog "     Will be deprecated in a future release when it is";
        putlog "     no longer needed.        ";
        putlog " ";
        putlog "Decimal_separator:   Default Value '.'";
        putlog "     The character used for the decimal point.";
        putlog "     Will be deprecated in a future release when it is no longer needed.";
        putlog " ";
        putlog "Thousands_separator:   Default Value ','";
        putlog "     The character used for indicating thousands in numeric values.";
        putlog "     Used for removing those symbols from numerics so excel will like them.";
        putlog "     Will be deprecated in a future release when it is no longer needed.";
        putlog " ";
        putlog "Ascii_dots:   Default Value 'yes'";
        putlog "     By default, batch/ascii output is prefixed by a dot to preserve leading spaces,";
        putlog "     this is not always desirable.  Particularly when doing puts with data step.";
        putlog "     This option allows the dots to be turned off.";
        putlog " ";
        putlog "Numeric_Test_Format:   Default Value '12.'";
        putlog "     Used for determining if a value is numeric or not.";
        putlog "     Other useful values might be COMMAX or NLNUM formats.";
        putlog "     Will be deprecated in a future release when it is no longer needed.";
        putlog " ";
        putlog "Minimize_Style:   Default Value 'No'";
        putlog "     If set to 'yes' the stylesheet will be filtered so that only the most.";
        putlog "     necessary definitions are printed.  This can have the reverse effect";
        putlog "     if style attribute over rides are used on the proc statements.";
        putlog "     It is best to define a new style with the appropriate over rides built in.";
        putlog "     The proc can use the new style, but without individual attribute over-rides.";
        putlog "     The result is a much smaller style section. - In that case, this option";
        putlog "     should be set to No.";
        putlog " ";
        putlog "Skip_Space:   Default Value '1,0,1,1,1'";
        putlog "     This option controls how much space follows the different types of output";
        putlog "     that can occur within a worksheet.  The number given is a multiplier that";
        putlog "     is used against the height given in the Parskip style element.  In the";
        putlog "     absence of the Parskip style element the font size from the Header";
        putlog "     style is used.";
        putlog " ";
        putlog "     The parameters of this option are positional, but not all values must be";
        putlog "     specified.   The first value is for the space following each table.  The";
        putlog "     second value is the space following bylines.  The third is for titles,  ";
        putlog "     the fourth is for footers and the last value is the space following";
        putlog "     pagebreaks if the do_pagebreak option is turned on and a pagebreak style";
        putlog "     element exists.";
        putlog " ";
        putlog "     The default values are:";

        putlog "     Table  : 1 ";
        putlog "     Byline : 0 ";
        putlog "     Title  : 1 ";
        putlog "     Footer : 1 ";
        putlog "     PageBreak : 1 ";
        putlog " ";
        putlog "PageBreaks:   Default Value 'No'";
        putlog "     If set to 'yes' page breaks will be inserted into the stylesheet.  The";
        putlog "     pagebreak style element will be used to define what that pagebreak looks";
        putlog "     like.  A sample style definition looks like this.";
        putlog " ";
        putlog "                 style pagebreak /";
        putlog "                     cellheight=8";
        putlog "                     foreground=black";
        putlog '                     tagattr="HorzStripe";';
        putlog " ";
        putlog "     It is not necessary to have a style element.  In it's absence a blank row";
        putlog "     will be inserted.";
        putlog " ";
        putlog " ";
        putlog " ";
        putlog "Using Style Elements";
        putlog "     ";
        putlog "     There are a few style attributes that can be used to good effect";
        putlog "     in the ExcelXP tagset.  The TagAttr attribute can be used to add";
        putlog "     formula's and formats.  CellWidth can be used to control the column";
        putlog "     widths.  Flyover can be used to add comments to cells.";
        putlog "     A URL on a cell will cause it to be a link.";
        putlog "     Additionally, Formulas can be given as the actual data values.";
        putlog "     ";
        putlog "     An alternative to setting widths is to use the cellwidth / width";
        putlog "     Style attribute.  This value will be used regardless of any other";
        putlog "     column width calculations.  Cellwidth can be specified in any of";
        putlog "     These units.  Inch, centimeter, millimeter, points  or pixel.";
        putlog "     If a cellwidth for column is given more than once, the first width";
        putlog "     is used.  This can happen when there is more than one table per";
        putlog "     worksheet.";
        putlog " ";
        putlog "     The following example shows formulas as data, comment text on a";
        putlog "     header, and absolute control of a columns width.";
        putlog "     ";
        putlog "     ";
        putlog "     ods tagsets.excelxp file='test.xml' options(zoom='75');";
        putlog "     ";
        putlog "     data test;";
        putlog "     length a b 8 c $20;";
        putlog "     input a b c $;";
        putlog "     cards;";
        putlog "     1 2 3";
        putlog "     2 3 =RC[-2]+RC[-1]";
        putlog "     3 4 =RC[-2]+RC[-1]";
        putlog "     . . =SUM(R[-3]C:R[-1]C)";
        putlog "     ;";
        putlog "     run;";
        putlog "     ";
        putlog "     ";
        putlog "     proc print noobs;";
        putlog "         var a b;";
        putlog '         var c / style(head) = {flyover="Hello World"}";';
        putlog "             style(data) = {cellwidth=50pt};";
        putlog "     run;";
        putlog " ";
        putlog "     ods tagsets.excelxp close;";
        putlog " ";
        putlog " ";
        putlog "TagAttr Style Element:   Default Value ''";
        putlog "     Values: <ExcelFormat> or";
        putlog "     <Type: dataType>";
        putlog "     <Format: ExcelFormat>";
        putlog "     <Formula: ExcelFormula>";
        putlog "     <Rotate: degrees of rotation.>";
        putlog "     <Hidden: Yes/No.>";
        putlog "     <mergeacross: yes/No/number>";
        putlog "     This is not a tagset option but a style attribute that the tagset will";
        putlog "     use to get formula's and column formats. One caveat, is that there should be";
        putlog "     no space between the : and the value for any of these settings.";
        putlog "     The format and formula's given must be valid to excel.";
        putlog "     The rotation must be a valid angle for text, 90 through -90.";
        putlog "     The only recognized value for Hidden is yes.  When set to yes on any cell, that";
        putlog "     row will be hidden.";
        putlog "     MergeAcross is to force a cell to merge across the current width of the worksheet.";
        putlog "     Using a number will cause the cell to merge across that many columns.";
        putlog "     The Type should be General, String, Number, or DateTime. Excel is case sensitive";
        putlog "     It should be unnecessary to specify type except when DateTime is being used.";
        putlog "     Even when doing numbers as text format";
        putlog " ";
        putlog "     A single value without a keyword is interpreted as a format.";
        putlog "     A formula, format and rotation can be specified together with keywords.";
        putlog "     There should be no spaces except for those between the two values";
        putlog "     The keyword and value must be separated by a ':'";
        putlog "     tagattr='format:###.## formula:SUM(R[-4]C:R[-1]C rotate:90').";
        putlog " ";
        putlog "      Text ---- @";
        putlog "  ";
        putlog "      Type = DateTime";
        putlog "      Time - 0:00        ----  Short Time";
        putlog "      Time - 0:00:0      ----  h:mm:s";
        putlog "      Time - 00:00.0     ----  mm:ss.0";
        putlog "      Time - 00:00 AM    ----  Medium Time";
        putlog "      Time - 12:00:00 AM ----  Long Time";
        putlog "      Time - 24:00:00    ----  [h]:mm/:s";
        putlog "      Time - 3/14/01 1:30 PM ----  m/d/yy\ h:mm\ AM/P ";
        putlog "  ";
        putlog "      Percentage - 6 decimals  ----  0.00000%%";
        putlog "      Special - zip code       ----  00000";
        putlog "      Special - zip code + 4   ----  00000\-0000";
        putlog "  ";
        putlog "      Scientific                      ---- Scientific";
        putlog "      Scientific - 4 decimals         ---- 0.0000E+00 ";
        putlog "      Fraction - As sixteenths (8/16) ---- #\ ??/1";
        putlog "  ";
        putlog "  ";
        putlog "Margins:";
        putlog "     Margins can be set two ways.  With the system options or through styles.";
        putlog "     The system options win over the style settings.  In the style, the margins";
        putlog "     must be set on the 'Body' style element.";
        putlog " ";
        putlog "     Setting the margins with the options statement is the easiest.";
        putlog " ";
        putlog "     options topmargin=1in";
        putlog "             bottommargin=1in";
        putlog "             leftmargin=.5in";
        putlog "             rightmargin=.5in;";
        putlog " ";
        putlog "     As as style definition, the Body element might look like this.  This ";
        putlog "     approach is more reusable since each program that uses the style ";
        putlog "     automatically gets the margins";
        putlog " ";
        putlog "     style Body from Body /";
        putlog "         topmargin=.5in";
        putlog "         leftmargin=.25in;";
        putlog " ";
        putlog "Options Center/NoCenter";
        putlog "     Setting the center/nocenter option will cause titles and bylines to be";
        putlog "     centered or left justified within the worksheet.  If nocenter is set";
        putlog "     the cells are not merged.  This causes excel to do a better job of";
        putlog "     printing when the text is long.";
        putlog " ";
        putlog "     options nocenter;";



        trigger config_debug_help;

        putlog "==============================================================================";
    end;

    define event compile_regexp;

        /*
            unset $currency_sym;
            unset $decimal_separator;
        unset $thousands_separator;

        */
            /*=========================================================*/
            /* If the currency symbol, decimal separator, or thousands */
            /* separator are Perl regular expression metacharacters,   */
            /* then they must be escaped with a backslash.             */
            /*=========================================================*/

            set $currency_sym "\" $currency;
            set $currency_sym "\$" /if ^$currency_sym;

            set $decimal_separatorsym  $decimal_separator;
            set $decimal_separatorsym  "\." /if ^$decimal_separatorsym;
            set $decimal_separatorsym "\" $decimal_separator /if cmp($decimal_separator, '.');

            set $thousands_separatorsym  $thousands_separator;
            set $thousands_separatorsym "," /if ^$thousands_separatorsym;
            set $thousands_separatorsym "\" $thousands_separator /if cmp($thousands_separator, '.');

            set $punctuation $currency $thousands_separator "%";

            set $integer_re   "\d+";
            set $sign_re      "[+-]?";
            set $group_re     "\d{1,3}(?:" $thousands_separatorsym "\d{3})*";
            set $whole_re     "(?:" $group_re "|" $integer_re ")";
            set $exponent_re  "[eE]" $sign_re $integer_re;
            set $fraction_re  "(?:" $decimal_separatorsym "\d*)";
            set $real_re      "(?:" $whole_re $fraction_re "|" $fraction_re $integer_re "|" $whole_re ")";
            set $percent_re   $sign_re $real_re "\%";
            set $scinot_re    $sign_re "(?:" $real_re $exponent_re "|" $real_re ")";
            set $cents_re     "(?:" $decimal_separatorsym "\d\d)";
            set $money_re     $sign_re $currency_sym "(?:" $whole_re $cents_re "|" $cents_re "|" $whole_re ")";
            set $number_re    "/^(?:" $real_re "|" $percent_re "|" $scinot_re "|" $money_re ")\Z/";
            eval $number prxparse($number_re);

            /* $test1 = "format:0_);[Red]\(0\) formula:=RC[-1]-50 formula:=RC[-1]-50   */
            /* +format:0_);[Red]\(0\) formula:=ABS(RC[-1]*10)";  */
            /* $test2 = "Formula:'Response Results'!j2"; */

            set $tagattr_regexp "/^([Ff][Oo][Rr][Mm][Aa][Tt]:|[Ff][Oo][Rr][Mm][Uu][Ll][Aa]:|";
            set $tagattr_regexp $tagattr_regexp "[Rr][Oo][Tt][Aa][Tt][Ee]:|[Tt][Yy][Pp][Ee]:|";
            set $tagattr_regexp $tagattr_regexp "[Hh][Ii][Dd][Dd][Ee][Nn]:|";
            set $tagattr_regexp $tagattr_regexp "[Mm][Ee][Rr][Gg][Ee][Aa][Cc][Rr][Oo][Ss][Ss]:)/";
            eval $tagattr_regex prxparse($tagattr_regexp);

            eval $cm_re prxparse('/[0-9]*[cC][mM]/');
            eval $in_re prxparse('/[0-9]*[iI][nN]/');
            eval $mm_re prxparse('/[0-9]*[mM][mM]/');
            eval $px_re prxparse('/[0-9]*px/');
            eval $pt_re prxparse('/[0-9]*pt/');
        end;

    define event sheet_interval;
        unset $tmp_interval;
        do /if value;
            set $tmp_interval value;
        else;
            set $tmp_interval tagset_alias;
        done;
        trigger set_sheet_interval /if $tmp_interval;
    end;

    define event set_sheet_interval;
        trigger worksheet finish /if $tmp_interval;
        set $tmp_interval lowcase($tmp_interval);

        /*-------------------------------------------------------eric-*/
        /*-- Table and bygroup are really synonymous.  The others   --*/
        /*-- do not currently work, because excel doesn't handle    --*/
        /*-- multiple tables per worksheet.  It might later so      --*/
        /*-- I'm leaving the code here.                             --*/
        /*----------------------------------------------------21Jul03-*/
        do /if $tmp_interval in ('table', 'bygroup');
        /*do /if $tmp_interval in ('table', 'page', 'proc', 'bygroup', 'none');*/
            set $sheet_interval $tmp_interval;
        else /if cmp($tmp_interval, "page");
            set $sheet_interval 'page';
        else /if cmp($tmp_interval, "proc");
            set $sheet_interval 'proc';
        else /if cmp($tmp_interval, "none");
            set $sheet_interval 'none';
            trigger worksheet finish;
        else;
            set $sheet_interval 'table';
        done;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- Procs that we shouldn't create new worksheets for.         --*/
    /*--------------------------------------------------------19Aug03-*/
    define event proc_list;
        /* Init proc list */
        set $proclist['Gchart'] '1';
        set $proclist['Gplot'] '1';
        set $proclist['Gmap'] '1';
        set $proclist['Gcontour'] '1';
        set $proclist['G3d'] '1';
        set $proclist['Gbarline'] '1';
        set $proclist['Gareabar'] '1';
        set $proclist['Gradar'] '1';
        set $proclist['Gslide'] '1';
        set $proclist['Ganno'] '1';
    end;


    define event nls_numbers;

        unset $currency;
        unset $currency_format;
        unset $decimal_separator;
        unset $thousands_separator;
        unset $test_format;

        /*-------------------------------------------------------eric-*/
        /*-- The currency symbol for the US is $,  set it           --*/
        /*-- accordingly.  It is used for detection of currency     --*/
        /*-- formats and for removing those symbols so excel will   --*/
        /*-- like them.                                             --*/
        /*----------------------------------------------------14Jun04-*/
        set $currency $options['CURRENCY_SYMBOL'] /if $options;
        set $currency "$" /if ^$currency;
        set $currency_compress $currency ",";

        /*-------------------------------------------------------eric-*/
        /*-- Currency or Euro Currency.  The format to use for currency.--*/
        /*----------------------------------------------------14Jun04-*/
        set $currency_format $options['CURRENCY_FORMAT'] /if $options;
        set $currency_format "Currency" /if ^$currency_format;
        /*set $currency_format "Euro Currency" /if ^$currency_format;*/

        set $decimal_separator $options['DECIMAL_SEPARATOR'] /if $options;
        set $decimal_separator '\.' /if ^$decimal_separator;

        set $thousands_separator $options['THOUSANDS_SEPARATOR'] /if $options;
        set $thousands_separator ',' /if ^$thousands_separator;

        /*-------------------------------------------------------eric-*/
        /*-- The format to use for checking values.  If the value   --*/
        /*-- is missing after applying this format then it is not a --*/
        /*-- number.   Default is '12.'  NLNUM12. may be needed in  --*/
        /*-- other locals.                                          --*/
        /*----------------------------------------------------14Jun04-*/
        set $test_format $options['NUMERIC_TEST_FORMAT'] /if $options;
        set $test_format '12.' /if ^$test_format;
    end;

    define event bad_fonts;
        set $bad_fonts[] 'Times';
        set $bad_fonts[] 'Times Roman';
        set $bad_fonts[] 'Trebuchet MS';
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- We need at least these styles.  If the style doesn't       --*/
    /*-- provide them we will create empty style definitions.       --*/
    /*--------------------------------------------------------14Jun04-*/
    define event needed_styles;
        set $missing_styles['data']         'True';
        set $missing_styles['dataemphasis'] 'True';
        set $missing_styles['header']       'True';
        set $missing_styles['footer']       'True';
        set $missing_styles['rowheader']    'True';
        set $missing_styles['table']        'True';
        set $missing_styles['batch']        'True';
        set $missing_styles['byline']       'True';
        set $missing_styles['bycontentfolder'] 'True';
        set $missing_styles['systemfooter'] 'True';
        set $missing_styles['systemtitle']  'True';
        set $missing_styles['systemfooter2'] 'True';
        set $missing_styles['systemtitle2']  'True';
        set $missing_styles['systemfooter3'] 'True';
        set $missing_styles['systemtitle3']  'True';
        set $missing_styles['systemfooter4'] 'True';
        set $missing_styles['systemtitle4']  'True';
        set $missing_styles['systemfooter5'] 'True';
        set $missing_styles['systemtitle5']  'True';
        set $missing_styles['systemfooter6'] 'True';
        set $missing_styles['systemtitle6']  'True';
        set $missing_styles['systemfooter7'] 'True';
        set $missing_styles['systemtitle7']  'True';
        set $missing_styles['systemfooter8'] 'True';
        set $missing_styles['systemtitle8']  'True';
        set $missing_styles['systemfooter9'] 'True';
        set $missing_styles['systemtitle9']  'True';
        set $missing_styles['systemfooter10'] 'True';
        set $missing_styles['systemtitle10']  'True';
        set $missing_styles['contentprocname']  'True';
    end;

    define event skip_multipliers;
        eval $skip_factor['Title']         1;
        eval $skip_factor['Footer']        1;
        eval $skip_factor['Table']         1;
        eval $skip_factor['Byline']        0;
        eval $skip_factor['PageBreak']     1;
    end;

    define event row_heights;
        set $row_heights['Title']         '0';
        set $row_heights['Footer']        '0';
        set $row_heights['Table_head']    '0';
        set $row_heights['Table']         '0';
        set $row_heights['Byline']        '0';
        set $row_heights['PageBreak']     '0';
        set $row_heights['Parskip']       '0';
    end;

    define event options_setup;
        /*--------------------------------------------------------------*/
        /* options should exist, but avoid bad resolution if it doesn't */
        /* This only happens in SAS 9.1.2 and earlier                   */
        /* 9.1 and 9.1.2 have a known bug.  If an array/dictionary is   */
        /* Accessed in a set, and the array is not defined, the value   */
        /* resolves to the subscript.  Not good, but avoidable.         */
        /* Normally just putting '/if $options' on the set will fix it  */
        /* but this logic becomes needlessly complex.  This is cleaner  */
        /*--------------------------------------------------------------*/
        set $options["#$bogus"] "bogus" /if ^$options;

        trigger config_debug_options_setup;
        /* trigger set_papersize; */

        do /if $options['SHEET_INTERVAL'];
            set $tmp_interval lowcase($options['SHEET_INTERVAL']);
            trigger set_sheet_interval;
            /* this is so we can detect when it is set.        */
            /* each time it's set we should close the current */
            /* worksheet if one is open                       */
            unset $options['SHEET_INTERVAL'];
        done;

        /*-------------------------------------------------------eric-*/
        /*-- String options.  Basically, variable = the actual      --*/
        /*-- option value.                                          --*/
        /*----------------------------------------------------8May 07-*/
        set $option_key 'SHEET_NAME';
        unset $sheet_name;
        trigger do_string_option;
        set $sheet_name $answer;

        set $option_key 'SHEET_LABEL';
        unset $sheet_label;
        trigger do_string_option;
        set $sheet_label $answer;

        set $option_key 'PRINT_HEADER';
        unset $print_header;
        trigger do_string_option;
        set $print_header $answer;

        set $option_key 'PRINT_FOOTER';
        unset $print_footer;
        trigger do_string_option;
        set $print_footer $answer;

        set $option_key 'ROW_REPEAT';
        unset $row_repeat;
        trigger do_string_option;
        set $row_repeat $answer;

        set $option_key 'COLUMN_REPEAT';
        unset $col_repeat;
        trigger do_string_option;
        set $col_repeat $answer;

        set $option_key 'AUTOFILTER';
        unset $autofilter;
        trigger do_string_option;
        set $autofilter $answer;

        set $option_key 'PRINT_HEADER_MARGIN';
        unset $print_header_margin;
        trigger do_string_option;
        set $print_header_margin $answer;

        set $option_key 'PRINT_FOOTER_MARGIN';
        unset $print_footer_margin;
        trigger do_string_option;
        set $print_footer_margin $answer;

        set $option_key 'BLANK_SHEET';
        unset $blank_sheet_name;
        trigger do_string_option;
        set $blank_sheet_name $answer;
        
        do /if $blank_sheet_name;
            set $tmp_name $sheet_name;
            set $sheet_name $blank_sheet_name;
            trigger blank_worksheet;
            unset $blank_sheet_name;
            set $sheet_name $tmp_name;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- make the page do landscape setup.                      --*/
        /*----------------------------------------------------14Jun04-*/
        unset $landscape;
        set $landscape "True" /if cmp($options['ORIENTATION'], 'landscape');
        do /if ^$landscape;
            set $landscape "True" /if cmp(orientation, 'landscape');
        done;



        /*-------------------------------------------------------eric-*/
        /*-- Numeric options.  Check for missing, default to the    --*/
        /*-- default value if it is..                               --*/
        /*----------------------------------------------------8May 07-*/
        set $option_key 'ZOOM';
        trigger do_numeric;
        eval $zoom $answer;

        set $option_key 'SCALE';
        trigger do_numeric;
        eval $scale $answer;

        set $option_key 'DPI';
        trigger do_numeric;
        eval $print_dpi $answer;

        set $option_key 'ROW_HEIGHT_FUDGE';
        trigger do_none_numeric;
        eval $row_height_fudge $answer;

        /*-------------------------------------------------------eric-*/
        /*-- fit to page and fitwidth and height.  width or height  --*/
        /*-- implies fit to page.                                   --*/
        /*----------------------------------------------------12May06-*/

        set $option_key 'PAGES_FITWIDTH';
        trigger do_numeric;
        set $fittopage "True" /if $options['PAGES_FITWIDTH'];
        eval $pages_fitwidth $answer;

        set $option_key 'PAGES_FITHEIGHT';
        trigger do_numeric;
        set $fittopage "True" /if $options['PAGES_FITHEIGHT'];
        eval $pages_fitheight $answer;


        /*-------------------------------------------------------eric-*/
        /*-- Yes/no on/off options...                               --*/
        /*----------------------------------------------------8May 07-*/
        set $option_key 'ASCII_DOTS';
        trigger do_yes_no;
        eval $do_ascii_dots $answer;

        set $option_key 'AUTOFIT_HEIGHT';
        trigger do_yes_no;
        eval $do_auto_fit_height $answer;

        set $option_key 'EMBEDDED_TITLES';
        set $mvar embedded_titles;
        trigger do_yes_no;
        eval $embedded_titles $answer;

        set $option_key 'EMBEDDED_FOOTNOTES';
        set $mvar embedded_footers;
        trigger do_yes_no;
        eval $embedded_footnotes $answer;

        set $option_key 'EMBED_TITLES_ONCE';
        trigger do_yes_no;
        eval $one_embedded_title_set $answer;

        set $option_key 'FITTOPAGE';
        trigger do_yes_no;
        eval $fittopage $answer;

        set $option_key 'PAGE_ORDER_ACROSS';
        trigger do_yes_no;
        eval $left_to_right $answer;

        set $option_key 'CENTER_VERTICAL';
        trigger do_yes_no;
        eval $center_vertical $answer;

        set $option_key 'CENTER_HORIZONTAL';
        trigger do_yes_no;
        eval $center_horizontal $answer;

        set $option_key 'GRIDLINES';
        trigger do_yes_no;
        eval $gridlines $answer;

        set $option_key 'BLACKANDWHITE';
        trigger do_yes_no;
        eval $blackandwhite $answer;

        set $option_key 'DRAFTQUALITY';
        trigger do_yes_no;
        eval $draftquality $answer;

        set $option_key 'ROWCOLHEADINGS';
        trigger do_yes_no;
        eval $RowColHeadings $answer;

        set $option_key 'CONTENTS';
        trigger do_yes_no;
        eval $do_contents $answer;

        set $option_key 'AUTO_SUBTOTALS';
        trigger do_yes_no;
        eval $auto_sub_totals $answer;

        set $option_key 'CONVERT_PERCENTAGES';
        set $mvar convert_percentages;
        trigger do_yes_no;
        eval $convert_percentages $answer;

        set $option_key 'FORMULAS';
        set $mvar formulas;
        trigger do_yes_no;
        eval $formulas $answer;

        set $option_key 'INDEX';
        trigger do_yes_no;
        eval $do_tabs $answer;

        set $option_key 'MINIMIZE_STYLE';
        trigger do_yes_no;
        eval $minimize_style $answer;

        set $option_key 'PAGEBREAKS';
        trigger do_yes_no;
        eval $do_pagebreaks $answer;

        set $option_key 'SUPPRESS_BYLINES';
        trigger do_yes_no;
        eval $no_bylines $answer;

        /*-------------------------------------------------------eric-*/
        /*-- these are just a pain.  Numerics that could also be    --*/
        /*-- 'none'.   the pain is that they also have macro        --*/
        /*-- variables that could set them.                         --*/
        /*----------------------------------------------------8May 07-*/

        unset $option;
        unset $optionDefault;
        set $option $options['WIDTH_FUDGE'];
        set $option width_fudge /if ^$option;
        set $optionDefault $option_defaults['WIDTH_FUDGE'];
        set $option $optionDefault /if ^$option;

        do /if cmp($option, "none");
            unset $widthFudge;
        else;
            trigger check_numeric;
            eval $widthfudge $answer;
        done;


        unset $option;
        unset $optionDefault;
        set $option $options['WIDTH_POINTS'];
        set $option width_points /if ^$option;
        set $optionDefault $option_defaults['WIDTH_POINTS'];
        set $option $optionDefault /if ^$option;

        do /if cmp($option, "none");
            unset $widthpoints;
        else;
            trigger check_numeric;
            eval $widthpoints $answer;
        done;


        unset $option;
        set $option $options['DEFAULT_COLUMN_WIDTH'];
        set $option default_column_width /if ^$option;
        set $option $option_defaults['DEFAULT_COLUMN_WIDTH'] /if ^$option;

        do /if cmp($option, 'none');
            unset $default_widths;
        else;
            set $defwid $option;
            trigger set_default_widths;
        done;


        unset $option;
        set $option $options['ABSOLUTE_COLUMN_WIDTH'];
        set $option $option_defaults['ABSOLUTE_COLUMN_WIDTH'] /if ^$option;

        do /if cmp($option, 'none');
            unset $absolute_widths;
        else;
            set $abswid $option;
            trigger set_absolute_widths;
        done;




        /*-------------------------------------------------------eric-*/
        /*-- From here down are the really painful one off type options.--*/
        /*----------------------------------------------------8May 07-*/

        set $missing_align $option_defaults['MISSING_ALIGN'];
        do /if $options['MISSING_ALIGN'];
            do /if cmp($options['MISSING_ALIGN'], "right" );
                set $missing_align "r" ;
            else /if cmp($options['MISSING_ALIGN'], "center" );
                set $missing_align "c" ;
            else /if cmp($options['MISSING_ALIGN'], "left" );
                set $missing_align "l" ;
            done;
        done;

        set $do_contents_contents 'True';
        set $do_contents_tabs 'True';
        unset $do_workbooks;
        do /if $options['CONTENTS_FILE'];
            unset $do_contents_contents;
            unset $do_contents_tabs;
            set $toc lowcase($options['CONTENTS_FILE']);
            do /if contains($toc, "all" );
                set $do_contents_contents 'True';
                set $do_contents_tabs 'True';
                set $do_workbooks 'True';
            done;
            do /if contains($toc, "contents" );
                set $do_contents_contents 'True';
            done;
            do /if contains($toc, "index" );
                set $do_contents_tabs 'True';
            done;
            do /if contains($toc, "workbooks" );
                set $do_workbooks 'True';
            done;
        done;


        do /if $options['FROZEN_HEADERS'];
            unset $tmp;
            unset $frozen_header_count;
            unset $frozen_headers;
            set $tmp  $options['FROZEN_HEADERS'];
            do /if cmp($tmp, "yes");
                set $frozen_headers "true" ;
            else /if cmp($tmp, "no");
                unset $frozen_headers;
            else;
                eval $frozen_header_count inputn($tmp, 'BEST');
                do /if ^missing($frozen_header_count);
                    set $frozen_headers "true";
                else;
                    unset $frozen_header_count;
                    unset $frozen_headers;
                done;
            done;
        else;
            do /if frozen_headers;
                unset $frozen_header_count;
                unset $frozen_headers;
            done;
            do /if cmp(frozen_headers, "yes");
                set $frozen_headers "true" ;
            else /if cmp(frozen_headers, 'no');
                unset $frozen_headers;
            else;
                eval $frozen_header_count inputn(frozen_headers, 'BEST');
                do /if ^missing($frozen_header_count);
                    set $frozen_headers "true";
                else;
                    unset $frozen_header_count;
                    unset $frozen_headers;
                done;
            done;
        done;

        do /if $options['FROZEN_ROWHEADERS'];
            unset $tmp;
            set $tmp  $options['FROZEN_ROWHEADERS'];
            do /if cmp($tmp, "yes");
                set $frozen_rowheaders "true" ;
            else /if cmp($tmp, "no");
                unset $frozen_rowheaders;
            else;
                eval $frozen_rowheader_count inputn($tmp, 'BEST');
                do /if ^missing($frozen_rowheader_count);
                    set $frozen_rowheaders "true";
                else;
                    unset $frozen_rowheader_count;
                    unset $frozen_rowheaders;
                done;
            done;
        else;
            do /if cmp(frozen_rowheaders, "yes");
                set $frozen_rowheaders "true" ;
            else /if cmp(frozen_rowheaders, 'no');
                unset $frozen_rowheaders;
            else;
                eval $frozen_rowheader_count inputn(frozen_rowheaders, 'BEST');
                do /if ^missing($frozen_rowheader_count);
                    set $frozen_rowheaders "true";
                else;
                    unset $frozen_rowheader_count;
                    unset $frozen_rowheaders;
                done;
            done;
        done;


        /*-------------------------------------------------------eric-*/
        /*-- autofilter table is 1 unless there are multiple tables --*/
        /*-- per worksheet.                                         --*/
        /*----------------------------------------------------23Dec04-*/
        eval $autofilter_table 1;
        do /if $sheet_interval ^in ('table', 'bygroup');
            do /if $options['AUTOFILTER_TABLE'];
                set $tmp $options['AUTOFILTER_TABLE'];
                eval $autofilter_table inputn($tmp, 'BEST');
            done;
            do /if missing($autofilter_table);
                eval $autofilter_table 1;
            done;
        done;

        unset $option;
        set $option $options['HIDDEN_COLUMNS'];
        set $option $option_defaults['HIDDEN_COLUMNS'] /if ^$option;

        do /if cmp($option, 'none');
            unset $hidden_columns;
        else;
            unset $hidden_columns;  /* KEEP it FROM GROWING */
            set $option tranwrd($option, ' ', '');
            do /if index($option, ',');
                set $column scan($option, 1, ',');
                eval $count 1;
                do /while !cmp($column, ' ');
                    /* it's a range */
                    do /if index($column, '-');
                        trigger column_range;
                    else;
                        set $hidden_columns[$column] "True";
                    done;
                    eval $count $count + 1;
                    set $column scan($option, $count, ',');
                done;
            else;
                /* it's a range */
                do /if index($option, '-');
                    set $column $option;
                    trigger column_range;
                else;
                    set $hidden_columns[$option] "True";
                done;
            done;
        done;


        do /if $options['SKIP_SPACE'];
            set $skip_spaces $options['SKIP_SPACE'];

            /*---------------------------------------------------eric-*/
            /*-- This is a bug.  We shouldn't even be here if       --*/
            /*-- options['skip_space'] has no value.                --*/
            /*------------------------------------------------17Aug05-*/
            /*
            stop /if ^$skip_spaces;
            */

            do /if index($skip_spaces, ',');
                set $skip_space scan($skip_spaces, 1, ',');
                eval $count 1;
                do /while !cmp($skip_space, ' ');

                    do /if $count = 1;
                        eval $skip_factor['Table'] inputn(strip($skip_space), 'BEST');
                    else /if $count = 2;
                        eval $skip_factor['Byline'] inputn(strip($skip_space), 'BEST');
                    else /if $count = 3;
                        eval $skip_factor['Title'] inputn(strip($skip_space), 'BEST');
                    else /if $count = 4;
                        eval $skip_factor['Footer'] inputn(strip($skip_space), 'BEST');
                    else /if $count = 5;
                        eval $skip_factor['PageBreak'] inputn(strip($skip_space), 'BEST');
                    done;

                    eval $count $count + 1;
                    set $skip_space scan($skip_spaces, $count, ',');
                done;

            else /if $skip_spaces;
                eval $skip_factor['Table'] inputn(strip($skip_spaces), 'BEST');
            done;

        done;

        do /if $options['ROW_HEIGHTS'];
            set $row_height_str $options['ROW_HEIGHTS'];

            do /if index($row_height_str, ',');
                set $row_height scan($row_height_str, 1, ',');
                eval $count 1;
                do /while !cmp($row_height, ' ');

                    do /if $count = 1;
                        set $row_heights['Table_head'] strip($row_height);
                    else /if $count = 2;
                        set $row_heights['Table'] strip($row_height);
                    else /if $count = 3;
                        set $row_heights['Byline'] strip($row_height);
                    else /if $count = 4;
                        set $row_heights['Title'] strip($row_height);
                    else /if $count = 5;
                        set $row_heights['Footer'] strip($row_height);
                    else /if $count = 6;
                        set $row_heights['PageBreak'] strip($row_height);
                    else /if $count = 7;
                        set $row_heights['Parskip'] strip($row_height);
                    done;

                    eval $count $count + 1;
                    set $row_height scan($row_height_str, $count, ',');
                done;

            else /if strip($row_height_str);
                eval $row_heights['Table_head'] strip($row_height_str);
            done;

            do /if $debug_level >= 1;
                putlog "ROW HEIGHTS!!!!: " htmlclass;
                iterate $row_heights;
                do /while _name_;
                    putlog _name_ ": " _value_;
                    next $row_heights;
                done;
            done;

        done;


    end;

    define event set_papersize;
        set $papersize_name getoption('PAPERSIZE');
        set $papersize '0';
        set $papersize $papersize_names[$papersize_name];
    end;

    define event set_default_widths;
        unset $default_widths;  /* KEEP it FROM GROWING */
        do /if index($defwid, ',');
            set $def_width scan($defwid, 1, ',');
            eval $count 1;
            do /while !cmp($def_width, ' ');
                set $default_widths[] strip($def_width);
                eval $count $count + 1;
                set $def_width scan($defwid, $count, ',');
            done;
        else;
            set $default_widths[] strip($defwid);
        done;
    end;

    define event set_absolute_widths;
        unset $absolute_widths;  /* KEEP it FROM GROWING */
        do /if index($abswid, ',');
            set $abs_width scan($abswid, 1, ',');
            eval $count 1;
            do /while !cmp($abs_width, ' ');
                set $absolute_widths[] strip($abs_width);
                eval $count $count + 1;
                set $abs_width scan($abswid, $count, ',');
            done;
        else;
            set $absolute_widths[] strip($abswid);
        done;
    end;
    
    define event column_range;
        eval $last_column inputn(scan($column, 2, '-'), 'BEST.');
        set $range scan($column, 1, '-');
        eval $range inputn($range, 'BEST.');
        do /while $range <= $last_column;
            set $str_range $range;  /* convert to string */
            set $hidden_columns[$str_range] "True";
            eval $range $range + 1;
        done;
    end;
    /*-----------------------------------------------------------eric-*/
    /*-- This one happens when options(...) are given on the ods markup--*/
    /*-- statement.  It only happens after the first statement though.--*/
    /*--------------------------------------------------------14Jun04-*/


    define event setup_lists;

        trigger row_heights;

        trigger skip_multipliers;

        trigger bad_fonts;

        trigger needed_styles;

        trigger set_border_styles;

        set $align getoption('center');
        set $align 'left' /if ^cmp($align, 'center');
        set $align lowcase($align);
        set $sheet_names['#$%!^&&&&'] 'junk';

        trigger proc_list;

        set $weight[] '1';
        set $weight[] '2';
        set $weight[] '3';
        set $weight[] '4';

        set $font_size["xx-small"] "8";
        set $font_size["x-small"]  "10";
        set $font_size["small"]    "12";
        set $font_size["medium"]   "14";
        set $font_size["large"]    "16";
        set $font_size["x-large"]  "18";
        set $font_size["xx-large"] "20";

        eval $numberOfWorksheets 0;
        eval $format_override_count 0;
        unset $got_global_margins;

        set $styles_with_just['#$%!^&&&&'] 'junk';
        /*------------------------------------------------------------------eric--*/
        /* if we were given an alias try to set the sheet interval with it.       */
        /* it should be none, proc, bygroup, page, or table.  The default is page */
        /*----------------------------------------------------------------4Jul 03-*/
        set $tmp_interval tagset_alias;
        trigger set_sheet_interval;

        trigger set_paper_size_index;

     end;

     define event set_paper_size_index;
         set $papersize_spelling getoption('PAPERSIZE');
         set $papersize '0';
         /*
        1        Letter          8 1/2" x 11"
        2        Letter small    8 1/2" x 11"
        3        Tabloid            11" x 17"
        4        Ledger             17" x 11"
        5        Legal           8 1/2" x 14"
        6        Statement       5 1/2" x 8 1/2"
        7        Executive       7 1/4" x 10 1/2"
        8        A3               297mm x 420mm
        9        A4               210mm x 297mm
        10       A4 small         210mm x 297mm
        11       A5               148mm x 210mm
        12       B4               250mm x 354mm
        13       B5               182mm x 257mm
        14       Folio           8 1/2" x 13"
        15       Quarto           215mm x 275mm
        16                          10" x 14"
        17                          11" x 17"
        18       Note            8 1/2" x 11"
        19       #9 Envelope     3 7/8" x 8 7/8"
        20       #10 Envelope    4 1/8" x 9 1/2"
        21        #11 Envelope             4 1/2" x 10 3/8"
        22        #12 Envelope             4 3/4" x 11"
        23        #14 Envelope                 5" x 11 1/2"
        24        C Sheet                     17" x 22"
        25        D Sheet                     22" x 34"
        26        E Sheet                     34" x 44"
        27        DL Envelope               110mm x 220mm
        28        C5 Envelope               162mm x 229mm
        29        C3 Envelope               324mm x 458mm
        30        C4 Envelope               229mm x 324mm
        31        C6 Envelope               114mm x 162mm
        32        C65 Envelope              114mm x 229mm
        33        B4 Envelope               250mm x 353mm
        34        B5 Envelope               176mm x 250mm
        35        B6 Envelope               125mm x 176mm
        36        Italy Envelope            110mm x 230mm
        37        Monarch Envelope         3 7/8" x 7 1/2"
        38        6 3/4 Envelope           3 5/8" x 6 1/2"
        39        US Standard Fanfold     14 7/8" x 11"
        40        German Std. Fanfold      8 1/2" x 12"
         41        German Legal Fanfold     8 1/2" x 13"
         */
         set $papersize_names['Letter'] '1';
         set $papersize_names['LETTER'] '1';
         set $papersizes['8 1/2" x 11"'] '1';
         set $papersize_names['Letter small'] '2';
         set $papersizes ['8 1/2" x 11"'] '2';
         set $papersize_names['Tabloid'] '3';
         set $papersize_names['Tabloid Extra'] '3';
         set $papersize_names['Tabloid Maximum'] '3';
         set $papersize_names['Tabloid Plus'] '3';
         set $papersize_names['TABLOID'] '3';
         set $papersize_names['TABLOID EXTRA'] '3';
         set $papersize_names['TABLOID MAXIMUM'] '3';
         set $papersize_names['TABLOID PLUS'] '3';
         set $papersizes['11" x 17"'] '3';
         set $papersize_names['Ledger'] '4';
         set $papersize_names['LEDGER'] '4';
         set $papersizes['17" x 11"'] '4';
         set $papersize_names['Legal'] '5';
         set $papersize_names['LEGAL'] '5';
         set $papersizes['8 1/2" x 14"'] '5';
         set $papersize_names['Statement'] '6';
         set $papersize_names['STATEMENT'] '6';
         set $papersizes['5 1/2" x 8 1/2"'] '6';
         set $papersize_names['Executive'] '7';
         set $papersize_names['EXECUTIVE'] '7';
         set $papersizes['7 1/4" x 10 1/2"'] '7';
         set $papersize_names['A3'] '8';
         set $papersize_names['ISO A3'] '8';
         set $papersizes['297mm x 420mm'] '8';
         set $papersize_names['A4'] '9';
         set $papersize_names['ISO A4'] '9';
         set $papersizes['210mm x 297mm'] '9';
         set $papersize_names['A4 small'] '10';
         set $papersizes['210mm x 297mm'] '10';
         set $papersize_names['A5'] '11';
         set $papersize_names['ISO A5'] '11';
         set $papersizes['148mm x 210mm'] '11';
         set $papersize_names['B4'] '12';
         set $papersize_names['ISO B4'] '12';
         set $papersizes['250mm x 354mm'] '12';
         set $papersize_names['B5'] '13';
         set $papersize_names['ISO B5'] '13';
         set $papersizes['182mm x 257mm'] '13';
         set $papersize_names['Folio'] '14';
         set $papersize_names['FOLIO'] '14';
         set $papersizes['8 1/2" x 13"'] '14';
         set $papersize_names['Quarto'] '15';
         set $papersize_names['QUARTO'] '15';
         set $papersizes['215mm x 275mm'] '15';
         set $papersizes['10" x 14"'] '16';
         set $papersizes['11" x 17"'] '17';
         set $papersize_names['Note'] '18';
         set $papersize_names['NOTE'] '18';
         set $papersizes['8 1/2" x 11"'] '18';
         set $papersize_names['#9 Envelope'] '19';
         set $papersizes['3 7/8" x 8 7/8"'] '19';
         set $papersize_names['#10 Envelope'] '20';
         set $papersizes['4 1/8" x 9 1/2"'] '20';
         set $papersize_names['#11 Envelope'] '21';
         set $papersizes['4 1/2" x 10 3/8"'] '21';
         set $papersize_names['#12 Envelope'] '22';
         set $papersizes['4 3/4" x 11"'] '22';
         set $papersize_names['#14 Envelope'] '23';
         set $papersizes['5" x 11 1/2"'] '23';
         set $papersize_names['C Sheet'] '24';
         set $papersizes['17" x 22"'] '24';
         set $papersize_names['D Sheet'] '25';
         set $papersizes['22" x 34"'] '25';
         set $papersize_names['E Sheet'] '26';
         set $papersizes['34" x 44"'] '26';
         set $papersize_names['DL Envelope'] '27';
         set $papersize_names['DL ENVELOPE'] '27';
         set $papersizes['110mm x 220mm'] '27';
         set $papersize_names['C5 Envelope'] '28';
         set $papersize_names['C5 ENVELOPE'] '28';
         set $papersizes['162mm x 229mm'] '28';
         set $papersize_names['C3 Envelope'] '29';
         set $papersize_names['C3 ENVELOPE'] '29';
         set $papersizes['324mm x 458mm'] '29';
         set $papersize_names['C4 Envelope'] '30';
         set $papersize_names['C4 ENVELOPE'] '30';
         set $papersizes['229mm x 324mm'] '30';
         set $papersize_names['C6 ENVELOPE'] '31';
         set $papersize_names['C6 Envelope'] '31';
         set $papersizes['114mm x 162mm'] '31';
         set $papersize_names['C65 Envelope'] '32';
         set $papersize_names['C65 ENVELOPE'] '32';
         set $papersizes['114mm x 229mm'] '32';
         set $papersize_names['B4 Envelope'] '33';
         set $papersize_names['B4 ENVELOPE'] '33';
         set $papersizes['250mm x 353mm'] '33';
         set $papersize_names['B5 Envelope'] '34';
         set $papersize_names['B5 ENVELOPE'] '34';
         set $papersizes['176mm x 250mm'] '34';
         set $papersize_names['B6 Envelope'] '35';
         set $papersize_names['B6 ENVELOPE'] '35';
         set $papersizes['125mm x 176mm'] '35';
         set $papersize_names['Italy Envelope'] '36';
         set $papersize_names['ITALY ENVELOPE'] '36';
         set $papersize_names['Envelope Italy'] '36';
         set $papersize_names['ENVELOPE ITALY'] '36';
         set $papersizes['110mm x 230mm'] '36';
         set $papersize_names['Monarch Envelope'] '37';
         set $papersize_names['MONARCH ENVELOPE'] '37';
         set $papersizes['3 7/8" x 7 1/2"'] '37';
         set $papersize_names['6 3/4 Envelope'] '38';
         set $papersize_names['6 3/4 ENVELOPE'] '38';
         set $papersizes['3 5/8" x 6 1/2"'] '38';
         set $papersize_names['US Standard Fanfold'] '39';
         set $papersize_names['US STANDARD FANFOLD'] '39';
         set $papersizes['14 7/8" x 11"'] '39';
         set $papersize_names['German Std. Fanfold'] '40';
         set $papersize_names['GERMAN STD. FANFOLD'] '40';
         set $papersizes['8 1/2" x 12"'] '40';
         set $papersize_names['GERMAN LEGAL FANFOLD'] '41';
         set $papersizes['8 1/2" x 13"'] '41';
     end;
     
     define event blank_worksheet;
         set $doing_blank 'True';
         trigger worksheet start;
         trigger worksheet finish;
         unset $doing_blank;
         /*
         put '<Worksheet ss:Name="Sheet2">' nl;
         put '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">' nl;
         put ' <Print>' nl;
         put '  <ValidPrinterInfo/>' nl;
         put '  <PaperSizeIndex>0</PaperSizeIndex>' nl;
         put '  <HorizontalResolution>-4</HorizontalResolution>' nl;
         put '  <VerticalResolution>-4</VerticalResolution>' nl;
         put ' </Print>' nl;
         put ' <ShowPageLayoutZoom/>' nl;
         put ' <PageLayoutZoom>100</PageLayoutZoom>' nl;
         put ' <Selected/>' nl;
         put ' <ProtectObjects>False</ProtectObjects>' nl;
         put ' <ProtectScenarios>False</ProtectScenarios>' nl;
         put '</WorksheetOptions>' nl;
         put '   </Worksheet>' nl;
         */
     end;

     define event break_margin;
         unset $margin_unit;
         eval $match prxmatch($margin_re, $margin);
         set $margin_size prxposn($margin_re, 1, $margin) ;
         /* regex gives back strings... We don't want 0 margins              */
         /* might as well break too, (bif) since we don't want anything else */
         unset $margin_size /breakif inputn($margin_size, "BEST") = 0;
         set $margin_unit prxposn($margin_re, 2, $margin) ;
         set $margin_unit lowcase($margin_unit) /if $margin_unit;
         set $margin_unit "in" /if !$margin_unit;
     end;

     /*----------------------------------------------------------eric-*/
     /*-- get the margin options.  They win over the style margins  --*/
     /*-- set on the body style element.  Convert them to inches    --*/
     /*-- without units.  If there is no margin option convert the  --*/
     /*-- margin we got from the style earlier on...                --*/
     /*-------------------------------------------------------22Aug05-*/
     define event get_global_Margins;
         break /if $got_global_margins;
         set $got_global_margins "True";

         eval $margin_re prxparse('(([0-9]*[\.]?[0-9]*)(IN|CM)?)') ;

         set $margin getoption('leftmargin');
         trigger break_margin;
         do /if $margin_size;
             set $marginleft $margin_size;
         else /if  $marginleft;
             /* this is the margin from the style */
             set $convert_this_size $marginleft;
             trigger convert_to_inches;
             set $marginleft $converted_this_size;
         done;

         set $margin getoption('rightmargin');
         trigger break_margin;
         do /if $margin_size;
             set $marginright $margin_size;
         else /if  $marginright;
             /* this is the margin from the style */
             set $convert_this_size $marginright;
             trigger convert_to_inches;
             set $marginright $converted_this_size;
         done;

         set $margin getoption('topmargin');
         trigger break_margin;
         do /if $margin_size;
             set $marginTop $margin_size;
         else /if  $marginTop;
             /* this is the margin from the style */
             set $convert_this_size $marginTop;
             trigger convert_to_inches;
             set $marginTop $converted_this_size;
         done;

         set $margin getoption('bottommargin');
         trigger break_margin;
         do /if $margin_size;
             set $marginBottom $margin_size;
         else /if  $marginBottom;
             /* this is the margin from the style */
             set $convert_this_size $marginBottom;
             trigger convert_to_inches;
             set $marginBottom $converted_this_size;
         done;
         unset $margin;
         unset $margin_size;
         unset $margin_unit;

     end;

     /*----------------------------------------------------------eric-*/
     /*-- I haven't figured out where to put papersize.  If we can  --*/
     /*-- find the XML for it these values could be plugged in and  --*/
     /*-- then Excel would be set up to print for the appropriate   --*/
     /*-- page size.                                                --*/
     /*-------------------------------------------------------22Aug05-*/
     define event paperHeightWidth;

         /* tranwrd just makes the regex easier. Get rid of optional quotes */
         set $papersize tranwrd($papersize, '"', " ");
         set $papersize tranwrd($papersize, "'", " ");

         /* could be centimeters, could be quoted, or not...
            default is supposedly inches but could be installation
            dependent.
            (8in 11in);
            ('8in', '11in');
            ("8in", "11in");
            ("8", "11");
         */
         eval $re prxparse('( *([0-9]+) *(IN|CM)* *[,]+ *([0-9]+) *(IN|CM)*.*)') ;
         eval $match prxmatch($re, $papersize);

         set $pwidth prxposn($re, 1, $papersize) ;
         set $pwidth_unit prxposn($re, 2, $papersize) ;
         set $pwidth_unit lowcase($pwidth_unit) /if $pwidth_unit;
         set $pwidth_unit "in" /if !$pwidth_unit;

         set $pheight prxposn($re, 3, $papersize) ;
         set $pheight_unit prxposn($re, 4, $papersize) ;
         set $pheight_unit lowcase($pheight_unit) /if $pheight_unit;
         set $pheight_unit "in" /if !$pheight_unit;

         /* Only if they are non-zero */
         set $paper_height $pheight $pheight_unit /if $pheight;
         set $paper_width $pwidth $pwidth_unit  /if $pwidth;

         unset $papersize;
         unset $re;
         unset $pwidth;
         unset $pwidth_unit;
         unset $pheight;
         unset $pheight_unit;

    end;


     define event contents;
         start:
             trigger doc;
         finish:
             trigger write_to_contents;
             trigger doc;
     end;

     define event doc;
        start:
            eval $numberOfWorksheets 0;

            put '<?xml version="1.0"';
            putq " encoding=" encoding;
            put "?>" CR CR;
            putl '<?mso-application progid="Excel.Sheet"?>';
            putl '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"';
            putl '          xmlns:x="urn:schemas-microsoft-com:office:excel"';
            putl '          xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"';
            putl '          xmlns:html="http://www.w3.org/TR/REC-html40">';
            putl '<DocumentProperties xmlns="urn:schemas-microsoft-com:office">';
            do /if operator;
                putl '<Author>' operator '</Author>';
                putl '<LastAuthor>' operator '</LastAuthor>';
            done;
            putl '<Created>' date 'T' time '</Created>';
            putl '<LastSaved>' date 'T' time '</LastSaved>';
            putl '<Company>SAS Institute Inc. http://www.sas.com</Company>';
            putl '<Version>' saslongversion '</Version>';
            putl '</DocumentProperties>';
        finish:
            putl '</Workbook>';
    end;

    define event embedded_stylesheet;
        start:
            unset $currency_styles;
            unset $percentage_styles;
            unset $style_list;
            unset $style_overrides;
            eval $format_override_count 0;
            unset $have_parskip_style ;
            open style /if cmp(dest_file, 'body');
            trigger alignstyle;
        finish:
            open style /if cmp(dest_file, 'body');
            trigger Need_parskip_style /if ^$have_parskip_style;
            trigger Need_pagebreak_style /if ^$have_pagebreak_style;
            trigger Need_datamissing_style;
            trigger Need_byline_style /if ^$have_byline_style;
            trigger Need_title_style /if ^$have_title_style;
            trigger Need_footer_style /if ^$have_footer_style;
            close;
            put "</Styles>" nl /if cmp(dest_file, 'contents');
    end;


    define event create_cell_borders;
        unset $borderwidth;
        do /if cellspacing;
            set $borderwidth cellspacing;
            set $bordercolor background;
        else /if cmp(rules, "all");
            set $borderwidth borderwidth;
            set $bordercolor bordercolor;
        done;
        /*put "Create" ": " $borderwidth " : " $bordercolor nl;*/
        eval $borderwidth inputn($borderwidth, 'BEST');
        do /if $borderwidth;
            set $convert_this_size $borderwidth;
            trigger convert_to_scale;
            do /if $converted_this_size > 3;
                eval $borderwidth 3;
            else;
                eval $borderwidth $converted_this_size;
            done;
            unset $borderstyle;
            trigger get_borderstyle;

            set $border_position "Left";
            trigger write_borderstyle;
            set $border_position "Right";
            trigger write_borderstyle;
            set $border_position "Top";
            trigger write_borderstyle;
            set $border_position "Bottom";
            trigger write_borderstyle;
            put '</ss:Borders>' nl /if $borders;
            unset $borders;
        done;
    end;

    define event Need_byline_style;
        do /if cmp($row_heights['Byline'], '0');
            set $row_heights['Byline'] '16';
        done;
    end;
    define event Need_title_style;
        do /if cmp($row_heights['Title'], '0');
            set $row_heights['Title'] '16';
        done;
    end;

    define event Need_footer_style;
        do /if cmp($row_heights['Footer'], '0');
            set $row_heights['Footer'] '16';
        done;
    end;

    define event Need_datamissing_style;
        do /if ^$datamissing_style_name;
            set $datamissing_style_name "datamissing";
            putq '<Style ss:ID="datamissing_l" ss:Parent="data">' NL;
            put '<Alignment ';
            put ' ss:Horizontal="Left"';
            put '/>' nl;
            put '</Style>' nl;

            putq '<Style ss:ID="datamissing_c" ss:Parent="data">' NL;
            put '<Alignment ';
            put ' ss:Horizontal="Center"';
            put '/>' nl;
            put '</Style>' nl;

            putq '<Style ss:ID="datamissing_r" ss:Parent="data">' NL;
            put '<Alignment ';
            put ' ss:Horizontal="Right"';
            put '/>' nl;
            put '</Style>' nl;
        else;
            put $$datamissing_style;
            unset $$datamissing_style;
        done;

    end;

    define event Need_parskip_style;
        set $parskip_style_name 'parskip';
        put  '<Style ss:ID="parskip"';
        putq ' ss:Parent=' $body_class;
        put '>' NL;
        putl '<Alignment/>';
        putl '<ss:Borders>';
        putl '<ss:Border ss:Position="Left" />';
        putl '<ss:Border ss:Position="Top" />';
        putl '<ss:Border ss:Position="Right" />';
        putl '<ss:Border ss:Position="Bottom" />';
        putl '</ss:Borders>';
        putl '<Protection ss:Protected="1" />';
        putl '</Style>';
    end;

    define event Need_pagebreak_style;
        do /if cmp($row_heights['PageBreak'], '0');
            set $row_heights['PageBreak'] '8';
        done;
        put '<Style ss:ID="pagebreak"';
        putq ' ss:Parent=' $body_class;
        put '>' NL;
        putl '<Alignment/>';
        putl '<ss:Borders>';
        putl '<ss:Border ss:Position="Left" />';
        putl '<ss:Border ss:Position="Top" />';
        putl '<ss:Border ss:Position="Right" />';
        putl '<ss:Border ss:Position="Bottom" />';
        putl '</ss:Borders>';
        putl '<Protection ss:Protected="1" />';
        putl '</Style>';
    end;

    define event doc_body;
        start:
            /*---------------------------------------------------eric-*/
            /*-- Get the margins,  Just in case the body style      --*/
            /*-- element wasn't defined.                            --*/
            /*------------------------------------------------22Aug05-*/
            trigger get_global_margins;
            open worksheet;
        finish:
            /* close the worksheet if it's open.  We're shutting down */
            trigger worksheet;

            close;


            /*---------------------------------------------------eric-*/
            /*-- Write the end of the styles section.  We have to   --*/
            /*-- wait until now in case there were style overrides --*/
            /*-- written during worksheet creation.                 --*/
            /*------------------------------------------------4Jul 03-*/
            open style;
            putl '</Styles>' nl;
            close;

            /* write out the style definitions and delete the stream */
            do /if $$style;
                put "<Styles>" nl;
                put $$tablestyle;
                put $$style;
                delstream tablestyle;
                delstream style;
            done;

            /* write out the table of contents and delete the stream */
            do /if $do_contents;
                trigger contents_worksheet start;
                put $$contents_worksheet;
                trigger contents_worksheet finish;
            done;

            do /if $do_tabs;
                trigger tabs_worksheet start;
                put $$tabs_worksheet;
                trigger tabs_worksheet finish;
            done;

            /*
            do /if contents_name;
                open cont_contents_worksheet;
                put $$contents_worksheet nl;
                open cont_tabs_worksheet;
                put $$tabs_worksheet nl;
                close;
            done;
            */

            delstream contents_worksheet;
            delstream tabs_worksheet;

            /* write out the worksheets and delete the stream */
            put $$master_worksheet;
            delstream master_worksheet;
        end;

        define event write_to_contents;
            do /if $do_workbooks;
                trigger workbooks_worksheet start;
                put $$workbooks_worksheet nl;
                trigger workbooks_worksheet finish;
            done;

            do /if $do_contents_contents;
                trigger contents_worksheet start;
                put $$cont_contents_worksheet nl;
                trigger contents_worksheet finish;
            done;

            do /if $do_contents_tabs;
                trigger tabs_worksheet start;
                put $$cont_tabs_worksheet nl;
                trigger tabs_worksheet finish;
            done;

            delstream workbooks_worksheet;
            delstream cont_contents_worksheet;
            delstream cont_tabs_worksheet;
        end;

    define event workbooks_worksheet;
        start:
            putq '<Worksheet ss:Name="WorkBooks">' NL;
            put  '<Table';
            putq ' ss:StyleID=' $pages_class;
            putl '>' nl;
            putl '<ss:Column ss:AutoFitWidth="1" ss:Width="35"/>' nl;
            putl '<ss:Column ss:AutoFitWidth="1" ss:Width="250"/>' nl;
        finish:
            put  '</Table>' nl;
            put "</Worksheet>" nl;
    end;

    define event contents_worksheet;
        start:
            putq '<Worksheet ss:Name="Contents">' NL;
            put  '<Table';
            putq ' ss:StyleID=' $contents_class;
            putl '>' nl;
        finish:
            put  '</Table>' nl;
            put "</Worksheet>" nl;
    end;

    define event tabs_worksheet;
        start:
            do /if ^$do_contents;
                putq '<Worksheet ss:Name="Contents">' NL;
            else;
                putq '<Worksheet ss:Name="Worksheets">' NL;
            done;
            put  '<Table';
            putq ' ss:StyleID=' $table_class;
            putl '>' nl;
            putl '<ss:Column ss:AutoFitWidth="1" ss:Width="35"/>' nl;
            putl '<ss:Column ss:AutoFitWidth="1" ss:Width="250"/>' nl;
        finish:
            put  '</Table>' nl;
            put "</Worksheet>" nl;
    end;

    define event write_tabs_entry;
        break /if ^$do_tabs;


        unset $url;

        set $url path_url /if path_url;

        do /if body_url;
            set $url $url body_url;
        else;
            set $url $url body_name;
        done;

        do /if index($worksheetName, ' ');
            set $url $content_url[$entry_count] "#'" $worksheetName "'!A" $content_row;
        else;
            set $url $content_url[$entry_count] "#" $worksheetName "!A" $content_row;
        done;

        open tabs_worksheet;
        trigger write_tab_entry;
        close;

        open cont_tabs_worksheet;
        trigger write_tab_entry;
        close;
    end;

    define event write_tab_entry;
        put  '<Row';
        putq ' ss:Height=' $height;
        /* put  ' ss:StyleID="table">' nl; */
        put '>' nl;

        putq '<Cell' ' ss:StyleID="contentitem">';
        put '<Data ss:Type="String"></Data></Cell>' nl;

        put  '<Cell';
        put  ' ss:StyleID="contentitem"' ;

        putq ' ss:HRef=' $url;

        put '>';
        put '<Data ss:Type="String">';
        put $worksheetName;
        put '</Data></Cell>';

        put  '</Row>' nl;
    end;

    define event write_wb_entry;
        break /if ^$do_workbooks;

        unset $url;

        set $url path_url /if path_url;

        do /if body_url;
            set $url $url body_url;
        else;
            set $url $url body_name;
        done;

        break /if cmp($last_file, $url);
        set $last_file $url;

        open workbooks_worksheet;

        put  '<Row';
        putq ' ss:Height=' $height;
        /* put  ' ss:StyleID="table">' nl; */

        put '>' nl;

        putq '<Cell' ' ss:StyleID="contentitem">';
        put '<Data ss:Type="String"></Data></Cell>' nl;

        put  '<Cell';
        put  ' ss:StyleID="contentitem"' ;

        putq ' ss:HRef=' $url;

        put '>';
        put '<Data ss:Type="String">';
        put $worksheetName;
        put '</Data></Cell>';

        put  '</Row>' nl;

        close;
    end;

    define event contents_entry;
        break /if ^$do_contents;
        set $content_values[] value;
        set $content_class[] lowcase(htmlclass);
        set $content_level[] toc_level;
        unset $url;
        set $url path_url /if path_url;
        do /if body_url;
            set $content_url[] $url body_url;
        else;
            set $content_url[] $url body_name;
        done;

    end;

   define event write_contents_entries;
        break /if ^$do_contents;
        break /if ^$content_values;
        open contents_worksheet;
        eval $entry_count 1;
        do /while $entry_count <= $content_values;
            trigger write_contents_entry;
            eval $entry_count $entry_count + 1;
        done;
        close;
        do /if contents_name;
            open cont_contents_worksheet;
            eval $entry_count 1;
            do /while $entry_count <= $content_values;
                trigger write_contents_entry;
                eval $entry_count $entry_count + 1;
            done;
            close;
        done;
        unset $content_values;
        unset $content_class;
        unset $content_level;
        unset $content_url;
    end;

    define event write_contents_entry;

        /*set $name tranwrd($worksheetName, ' ', '%20');*/
        
        /* If the sheet name has spaces it has to be quoted */
        do /if index($worksheetName, ' ');
            set $url $content_url[$entry_count] "#'" $worksheetName "'!A" $content_row;
        else;
            set $url $content_url[$entry_count] "#" $worksheetName "!A" $content_row;
        done;

        set $toclevel $content_level[$entry_count];
        eval $toclevel inputn($toclevel, 'BEST');

        put  '<Row';
        putq ' ss:Height=' $height;
        /* put  ' ss:StyleID="table">' nl;*/
        put '>' nl;

        eval $count 0;
        do /while $toclevel > $count;
            eval $count $count+1;
            putq '<Cell' ' ss:StyleID=' $content_class[$entry_count] '>';
            put '<Data ss:Type="String"></Data></Cell>' nl;
        done;

        put  '<Cell';
        putq  ' ss:StyleID=' $content_class[$entry_count];

        putq ' ss:HRef=' $url;

        put '>';
        put '<Data ss:Type="String">';
        put $content_values[$entry_count];
        put '</Data></Cell>';

        put  '</Row>' nl;
    end;

    define event branch;
        trigger contents_entry;
    end;

    define event proc_branch;
        start:
            unset $proc_label;
            set $proc_label value;
            trigger contents_entry;
        finish:
            unset $proc_label;
    end;


    define event leaf;
        trigger contents_entry;
    end;

    define event shortstyles;
        flush;
        open style /if cmp(dest_file, 'body');
        iterate $missing_styles;
        do /while _name_;
            set $cell_class _name_;
            do /if cmp($cell_class, "table");    /* table   */
                open tablestyle;    /* table   */
                trigger sub_body;
            done;
            trigger empty_style;
            do /if cmp($cell_class, "table");    /* table   */
                close;
                open style /if cmp(dest_file, 'body');
            done;
            next $missing_styles;
        done;
        close;
        unset $cell_class;
    end;

    define event empty_style;
            unset $doit;
            set $doit "true" /if contains($cell_class, "ata");    /* Data   */
            set $doit "true" /if contains($cell_class, "eader");  /* Header */
            do /if $doit;
                putq '<Style ss:ID=' $cell_class;
                putq ' ss:Parent=' $table_class;
                put '/>' NL;
                
                trigger create_just_cell_styles;

            else /if contains($cell_class, 'system') |
                    contains($cell_class, 'ote') |
                    cmp($cell_class, 'byline') |
                    contains($cell_class, 'able') ;
                put '<Style ss:ID="' $cell_class '"';
                putq ' ss:Parent=' $body_class;
                put '/>' nl;

            else;
                put '<Style ss:ID="' $cell_class '"/>' NL;
            done;
        end;

        define event create_just_cell_styles;
            set $just 'l';
            trigger just_cell_style;
            set $just 'r';
            trigger just_cell_style;
            set $just 'c';
            trigger just_cell_style;
            unset $just;
        end;

        define event just_cell_style;
            put '<Style ss:ID="' $cell_class '__' $just '"';
            putq ' ss:Parent=' $cell_class;
            put '>';
            trigger align_tag start;
            put ' ss:Horizontal=';
            put '"Center"' /if cmp($just, 'c');
            put '"Left"' /if cmp($just, 'l');
            put '"Right"' /if cmp($just, 'r');
            put '"Right"' /if cmp($just, 'd');
            putq ' ss:Rotate=' strip($attrs['rotate']) /if $attrs;
            trigger align_tag finish;
            put '</Style>' NL;
        end;

    define event show_borders;
            putvars style _name_ " : " _value_ nl;
            put "border" ": "  borderwidth " : " borderstyle " : " bordercolor nl;
            put "borderleft" ": "  borderleftwidth " : " borderleftstyle " : " borderleftcolor nl;
            put "borderright" ": "  borderrightwidth " : " borderrightstyle " : " borderrightcolor nl;
            put "bordertop" ": "  bordertopwidth " : " bordertopstyle " : " bordertopcolor nl;
            put "borderbottom" ": "  borderbottomwidth " : " borderbottomstyle " : " borderbottomcolor nl;
        end;

        define event sub_body;
            break /if $sub_body;
            set $sub_body "True";
            set $body_class "_body";
            put '<Style ss:ID="_body">' nl;
            put ' <Interior ss:Pattern="Solid" />' nl;
            put ' <Protection ss:Protected="1" />' nl;
            put '</Style>' nl;

            set $contents_class "_contents";
            put '<Style ss:ID="_contents">' nl;
            put ' <Interior ss:Pattern="Solid" />' nl;
            put ' <Protection ss:Protected="1" />' nl;
            put '</Style>' nl;

            set $pages_class "_pages";
            put '<Style ss:ID="_pages">' nl;
            put ' <Interior ss:Pattern="Solid" />' nl;
            put ' <Protection ss:Protected="1" />' nl;
            put '</Style>' nl;
        end;

    define event style_class;
        /*-------------------------------------------------------eric-*/
        /*-- trim down the number of styles we define...            --*/
        /*-- 3Jul 03                                                --*/
        /*-- If you see an error about styleID value not            --*/
        /*-- being right, add the name in question here.            --*/
        /*-- Or set the minimize_style option to no.                --*/
        /*----------------------------------------------------21Dec04-*/
        set $htmlclass lowcase(htmlclass);


        set $styles_with_just[$htmlclass] "True" /if just;

        do /if $minimize_style;
            unset $doit;
            set $doit "true" /if contains($htmlclass, "SystemTitle");
            set $doit "true" /if contains($htmlclass, "SystemFooter");
            set $doit "true" /if cmp($htmlclass, "NoteContent");
            set $doit "true" /if cmp($htmlclass, "byline");
            set $doit "true" /if cmp($htmlclass, "parskip");
            set $doit "true" /if cmp($htmlclass, "pagebreak");
            set $doit "true" /if cmp($htmlclass, "body");
            set $doit "true" /if contains($htmlclass, "able");   /* Table  */
            set $doit "true" /if contains($htmlclass, "atch");   /* Batch  */
            set $doit "true" /if contains($htmlclass, "ata");    /* Data   */
            set $doit "true" /if contains($htmlclass, "eader");  /* Header */
            set $doit "true" /if contains($htmlclass, "ooter");  /* Footer */
            break /if ^$doit;
        done;
        
        /*set $cell_class $htmlclass;
        trigger empty_style;
        */

        unset $missing_styles[$htmlclass];


        /*-------------------------------------------------------eric-*/
        /*-- save away the parskip height and the pagebreak height  --*/
        /*----------------------------------------------------17Aug05-*/
        do /if cmp(htmlclass, "parskip");
            break /if ^any(cellheight, font_size);
            set $parskip_style_name lowcase(htmlclass);
            unset $parskip_height;
            set $parskip_height cellheight;
            set $parskip_height $font_size[font_size] /if ^cellheight;
            unset $size;

            break /if ^$parskip_height;
            set $have_parskip_style "True";

            do /if cmp($row_heights['Parskip'], '0');
                set $convert_this_size $parskip_height;
                trigger convert_to_points;
                set $row_heights['Parskip'] $converted_this_size;
            done;
        done;

        do /if cmp(htmlclass, "pagebreak");
            unset $pagebreak_height;
            set $pagebreak_height cellheight;
            set $pagebreak_height font_size /if ^cellheight;

            break /if ^$pagebreak_height;
            set $have_pagebreak_style "True";

            do /if cmp($row_heights['Parskip'], '0');
                set $convert_this_size $pagebreak_height;
                trigger convert_to_points;
                set $row_heights['PageBreak'] $converted_this_size;
            done;
        done;

        do /if cmp(htmlclass, "datamissing");
            set $datamissing_style_name htmlclass;
        done;

        do /if cmp(htmlclass, "table");
            set $table_style 'True';
            set $table_class lowcase(HTMLCLASS);
        done;
        /*-------------------------------------------------------eric-*/
        /*-- get the margins from the doc_body style.  They'll      --*/
        /*-- get used if the global options for margins are not set.--*/
        /*----------------------------------------------------22Aug05-*/
        do /if cmp(htmlclass, "body");
            /* 9.2 only */
            /*
            set $marginleft MARGINLEFT;
            set $marginright MARGINRIGHT;
            set $margintop MARGINTOP;
            set $marginbottom MARGINBOTTOM;
            */
            set $marginleft LEFTMARGIN;
            set $marginright RIGHTMARGIN;
            set $margintop TOPMARGIN;
            set $marginbottom BOTTOMMARGIN;
            unset $got_global_margins;
            trigger get_global_margins;
            set $body_style 'True';
            set $body_class lowcase(htmlclass);
        done;

        do /if cmp(htmlclass, "contents");
            set $contents_class lowcase(htmlclass);
        done;

        do /if cmp(htmlclass, "pages");
            set $pages_class lowcase(htmlclass);
        done;

        set $htmlclass lowcase(htmlclass);
        do /if cmp(dest_file, 'body');
            do /if cmp(htmlclass, "table");
                open tablestyle;
                trigger sub_body;
            else;
                open style /if cmp(dest_file, 'body');
        done;
        putq '<Style ss:ID=' $htmlclass ;
        unset $doit;
        set $doit "true" /if contains($htmlclass, "itle");
        set $doit "true" /if contains($htmlclass, "ooter");
        set $doit "true" /if cmp($htmlclass, "NoteContent");
        set $doit "true" /if cmp($htmlclass, "yline");
        set $doit "true" /if cmp($htmlclass, "parskip");
        set $doit "true" /if cmp($htmlclass, "pagebreak");
        do /if $doit;
            putq " ss:Parent=" $body_class;
        else;
            unset $doit;
            set $doit "true" /if contains($htmlclass, "eader");  /* Header */
            set $doit "true" /if contains($htmlclass, "data");  /* data */
            do /if $doit;
                putq ' ss:Parent="table"' ;
            done;
        done;
        put '>' NL;
        trigger tagattr_settings;
        set $format_override $attrs['format'];
        set $just just;
        set $vjust vjust;
        trigger xl_style_elements;
        do /if cmp(dest_file, 'body');
            do /if cmp(htmlclass, "table");
                open tablestyle;
                trigger sub_body;
            else;
                open style /if cmp(dest_file, 'body');
        done;
        put $$style_elements;
        unset $$style_elements;
        /* trigger cell_format; *//* seemingly good idea. Not */
        putl '</Style>';

        /*-------------------------------------------------------eric-*/
        /*-- Create a style for missing values that has right justification.--*/
        /*----------------------------------------------------23Aug05-*/
        do /if cmp(htmlclass, 'data') | cmp(htmlclass, 'dataMissing');
            do /if cmp(htmlclass, 'dataMissing');
                unset $$datamissing_style;
                set $datamissing_style_name lowcase(htmlclass);
            else;
                set $datamissing_style_name 'datamissing';
                break /if $$datamissing_style;
            done;
            open datamissing_style;
            putq '<Style ss:ID="datamissing_l" ss:Parent="data">' NL;
            /*trigger tagattr_settings; */ /* seemingly good idea. Not */
            set $format_override $attrs['format'];
            set $just 'l';
            close;
            trigger xl_style_elements;
            open datamissing_style;
            put $$style_elements;
            unset $$style_elements;
            /* trigger cell_format; *//* seemingly good idea. Not */
            putl '</Style>';

            putq '<Style ss:ID="datamissing_c" ss:Parent="data">' NL;
            /*trigger tagattr_settings; */ /* seemingly good idea. Not */
            set $format_override $attrs['format'];
            set $just 'c';
            close;
            trigger xl_style_elements;
            open datamissing_style;
            put $$style_elements;
            unset $$style_elements;
            /* trigger cell_format; *//* seemingly good idea. Not */
            putl '</Style>';

            putq '<Style ss:ID="datamissing_r" ss:Parent="data">' NL;
            /*trigger tagattr_settings; */ /* seemingly good idea. Not */
            set $format_override $attrs['format'];
            set $just 'r';
            close;
            trigger xl_style_elements;
            open datamissing_style;
            put $$style_elements;
            unset $$style_elements;
            /* trigger cell_format; *//* seemingly good idea. Not */
            putl '</Style>';
            close;
            open style /if cmp(dest_file, 'body');
        done;

        do /if contains($htmlclass, "ata") |
                contains($htmlclass, "eader") |
                contains($htmlclass, 'system') |
                contains($htmlclass, 'ote') |
                cmp($htmlclass, 'byline') |
                cmp($htmlclass, 'caption') |
                cmp($htmlclass, 'table');
            set $cell_class $htmlclass;

            trigger create_just_cell_styles;

        done;
    end;

    define event align_tag;
        start:
            break /if $align_tag;
            put '<Alignment';
            put ' ss:WrapText="1"';
            set $align_tag "True";
        finish:
            break /if ^$align_tag;
            putl '/>';
            unset $align_tag;
    end;

    define event xl_style_elements;
        delstream style_elements;
        open style_elements;


        /*-------------------------------------------------------eric-*/
        /*-- This was causing headers with over rides to get a      --*/
        /*-- blank alignment tag.  That defeats the alignment in    --*/
        /*-- the parent class.  I don't know why this was here, so  --*/
        /*-- it may break something to take it out.  But I can't    --*/
        /*-- imagine what.                                          --*/
        /*----------------------------------------------------22May07-*/
        /*
        set $headerString lowcase(htmlclass);
        do /if index ($headerString, 'header');
            trigger align_tag;
            unset $headerString;
        done;
        */

        unset $rotate;
        set $rotate strip($attrs['rotate']) /if $attrs;
        do /if $rotate;
            trigger align_tag start;
            putq ' ss:Rotate=' $rotate;
        done;


        do /if $vjust;
            unset $vertical;
            set $vertical 'Center' /if cmp($vjust, 'm');
            set $vertical 'Top' /if cmp($vjust, 't');
            set $vertical 'Bottom' /if cmp($vjust, 'b');
            trigger align_tag start /if $vertical;
            putq ' ss:Vertical=' $vertical;
        done;
        unset $vjust;


        do /if $just;
            trigger align_tag start;
            set $horizontal 'Center' /if cmp($just, 'c');
            set $horizontal 'Left' /if cmp($just, 'l');
            set $horizontal 'Right' /if cmp($just, 'r');
            set $horizontal 'Right' /if cmp($just, 'd');
            trigger align_tag start /if $horizontal;
            putq ' ss:Horizontal=' $horizontal;
        done;

            /*
        else /if contains(htmlclass, "SystemTitle") or
               contains(htmlclass, "SystemFooter") or
               cmp(htmlclass, "Byline");
            do /if ^$just;
                do /if cmp($align, "center");
                    trigger align_tag start;
                    put ' ss:Horizontal="Center"';
                done;
            done;
        done;
        */
        unset $just;

        do /if indent;
            eval $indent strip(tranwrd(indent, 'px', ''));
            trigger align_tag start /if $indent;
            putq ' ss:Indent=' $indent;
        done;

        trigger align_tag finish;

        trigger write_all_borders /if ^cmp(htmlclass, 'batch');

        trigger font_interior;

        put '<Protection';
        put  ' ss:Protected="1"';
        put  ' />' NL;

        flush;
        close;
    end;


    define event write_all_borders;

        /*
        putlog htmlclass "WIDTHS: " borderwidth ":" borderleftwidth "::" borderrightwidth ":::" bordertopwidth "::::" borderbottomwidth;
        */
        unset $doit;
        set $htmlclass lowcase(htmlclass);

        unset $foo;
        eval $foo inputn(borderwidth, 'BEST') +
                  inputn(borderleftwidth, 'BEST') +
                  inputn(borderrightwidth, 'BEST') +
                  inputn(bordertopwidth, 'BEST') +
                  inputn(borderbottomwidth, 'BEST');

        eval $cellspacing inputn(cellspacing, 'BEST');
        /* do /if cmp($htmlclass, table) & (^$foo | missing($foo));*/
        /*
        trigger show_borders /if cmp($htmlclass, "table");
        */
        do /if cmp($htmlclass, "table") & $cellspacing;
            trigger create_cell_borders;
            break;
        done;

        unset $borderwidth;
        set $borderwidth trimn(borderleftwidth);
        trigger get_borderwidth;
        /*putlog "Resolved widths";
        putlog "left: " $borderwidth;*/
        unset $borderstyle;
        trigger get_borderstyle;
        set $border_position "Left";
        set $bordercolor borderleftcolor;
        trigger write_borderstyle;

        unset $borderwidth;
        set $borderwidth trimn(borderrightwidth);
        trigger get_borderwidth;
        /*putlog "right: " $borderwidth;*/
        unset $borderstyle;
        trigger get_borderstyle;
        set $border_position "Right";
        set $bordercolor borderrightcolor;
        trigger write_borderstyle;

        unset $borderwidth;
        set $borderwidth trimn(bordertopwidth);
        trigger get_borderwidth;
        /*putlog "top: " $borderwidth;*/
        unset $borderstyle;
        trigger get_borderstyle;
        set $border_position "Top";
        set $bordercolor bordertopcolor;
        trigger write_borderstyle;

        unset $borderwidth;
        set $borderwidth trimn(borderbottomwidth);
        trigger get_borderwidth;
        /*putlog "bottom: " $borderwidth;*/
        unset $borderstyle;
        trigger get_borderstyle;
        set $border_position "Bottom";
        set $bordercolor borderbottomcolor;
        trigger write_borderstyle;


        /*
        put  '<ss:Border ss:Position="Top"';
        do /if bordertopcolor;
            putq ' ss:Color=' BORDERTOPCOLOR;
        else;
            putq ' ss:Color=' BORDERCOLOR;
        done;
        do /if borderwidth;
            putq ' ss:Weight=' $weight[$BORDERWIDTH];
            put  ' ss:LineStyle="Continuous"';
        done;
        putl ' />';
        */


        putl '</ss:Borders>' /if $borders;
        unset $borders;
    end;


    define event get_borderwidth;
/*        putlog "GET_BORDERWIDTH:";
        putlog "borderwidth: " "|" borderwidth "|";
        putlog "$borderwidth: " "|" $borderwidth "|";
        */

        set $borderwidth trimn(borderwidth) /if ^$borderwidth;

        /*
        putlog "borderwidth: " ":" borderwidth ":";
        putlog "$borderwidth: " ":" $borderwidth ":";
        */

        do /if ^$borderwidth;
            eval $borderwidth 0;
        else;
            set $convert_this_size $borderwidth;
            trigger convert_to_scale;
            do /if $converted_this_size > 3;
                eval $borderwidth 3;
            else;
                eval $borderwidth $converted_this_size;
            done;
        done;
    end;

    define event get_borderstyle;
        set $borderstyle borderstyle /if ^$borderstyle;

        set $borderstyle upcase($borderstyle);

        set $borderstyle $borderstyles[$borderstyle];

        do /if ^$borderstyle;
            set $borderstyle "Continuous" /if $borderwidth;
        done;
    end;

    define event set_border_styles;
        set $borderstyles ["DOTTED"] "Dot";
        set $borderstyles ["DASHED"] "Dash";
        set $borderstyles ["SOLID"]  "Continuous";
        set $borderstyles ["DOUBLE"] "Double";
        set $borderstyles ["GROOVE"] "DashDot";
        set $borderstyles ["RIDGE"]  "DashDotDot";
        set $borderstyles ["INSET"]  "SlashDashDot";
        set $borderstyles ["OUTSET"] "Continuous";
        set $borderstyles ["HIDDEN"] "None";
    end;

    define event write_borderstyle;
        do /if $debug_level = 8;
            putlog "WRITE_BORDERSTYLE";
            putlog "width" ": " $borderwidth;
            putlog "borders" ": " $borders;
            putlog "color" ": " $bordercolor;
            putlog "style" ": " $borderstyle;
            putlog "position" ": " $border_position;
            putlog " ";
        done;
        break /if $borderwidth < 1;

        do /if ^$borders;
            putl '<ss:Borders>';
            set $borders "TRUE";
        done;

        put  '<ss:Border ss:Position="' $border_position '"';
        set $bordercolor bordercolor /if ^$bordercolor;
        putq ' ss:Color=' $BORDERCOLOR;

        do /if $borderwidth;
            /* translate px to number +1 */
            putq ' ss:Weight=' $weight[$BORDERWIDTH];
            putq ' ss:LineStyle=' $borderstyle;
        done;
        putl ' />';
    end;

    define event cell_format;
        /*------------------------------------------------------------eric-*/
        /*-- General is the default and it's the best we can do for now. --*/
        /*---------------------------------------------------------4Jul 03-*/
        put '<NumberFormat';
        putq ' ss:Format=' $format_override;
        putq ' ss:Format=' $format /if ^$format_override;
        put  ' />' NL;
    end;

    define event set_textdecorations;
        set $textdecorations['Single']           ' ss:Underline="Single"';
        set $textdecorations['Double']           ' ss:Underline="Double"';
        set $textdecorations['SingleAccounting'] ' ss:Underline="SingleAccounting"';
        set $textdecorations['DoubleAccounting'] ' ss:Underline="DoubleAccounting"';
        set $textdecorations['Shadow']           ' ss:Shadow="1"';
        set $textdecorations['Outline']          ' ss:Outline="1"';
        set $textdecorations['StrikeThrough']    ' ss:StrikeThrough="1"';
        set $textdecorations['Subscript']        ' ss:VerticalAlign="Subscript"';
        set $textdecorations['Superscript']      ' ss:VerticalAlign="Superscript"';
        trigger set_decoration_lookup;
    end;

    define event set_decoration_lookup;
        set $textdecoration['underline']     $textdecorations["Single"];
        set $textdecoration['strikethrough'] $textdecorations["StrikeThrough"];
        set $textdecoration['overline']      $textdecorations["Double"];
        set $textdecoration['blink']         $textdecorations["Shadow"]
                                             $textdecorations["Outline"];
    end;


    define event font_interior;

        do /if any(font_face, font_size, font_weight, foreground);
            put '<Font';
            do /if font_face;
                set $fontFace font_face;
                /*putlog "FONTFACE" ":" $fontface "<!!!!!!!!!!!!!!!!!!!!!!!!";*/
                /*---------------------------------------------------eric-*/
                /*-- for some reason excel doesn't like this font       --*/
                /*-- specification. getting rid of sans-serif makes     --*/
                /*-- it happy.                                          --*/
                /*--                                                    --*/
                /*-- Courier New, Courier, sans-serif                   --*/
                /*------------------------------------------------28Jul03-*/
                do /if contains(font_face, "Courier");
                    set $fontFace tranwrd($fontFace, 'sans-serif, ', '');
                    set $fontFace tranwrd($fontFace, ', sans-serif', '');
                    set $fontFace tranwrd($fontFace, 'sans-serif', '');
                done;
                /* Excel does not like "SAS Monospace" */
                set $fontFace tranwrd($fontFace, 'SAS Monospace, ', '');
                set $fontFace tranwrd($fontFace, 'SAS Monospace', '');

                /* get rid of quotes and replace ' ,' with ',' */
                set $fontFace tranwrd($fontFace, "'", '');
                set $fontFace tranwrd($fontFace, " ,", ',');

                /*putlog "FONTFACE" ":" $fontface "<~~~~~~~~~~~~~~~~~~~~~~~~";*/
                set $fontFace strip($fontFace);
                /*putlog "FONTFACE" ":" $fontface "<~~~~~~~~~~~~~~~~~~~~~~~~";*/

                /*-----------------------------------------------eric-*/
                /*-- Get rid of fonts that excel and windows don't  --*/
                /*-- like.  See the bad_fonts event...              --*/
                /*--------------------------------------------9Jun 04-*/
                set $fontname scan($fontFace, 1, ',');
                set $fontname strip($fontname);
                /*
                putlog "FONTNAME" ":" $fontname "<========================";
                set $fontname trimn($fontname);
                putlog "FONTNAME" ":" $fontname "<========================";
                */
                eval $count 1;
                unset $tmp_fontFace;

                /*
                do /if missing($fontname);
                    putlog "MISSING";
                done;
                */

                do /while !cmp($fontname, ' ');
                    stop /if missing($fontname);
                    /* look for fonts that will make excel croak */
                    iterate $bad_fonts;
                    do /while _value_;
                        do /if cmp($fontname, _value_);
                            unset $fontname /if cmp($fontname, _value_);
                            stop;
                        done;

                        next $bad_fonts;
                    done;

                    /* put the font list back together */
                    do /if $fontname;
                        set $tmp_fontFace $tmp_fontFace ", " /if $tmp_fontFace;
                        set $tmp_fontFace $tmp_fontFace $fontname;
                        unset $fontname;
                    done;

                    eval $count $count + 1;
                    set $fontname scan($fontFace, $count, ',');
                    set $fontname strip($fontname);
                    /*putlog "FONTNAME" ":" $fontname "<<<<<<<<<<<<<<<<<<<<<<<<<<";*/
                done;

                set $fontFace $tmp_fontFace;

                /*---------------------------------------------------eric-*/
                /*-- Excel can't handle more than 3 fonts in it's font  --*/
                /*-- list.  This loop cuts off the last one.            --*/
                /*------------------------------------------------29Jul03-*/
                eval $comma index($fontFace, ",");
                eval $comma_index $comma ;
                eval $comma_count 0;
                set $tmp_fontFace $fontFace;
                do /while $comma > 0;
                    eval $comma $comma+1;
                    eval $comma_count $comma_count + 1;
                    do /if $comma_count = 3;
                        eval $comma_index $comma_index -1;
                        set $fontFace substr($fontFace, 1, $comma_index);
                        stop;
                    done;
                    set $tmp_fontFace substr($tmp_fontFace, $comma);
                    eval $comma index($tmp_fontFace, ",");
                    eval $comma_index $comma_index + $comma ;
                done;

                putq ' ss:FontName=' strip($fontFace);
                unset $fontFace;
            done;

            do /if font_size;
                trigger get_font_height;

                putq ' ss:Size=' $font_height;
            else;
                eval $font_height 0;
            done;

            eval $row_height 0;
            do /if $font_height;
                eval $row_height $font_height + $row_height_fudge;
            done;
            do /if $row_height = 0;
                eval $row_height 12 + $row_height_fudge;
            done;
            /*---------------------------------------------------eric-*/
            /*-- Save away the point size for the data to be used   --*/
            /*-- when the column widths are calculated.             --*/
            /*------------------------------------------------5Oct 04-*/
            do /if cmp(htmlclass, 'data');
                stop /if $data_point_size;
                set $data_point_size $font_height;
            done;


            set $tmp lowcase(htmlclass);
            do /if contains($tmp, "systemtitle");
                set $have_title_style "True";
                do /if cmp($row_heights['Title'], '0');
                    set $row_heights['Title'] $row_height;
                done;
            done;

            do /if contains(htmlclass, "SystemFooter");
                set $have_footer_style "True";
                do /if cmp($row_heights['Footer'], '0');
                    set $row_heights['Footer'] $row_height;
                done;
            done;

            do /if cmp(htmlclass, "byline");
                set $have_byline_style "True";
                do /if cmp($row_heights['Byline'], '0');
                    set $row_heights['Byline'] $row_height;
                done;
            done;

            do /if cmp(htmlclass, 'header');
                stop /if $header_point_size;
                set $header_point_size $font_height;

                do /if cmp($row_heights['Table_head'], '0');
                    set $row_heights['Table_head'] $row_height;
                done;

                do /if cmp($row_heights['Parskip'], '0');
                    set $row_heights['Parskip'] $row_height;
                done;
            done;

            put  ' ss:Italic="1"' / if cmp(FONT_STYLE, 'italic');
            put  ' ss:Bold="1"' / if cmp(FONT_WEIGHT, 'bold');
            putq ' ss:Color=' FOREGROUND /if ^cmp(foreground, 'transparent');


            do /if text_decoration;
                    put $textdecoration['underline']     /if cmp(text_decoration, "underline");
                    put $textdecoration['strikethrough'] /if cmp(text_decoration, "strikethrough");
                    put $textdecoration['overline']      /if cmp(text_decoration, "overline");
                    put $textdecoration['blink']         /if cmp(text_decoration, "blink");
            done;
            put  ' />' NL;


            do /if $debug_level >= 1;
                putlog "CLASS: " htmlclass;
                iterate $row_heights;
                do /while _name_;
                    putlog _name_ ": " _value_;
                    next $row_heights;
                done;
            done;

        done;

        /*-------------------------------------------------------eric-*/
        /*-- If this is the pagebreak style, we need to extract a   --*/
        /*-- pattern and set the colors.  Until there is a pattern  --*/
        /*-- style attribute tagattr will have to do.               --*/
        /*----------------------------------------------------16Aug05-*/
        do /if cmp(htmlclass, "pagebreak");

            stop /if ^any(background, tagattr, foreground);

            put '<Interior';
            putq ' ss:Color=' BACKGROUND;
            putq ' ss:Pattern=' tagattr;
            putq ' ss:PatternColor=' FOREGROUND /if (tagattr);
            put  ' />' NL;

        else;
            do /if background;
                put '<Interior';
                do /if ^cmp(background, 'transparent');
                    putq ' ss:Color=' BACKGROUND;
                    put  ' ss:Pattern="Solid"' / if exist(BACKGROUND);
                done;
                put  ' />' NL;

            else /if cmp(htmlclass, "body");
                 put '<Interior ss:Pattern="Solid" />' nl;
            done;
        done;
    end;

    define event get_font_height;
        /* find out if the font size is in points */
            eval $pt_pos index(FONT_SIZE, "pt") - 1;
            do /if $pt_pos > 0;
               /* if it is a point size take off the unit */
               set $size substr(font_size, 1, $pt_pos);
            else;
               /* translate small, medium, large into numbers. */
                set  $size $font_size[FONT_SIZE];
            done;

            set $convert_this_size $size;
            trigger convert_to_points;
            eval $font_height $converted_this_size;
    end;

    define event pagebreak;
        break /if ^$worksheet_started;
        break /if cmp($sheet_interval, 'Table');
        break /if ^$do_pagebreaks;

        do /if cmp($sheet_interval, "bygroup");
            do /if ^cmp($last_byval, $byvars[$byval_name]);
                break;
            done;
        done;

        set $height $row_heights['PageBreak'];
        eval $worksheet_row $worksheet_row + 1;

        putq '<Row ss:AutoFitHeight="0"';
        putq ' ss:Height=' $height;
        put  '>' nl;
        put  '<Cell ss:StyleID="pagebreak"';
        putq ' ss:MergeAcross=' $colcount;
        put  '/>' nl;
        put  '</Row>' nl;

        break /if ^$skip_factor['pageBreak'];
        set $skip_multiplier $skip_factor['PageBreak'];
        trigger parskip;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- set $skip_multiplier to the NUMBER you want to multiply    --*/
    /*-- the height by.  0 will result in no row.  otherwise the    --*/
    /*-- point size of the parskip height will be multiplied and    --*/
    /*-- used to create this one row.                               --*/
    /*--------------------------------------------------------17Aug05-*/
    define event parskip;
        set $skip_multiplier '0' /if ^$skip_multiplier;
        eval $skip_multiplier inputn($skip_multiplier, 'BEST');

        break /if ^$skip_multiplier | missing($skip_multiplier);

        do /if cmp($row_heights['Parskip'], '0');
            set $row_heights['Parskip'] '10';
        done;

        set $height $row_heights['Parskip'];
        eval $height inputn($height, 'BEST') * $skip_multiplier;

        eval $worksheet_row $worksheet_row + 1;

        putq '<Row ss:AutoFitHeight="0"' ;
        do /if $debug_level = -1;
            putq ' ss:Index=' $worksheet_row ;
        done;
        putq  ' ss:StyleID=' $body_class;
        putq ' ss:Height=' $height '>' nl;
        put  '<Cell ss:StyleID=';
        putq $parskip_style_name;
        /* putq ' ss:MergeAcross=' $colcount; */
        put  '/>' nl;
        put  '</Row>' nl;

        unset $skip_multiplier;
    end;

    define event output;
        start:
            trigger worksheet /if cmp($sheet_interval, "table");
            trigger worksheet /if cmp($sheet_interval, "proc");
        finish:
            trigger worksheet /if cmp($sheet_interval, "table");

            /* for proc freq.... */
            do /if cmp($proc_name, 'Freq');
                trigger worksheet /if cmp($sheet_interval, "bygroup");
            done;
    end;


    define event proc;
        start:
            /* in case embedded_titles or convert_percents has changed. */
            trigger options_setup;
            set $align getoption('center');
            set $align 'left' /if ^cmp($align, 'center');
            set $align lowcase($align);
            set $proc_name name;
            /*-----------------------------------------------------eric-*/
            /*-- We don't really want to start a worksheet here       --*/
            /*-- because the titles haven't come out yet.  So we'll   --*/
            /*-- just be sure to turn off the worksheet when the proc --*/
            /*-- ends.                                                --*/
            /*--------------------------------------------------3Jul 03-*/
        finish:
            trigger worksheet /if cmp($sheet_interval, "proc");
    end;


    /*-----------------------------------------------------------eric-*/
    /*-- Redefine this event if you want to change the way          --*/
    /*-- worksheets get labeled.                                    --*/
    /*--------------------------------------------------------4Jul 03-*/
    define event worksheet_label;

        break /if $sheet_name;

        set $over_ride_sheetName strip(override_sheetname);
        set $worksheetName override_sheetname /breakif $Over_ride_sheetname;

        do /if label;
            set $label label;
        else;
            do /if $proc_label;
                set $label $proc_label;
            else;
                set $label proc_name;
            done;
        done;

        /*---------------------------------------------------eric-*/
        /*-- Try to create a reasonable worksheet label based   --*/
        /*-- on the type of sheet interval we are using.        --*/
        /*------------------------------------------------4Jul 03-*/
            set $worksheetName $sheet_label ' ' /if $sheet_label;
            do /if cmp($sheet_interval, 'none');
                set $worksheetName 'Job ' /if ^$sheet_label;
                set $worksheetName $worksheetName $numberOfWorksheets ' - ' $label;

            else /if cmp($sheet_interval, 'proc');
                do /if $proc_label;
                    set $worksheetName $proc_label /if ^$sheet_label;
                else;
                    set $worksheetName 'Proc ' /if ^$sheet_label;
                    set $worksheetName $worksheetName total_Proc_count ' - ' $label;
                done;

            else /if cmp($sheet_interval, 'page');
                set $worksheetName 'Page ' /if ^$sheet_label;
                set $worksheetName $worksheetName total_page_count ' - ' $label;

            else /if cmp($sheet_interval, 'bygroup');
                do /if ^$byval_name;
                    do /if $sheet_label;
                        set $worksheetName $label ' ' $byGroupLabel;
                    else;
                        set $worksheetName $byGroupLabel;
                    done;
                else;
                    do /if $sheet_label;
                        set $worksheetName $sheet_label ' ' $last_byval;
                    else;
                        set $worksheetName $worksheetName $byval_name '=' $last_byval;
                    done;
                done;

                do /if ^$worksheetName;
                    set $worksheetName 'Table ' /if ^$sheet_label;
                    set $worksheetName $worksheetName $numberOfWorksheets ' - ' $label;
                done;

            else /if cmp($sheet_interval, 'table');
                set $worksheetName 'Table ' /if ^$sheet_label;
                set $worksheetName $worksheetName $numberOfWorksheets ' - ' $label;
            done;

            set $worksheetname strip($worksheetnamem);
        /*-------------------------------------------------------eric-*/
        /*-- If we have a bygroup label then we should use it.      --*/
        /*----------------------------------------------------21Jul03-*/
        /*
        do /if $byGroupLabel;
            set $worksheetName 'By ' $numberOfWorksheets ' ' $byGroupLabel ' - ' $label;
        done;
        */

        unset $byGroupLabel;
        unset $label;

    end;


    /*-----------------------------------------------------------eric-*/
    /*-- make sure the worksheet label doesn't have any invalid     --*/
    /*-- characters and that it is not too long.  The length can    --*/
    /*-- be no longer than 31.                                      --*/
    /*--------------------------------------------------------4Jul 03-*/
    define event clean_worksheet_label;

        set $worksheetName $sheet_name /if $sheet_name;

        set $worksheetName strip($worksheetName);

        /*set $worksheetName compress($worksheetName, "/\?*:'"); */
        set $worksheetName tranwrd($worksheetName, '/', ' ');
        set $worksheetName tranwrd($worksheetName, '\', ' ');
        set $worksheetName tranwrd($worksheetName, '?', ' ');
        set $worksheetName tranwrd($worksheetName, '*', ' ');
        set $worksheetName tranwrd($worksheetName, ':', ' ');
        set $worksheetName tranwrd($worksheetName, "'", ' ');


        do /if $debug_level = -8;
            putlog "SOURCE EVENT" ":" event_name;
            putlog "WORKSHEET NAME" ":" $worksheetname;
            iterate $sheet_names;
            do /while _name_;
                putlog _name_ ": " _value_;
                next $sheet_names;
            done;
        done;
        eval $name_count 0;
        do /if $sheet_names[$worksheetName];
            eval $name_count $sheet_names[$worksheetName] + 0;
            eval $name_count $name_count + 1;
            eval $sheet_names[$worksheetName] $name_count;
        else;
            eval $sheet_names[$worksheetName] 1;
        done;

        eval $available_length 31;
        do /if $name_count;
            set $count_str $name_count;
            eval $available_length 31 - (length($count_str) + 1);
            unset $count_str;
        done;

        eval $worksheetNameLength length($worksheetName);
        do /if $worksheetNameLength > $available_length;
            set $worksheetName substr($worksheetName, 1, $available_length);
        done;

        do /if $name_count;
            set $worksheetName $worksheetName ' ' $name_count;
        done;
    end;

    define event set_print_repeats;
        trigger set_row_repeat;
        trigger set_col_repeat;
    end;

    define event set_row_repeat;
        unset $row_repeat_start;
        unset $row_repeat_end;

        break /if ^$row_repeat;

        do /if $debug_level > 0;
            putlog "===============================================================================";
            putlog "Event Name" event_name;
            putlog "Possible Row Start" $proc_name ": " $possible_row_repeat_start " : " $possible_row_repeat_end;
            putlog "ROW_REPEAT" $row_repeat;
            putlog "===============================================================================";
        done;

        do /if cmp($row_repeat, 'header');
            eval $row_repeat_start $possible_row_repeat_start;
            eval $row_repeat_end   $possible_row_repeat_end;

        else;

            do /if index($row_repeat, '-');
                eval $row_repeat_start inputn(scan($row_repeat, 1, '-'), 'BEST');
                eval $row_repeat_end inputn(scan($row_repeat, 2, '-'), 'BEST');

            else;
                eval $row_repeat_start inputn($row_repeat, 'BEST');
            done;
        done;
    end;

    define event set_col_repeat;
        unset $col_repeat_start;
        unset $col_repeat_end;

        break /if ^$col_repeat;

        do /if $debug_level > 0;
            putlog "Possible Col Start" $proc_name ": " $possible_col_repeat_start " : " $possible_col_repeat_end;
        done;

        do /if cmp($col_repeat, 'header');
            eval $col_repeat_start $possible_col_repeat_start;
            eval $col_repeat_end   $possible_col_repeat_end;

        else;

            do /if index($col_repeat, '-');
                eval $col_repeat_start inputn(scan($col_repeat, 1, '-'), 'BEST');
                eval $col_repeat_end inputn(scan($col_repeat, 2, '-'), 'BEST');

            else;
                eval $col_repeat_start inputn($col_repeat, 'BEST');
            done;
        done;
    end;

    define event Print_repeats;
            /*
            <Names>
               <NamedRange ss:Name="Print_Titles"
                ss:RefersTo="='Table 1 - Data Set SASHELP.CLAS'!C1:C2,'Table 1 - Data Set SASHELP.CLAS'!R4:R5"/>
            </Names>
            */
            trigger set_print_repeats;
            do /if any($row_repeat_start, $col_repeat_start);
                put "<Names>" nl;
                put '<NamedRange ss:Name="Print_Titles"' nl;

                put 'ss:RefersTo="' "='" $worksheetName "'";

                do /if $col_repeat_start;
                    put "!C" $col_repeat_start ':C' $col_repeat_end;

                    do /if $row_repeat_start;
                        put ",'" $worksheetName "'";
                    done;
                done;

                do /if $row_repeat_start;
                    put "!R" $row_repeat_start ':R' $row_repeat_end;
                done;

                put '"/>' nl;
                put "</Names>" nl;
            done;
        end;

        define event worksheet_tab;
            break /if $tabname_is_done;

            do /if ^$content_row;
                do /if $worksheet_row;
                    set $content_row $worksheet_row;
                else;
                    set $content_row "1";
                done;
            done;

            trigger write_tabs_entry;
            trigger write_wb_entry;
            set $tabname_is_done "True";
        end;

        define event do_papersize;
            trigger set_papersize;
            /* look up the papersize by spelling here... */
            put '<PaperSizeIndex>' $papersize '</PaperSizeIndex>' nl;
        end;

    define event worksheet;
        start:

            trigger get_global_margins;
            do /if $proclist[proc_name];
                putlog "Excel XML does not support output from Proc:" proc_name;
                putlog "Output will not be created.";
                break;
            done;
            
            break /if $worksheet_started;

            unset $cellwidths;
            unset $worksheet_widths;
            unset $worksheet_has_panes;
            unset $worksheet_has_autofilter;
            unset $worksheet_has_titles;
            unset $possible_row_repeat_start;
            unset $possible_row_repeat_end;
            unset $possible_col_repeat_start;
            unset $possible_col_repeat_end;

            do /if ^$worksheet_row;
                eval $worksheet_row 0;
            done;

            eval $numberOfWorksheets $numberOfWorksheets + 1;
            /*---------------------------------------------------eric-*/
            /*-- Timing is an issue.  if the options set a name or  --*/
            /*-- label we need to do this now.  Not at the end.  It --*/
            /*-- could change by then.                              --*/
            /*------------------------------------------------23Jan06-*/
            trigger worksheet_label;
            trigger clean_worksheet_label;

            /*trigger contents_entry;*/
            /*trigger worksheet_tab; */ /*/if any($sheet_name, $sheet_label);*/

            do /if cmp($worksheetname, ' ');
                eval $numberOfWorksheets $numberOfWorksheets - 1;
            done;

            do /if $debug_level = -8;
                putlog "!!!!!!!!" Event_name "  Worksheet: |" $worksheetname "|  " $numberOfWorksheets;
            done;

            unset $$worksheet_start;
            open worksheet_start;
            /*-----------------------------------------------------eric-*/
            /*-- write out the system titles and footers.             --*/
            /*--------------------------------------------------2Jul 03-*/
            put '<x:WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">' NL;

            /*---------------------------------------------------eric-*/
            /*-- This has to be above the Print section.  If it's   --*/
            /*-- not excel won't turn it on for us.                 --*/
            /*------------------------------------------------12May06-*/
            do / if $fittopage;
                put "<FitToPage />" nl;
            done;

            put '<Print>' nl;
            put '<ValidPrinterInfo/>' nl;

            trigger do_paperSize;

            do /if $scale;
                put '<Scale>';
                put $scale;
                put '</Scale>' nl;
            done;
            put '<FitWidth>' $pages_fitwidth '</FitWidth>' nl;
            put '<FitHeight>' $pages_fitheight '</FitHeight>' nl;
            put '<LeftToRight/>'  nl /if $left_to_right;
            put '<HorizontalResolution>';
            put $print_dpi;
            put '</HorizontalResolution>' nl;
            put '<VerticalResolution>';
            put $print_dpi;
            put '</VerticalResolution>' nl;
            put '<Gridlines/>' nl /if $gridlines;
            put '<BlackAndWhite/>' nl /if $blackandwhite;
            put '<DraftQuality/>' nl /if $draftquality;
            put '<RowColHeadings/>' nl /if $RowColHeadings;
            put '</Print>' nl;


            put '<Zoom>' $Zoom '</Zoom>' nl /if $Zoom;
            put '<PageLayoutZoom>' $PageLayoutZoom '</PageLayoutZoom>' nl /if $PageLayoutZoom;


            put "<x:PageSetup>" nl;

            put $$page_setup; /* /if !$embedded_titles;*/

            do /if ($embedded_titles & ^$system_title_setup) | ^$system_title_setup ;
                do /if $print_header & ^$xheader;
                    putq '<x:header x:Data=' $print_header ;
                    putq ' x:Margin=' $print_header_margin;
                    put '/>' nl;
                    unset $xheader;
                done;
            done;
            unset $system_title_setup;

            do /if ($embedded_footnotes & ^$system_footer_setup) | ^$system_footer_setup ;
                do /if $print_footer & ^$xfooter;
                    putq '<x:Footer x:Data=' $print_footer ;
                    putq ' x:Margin=' $print_footer_margin;
                    put '/>' nl;
                    unset $xfooter;
                done;
            done;
            unset $system_footer_setup;

            do /if any($landscape, $center_horizontal, $center_Vertical);
                put '<Layout';
                put ' x:Orientation="Landscape"' /if $landscape;
                put ' x:CenterHorizontal="1"' /if $center_horizontal;
                put ' x:CenterVertical="1"' /if $center_vertical;
                put '/>' NL;
            done;

            do /if any($marginbottom, $marginleft, $marginright, $margintop);
                put '<PageMargins';
                putq ' x:Bottom=' $marginbottom;
                putq ' x:Left='   $marginleft;
                putq ' x:Right='  $marginright;
                putq ' x:Top='    $margintop;
                put  '/>' nl;
            done;


            put "</x:PageSetup>" nl;

            close;
            open worksheet;

            set $worksheet_started "True";

            do /if $debug_level = -8;
                putlog "Worksheet Started" ":" $worksheet_started;
                putlog " Event_name " '|' event_name;
                putlog " ";
            done;

        finish:
            break /if $proclist[proc_name];

            break /if ^$worksheet_started;
            unset $worksheet_started;

            do /if ^$$worksheet;
                do /if ^$doing_blank;
                    eval $numberOfWorksheets $numberOfWorksheets - 1;
                    break; 
                done;
            done;
            
            trigger write_contents_entries;

            trigger worksheet_tab;
            unset $tabname_is_done;

            do /if $debug_level = -8;
                putlog "Worksheet Finish" ;
                putlog " Event_name " '|' event_name;
                putlog " ";
            done;


            open master_worksheet;
            /*-------------------------------------------------------eric-*/
            /*-- This wacky.  We keep each worksheet is a smaller       --*/
            /*-- stream.  We also keep the top of the worksheet in      --*/
            /*-- another stream.  All so we can count the titles and    --*/
            /*-- the header rows and use the count in                   --*/
            /*-- worksheet_head_end to create a non-scrolling region.   --*/
            /*-- When we get to the body section we can put the parts   --*/
            /*-- together.  At the end of the table the entire          --*/
            /*-- worksheet get's written to the master worksheet.       --*/
            /*-- The master worksheet get's put together with the style --*/
            /*-- worksheet at the end of the doc_body to create a       --*/
            /*-- complete file.                                         --*/
            /*----------------------------------------------------4Aug 04-*/
            putq '<Worksheet ss:Name=' $worksheetName '>' NL;

            trigger print_repeats;

            set $current_worksheet $worksheetName;
            unset $tempWorksheetName;
            unset $worksheetName;

            put $$worksheet_start;
            unset $$worksheet_start;


            trigger worksheet_head_end;

            trigger table_start;
            put $$worksheet;

            putl '</Table>';
            eval $table_count 0;
            unset $$worksheet;
            unset $byGroupLabel;
            putl '</Worksheet>';
            eval $worksheet_row 0;
    end;


    define event table_start;
        /*
        break /if ^$regular_table;
        unset $regular_table;
        */
        put  '<Table';
        putq  ' ss:StyleID=' $body_class;
        putl '>';
        /*-------------------------------------------------------eric-*/
        /*-- Write out the colspecs for the entire worksheet.       --*/
        /*----------------------------------------------------17Dec04-*/
        do /if $debug_level >= 3;
            iterate $worksheet_widths;
            do /while _value_;
                putlog "ss:Column: Worksheet_widths" ": " _value_;
                next $worksheet_widths;
            done;
        done;
        
        eval $column 1;
        iterate $worksheet_widths;
        do /while _value_;

            put '<ss:Column ss:AutoFitWidth="1"';
            eval $numeric_width inputn(_value_, 'BEST');
            /*---------------------------------------------------eric-*/
            /*-- Maximum column width is 1200.                      --*/
            /*------------------------------------------------5Aug 05-*/
            do /if $numeric_width > 0;
                do /if $numeric_width > 1200;
                    putq ' ss:Width="1200"';
                else;
                    putq ' ss:Width=' _value_;
                done;
            done;
            do /if $hidden_columns;
                set $column_str $column;
                put ' ss:Hidden="1"' /if $hidden_columns[$column_str];
                eval $column $column+1;
            done;
            
            put '/>' nl;
            next $worksheet_widths;
        done;
    end;


    /*
   <Selected/>
   <FreezePanes/>
   <FrozenNoSplit/>
   <SplitHorizontal>1</SplitHorizontal>
   <TopRowBottomPane>1</TopRowBottomPane>
   <SplitVertical>1</SplitVertical>
   <LeftColumnRightPane>1</LeftColumnRightPane>
   <ActivePane>0</ActivePane>
   <Panes>
    <Pane>
     <Number>3</Number>
    </Pane>
    <Pane>
     <Number>1</Number>
    </Pane>
    <Pane>
     <Number>2</Number>
    </Pane>
    <Pane>
     <Number>0</Number>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
    */

    define event add_title_rowcounts;
        /*-------------------------------------------eric-*/
        /*-- Sure would be nice to be able to do this.  --*/
        /*-- eval $nskip ^^$skip_factor['title'];       --*/
        /*----------------------------------------19Aug05-*/
        do /if $skip_factor['title'];
            eval $nskip 1;
        else;
            eval $nskip 0;
        done;
        eval $row_count $row_count + $titles + $nskip;
        eval $worksheet_row $worksheet_row + $titles + $nskip;
    end;

    define event worksheet_head_end;

        do /if any($frozen_headers, $frozen_rowheaders);
            stop /if $worksheet_has_panes;
            put '<Selected/>' nl;
            put '<FreezePanes/>' nl;
            put '<FrozenNoSplit/>' nl;
            set $worksheet_has_panes "true";
            do /if $embedded_titles;
                do /if $titles;
                    trigger add_title_rowcounts;
                done;
            done;

            unset $panes;
            eval $pane_count 0;
            do /if $frozen_headers;
                /*putlog "Frozen" "header" $frozen_header_count " : " $row_count;*/
                do /if ^$frozen_header_count;
                    eval $frozen_header_count $row_count ;
                done;
                do /if $frozen_header_count > 0;
                    put '<SplitHorizontal>' $frozen_header_count '</SplitHorizontal>' nl;
                    put '<TopRowBottomPane>' $frozen_header_count '</TopRowBottomPane>' nl;
                    eval $pane_count $pane_count + 2;
                    set $panes['3'] '3';
                    set $panes['2'] '2';
                    set $active_pane '2';
                done;
            done;

            do /if $frozen_rowheaders;
                do /if $frozen_rowheader_count;
                    eval $fz_rowh_count $frozen_rowheader_count;
                else;
                    eval $fz_rowh_count $best_rowheader_count;
                done;
                do /if $fz_rowh_count > 0;
                    put '<SplitVertical>' $fz_rowh_count '</SplitVertical>' nl;
                    put '<LeftColumnRightPane>' $fz_rowh_count '</LeftColumnRightPane>' nl;
                    eval $pane_count $pane_count + 2;
                    do /if $panes['3'];
                        set $panes['0'] '0';
                        set $active_pane '0';
                    else;
                        set $panes['3'] '3';
                        set $active_pane '1';
                    done;
                    set $panes['1'] '1';
                done;
            done;
            do /if $panes;
                put '<ActivePane>' $active_pane '</ActivePane>' nl;
                put '<Panes>' nl;
                putvars $panes '<Pane>' nl '<Number>' _name_ '</Number>' nl '</Pane>' nl;
                put '</Panes>' nl;
            done;
            put '<ProtectObjects>False</ProtectObjects>' nl;
            put '<ProtectScenarios>False</ProtectScenarios>' nl;
        done;

        put '</x:WorksheetOptions>' nl;

        trigger write_autofilter;
    end;

    define event reset_autofilter;
        unset $autofilter_row;
        unset $last_autofilter_row;
    end;

    define event write_autofilter;

        do /if $autofilter;
            /*---------------------------------------------------eric-*/
            /*-- Should be able to do a stop here to get the same   --*/
            /*-- effect.  Stop doesn't seem to go all the way to    --*/
            /*-- the end.  I think the else if confuses it.         --*/
            /*------------------------------------------------18May06-*/
            trigger reset_autofilter /breakif $worksheet_has_autofilter;
            trigger reset_autofilter /breakif ^$autofilter_row;
            trigger reset_autofilter /breakif ^$last_autofilter_row;


            set $worksheet_has_autofilter "True";
            putq '<AutoFilter';
            put  ' x:Range="';
            do /if $last_autofilter_col;
                eval $last $last_autofilter_col+1;
            else;
                eval $last 1;
            done;

            do /if cmp($autofilter, 'all');
                /*-----------------------------------------------eric-*/
                /*-- I don't remember why, but colcount is always 1 less than--*/
                /*-- the actual number of columns. - it's decremented in--*/
                /*-- colspecs finish.                               --*/
                /*--------------------------------------------6Oct 04-*/
                put 'R' $autofilter_row 'C1:R' $last_autofilter_row 'C' $last ;

            else /if index($autofilter, '-');
                eval $tmp_col inputn(scan($autofilter, 1, '-'), 'BEST');
                set $tmp_col $last /if $tmp_col > $last;
                put 'R' $autofilter_row 'C' $tmp_col ;
                /*put 'R1C' $tmp_col;*/

                eval $tmp_col inputn(scan($autofilter, 2, '-'), 'BEST');
                set $tmp_col $last /if $tmp_col > $last;
                put ':R' $last_autofilter_row 'C' $tmp_col ;
                /*put ':R2C' $tmp_col;*/

            else;
                eval $tmp_col inputn($autofilter, 'BEST');
                do /if missing($tmp_col);
                    put 'R' $autofilter_row 'C1:R' $last_autofilter_row 'C' $last ;
                else;
                    set $tmp_col $last /if $tmp_col > $last;
                    put 'R' $autofilter_row 'C' $tmp_col ;
                    put ':R' $last_autofilter_row 'C' $tmp_col ;
                    /*put 'R1C' $tmp_col;
                    put ':R2C' $tmp_col; */
                done;
            done;
            put  '" xmlns="urn:schemas-microsoft-com:office:excel">';
            putq '</AutoFilter>';
        done;
        unset $autofilter_row;
        unset $last_autofilter_row;
    end;

    define event bygroup;
        start:
            trigger contents_entry;
            trigger check_set_byvars;
        finish:
            unset $last_byval;
            unset $byval_name;
            trigger worksheet finish /if cmp($sheet_interval, "bygroup");
    end;

    define event byline;
        set $byGroupLabel VALUE;
        set $byline value;
        set $byline_style htmlclass;

        trigger check_set_byvars;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- For now, just check to see if the first byvalue has        --*/
    /*-- changed. If it has, then it's time to start a new          --*/
    /*-- worksheet.  Otherwise keep going on this worksheet.        --*/
    /*--------------------------------------------------------17Aug05-*/
    define event check_set_byvars;

        trigger proc_print_byvars /breakif cmp($proc_name, 'Print');

        /*-------------------------------------------------------eric-*/
        /*-- Set the first byvalue if we don't have one.  Start a   --*/
        /*-- new worksheet while we are at it...                    --*/
        /*----------------------------------------------------17Aug05-*/
        do /if ^$byval_name & $byvars;
            iterate $byvars;
            set $byval_name _name_;
            set $last_byval _value_;
            do /if cmp($sheet_interval, "bygroup");
                trigger worksheet finish;
                trigger worksheet;
            done;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- If the first byval has changed then it's time to start --*/
        /*-- a new worksheet.                                       --*/
        /*----------------------------------------------------18Aug05-*/
        do /if ^cmp($last_byval, $byvars[$byval_name]);
            set $last_byval $byvars[$byval_name];
            trigger worksheet finish /if cmp($sheet_interval, "bygroup");
            trigger worksheet /if cmp($sheet_interval, "bygroup");
        done;

        /*
        do /if $byvars;
            iterate $byvars;
             putlog "==================";
             putlog "EVENT Name: " event_name;
             do /while _name_;
                 putlog _name_ "=" _value_;
                 next $byvars;
             done;
             putlog "==================";
         done;
         */

     end;

     /*----------------------------------------------------------eric-*/
     /*-- Proc print doesn't cooperate with ODS when it comes to    --*/
     /*-- byline processing.  We don't get the byvars.  So this     --*/
     /*-- event is here to extract the name and value...            --*/
     /*-------------------------------------------------------22Aug05-*/
     define event proc_print_byvars;
         eval $byval_name scan($byline,1,'=');
         eval $byval scan($byline,2,'=');
         do /if index($byval, '=');
             set $byval reverse($byval);
             eval $byval_start_pos index($byval, ' ');
             do /if $byval_start_pos > 0;
                 eval $byval strip(substr($byval, $byval_start_pos));
             else;
                 eval $byval strip($byval);
             done;
             set $byval reverse($byval);
         done;
        /*-------------------------------------------------------eric-*/
        /*-- If the first byval has changed then it's time to start --*/
        /*-- a new worksheet.                                       --*/
        /*----------------------------------------------------18Aug05-*/
        do /if ^cmp($last_byval, $byval);
            set $last_byval $byval;
            trigger worksheet finish /if cmp($sheet_interval, "bygroup");
            trigger worksheet /if cmp($sheet_interval, "bygroup");
        done;
     end;

    define event verbatim;
        start:
            /*-----------------------------------------------------eric-*/
            /*-- There are various reasons we may not have a          --*/
            /*-- worksheet currently open.  So just make sure         --*/
            /*-- we have one.                                         --*/
            /*--------------------------------------------------2Jul 03-*/
            eval $colcount 0;
            trigger worksheet;

            /*
            put  '<Table';
            putq ' ss:StyleID=' HTMLCLASS;
            putl '>';
            put '<ss:Column ss:AutoFitWidth="1"/>' nl;
            */
            do /if ^$colcount;
                set $table_widths[] '0';
                eval $colcount $colcount+1;
            done;
        finish:
            trigger embedded_footnotes;
            /*putl '</Table>';*/
            trigger worksheet finish /if cmp($sheet_interval, "table");
            do /if ^$byvars;
                trigger worksheet finish /if cmp($sheet_interval, "bygroup");
            done;
        end;

    define event association;
        start:
            set $in_association "True";
        finish:
            unset $in_association;
    end;

    define event caption;
        start:
            set $caption value text;
            set $in_caption "True";
        finish:
            unset $in_caption;
    end;

    define event verbatim_text;

        /*-------------------------------------------------------eric-*/
        /*-- toggle the stream if we are in a head section.         --*/
        /*-- for proc report and tabulate.                          --*/
        /*----------------------------------------------------19Aug03-*/
        trigger worksheet_or_head;
        
        /*put  '<Row ss:StyleID="batch"><Cell ss:StyleID="batch">';*/
        put  '<Row ss:StyleID="batch"><Cell ss:StyleID="batch">';
        putq  '<Data ss:Type="String"';
        put '>';

        /*-----------------------------------------------eric-*/
        /*-- put on a dot to preserve leading spaces.       --*/
        /*-- Excel doesn't like leading and trailing space. --*/
        /*--------------------------------------------28Jul03-*/
        do /if $do_ascii_dots;
            set $value "." value;
        else;
            set $value value;
        done;

        set $value strip($value);

        put $value;

        unset $value;

        putl '</Data></Cell></Row>';

        open worksheet;
    end;

    define event initialize_worksheet;
            /*-----------------------------------------------------eric-*/
            /*-- There are various reasons we may not have a          --*/
            /*-- worksheet currently open.  So just make sure         --*/
            /*-- we have one.                                         --*/
            /*--------------------------------------------------2Jul 03-*/
            unset $auto_sub_totals_done;
            eval $colcount 0;
            eval $row_count 0;
            eval $rowheader_count 0;
            eval $best_rowheader_count 0;
            eval $first_data_column 0;
            trigger worksheet;
            do /if ^$table_count;
                eval $table_count 1;
            else;
                eval $table_count $table_count + 1;
            done;

            do /if $worksheet_row;
                set $content_row $worksheet_row;
            else;
                set $content_row "1";
            done;
    end;

    define event table;
        start:
            trigger initialize_worksheet;
            /*set $regular_table "True";*/
            set $table_class lowcase(HTMLCLASS);
            set $is_a_table_head "true";
        finish:

            /*---------------------------------------------------eric-*/
            /*-- For the column repeat on pagesetup.                --*/
            /*------------------------------------------------30Aug05-*/
            do /if ^$possible_col_repeat_start;
                do /if $best_rowheader_count > 1;
                    eval $possible_col_repeat_end $best_rowheader_count;
                    eval $possible_col_repeat_start 1;
                else;
                    eval $possible_col_repeat_start $best_rowheader_count;
                done;
            done;

            do /if $table_count = $autofilter_table;
                do /if ^$last_autofilter_row;
                    eval $last_autofilter_row $worksheet_row;
                    eval $last_autofilter_col $colcount;
                done;
            done;

            do /if ^cmp($sheet_interval, 'Table');
                /* A blank line after the table?  Probably... */
                set $skip_multiplier $skip_factor['Table'];
                trigger parskip;
            done;

            /*---------------------------------------------------eric-*/
            /*-- An association is a proc freq legend table or a    --*/
            /*-- caption for proc tabulate or report.  The freq     --*/
            /*-- legend table should go with the next table...      --*/
            /*------------------------------------------------8Sep 05-*/
            trigger embedded_footnotes;
            do /if ^$in_association;
                trigger worksheet finish /if cmp($sheet_interval, "table");
                do /if ^$byvars;
                    trigger worksheet finish /if cmp($sheet_interval, "bygroup");
                done;
            done;
        end;
        
        /*
         define event proc_title;
                set $span_cell_index $worksheet_row;
                set $span_cell_style $byline_style;
                eval $worksheet_row $worksheet_row + 1;
                unset $merge;
                set $merge "True" /if cmp($align, 'center');
                trigger span_cell_style_just;
                set $height $row_heights['Byline'];
                set $span_cell_value value;
                trigger span_cell start;
                trigger span_cell finish;
                unset $span_cell_index;
                set $skip_multiplier $skip_factor['Byline'];
                trigger parskip;
            end;
            */

        define event do_byline;
                break /if ^$byline;
                break /if $no_bylines;
                set $span_cell_index $worksheet_row;
                set $span_cell_style $byline_style;
                eval $worksheet_row $worksheet_row + 1;
                unset $merge;
                set $merge "True" /if cmp($align, 'center');
                trigger span_cell_style_just;
                set $height $row_heights['Byline'];
                set $span_cell_value $byline;
                trigger span_cell start;
                trigger span_cell finish;
                unset $span_cell_index;
                unset $byline;

                /* A blank line after the byline?  Perhaps... */
                set $skip_multiplier $skip_factor['Byline'];
                trigger parskip;
        end;

        define event do_caption;
                break /if ^$caption;
                set $span_cell_index $worksheet_row;
                set $span_cell_style htmlclass;
                eval $worksheet_row $worksheet_row + 1;
                unset $merge;
                set $merge "True" /if cmp($align, 'center');
                trigger span_cell_style_just;
                /*set $height $row_heights['Byline'];*/
                set $span_cell_value $caption;
                trigger span_cell start;
                trigger span_cell finish;
                unset $span_cell_index;
                unset $caption;
        end;

        define event do_data_note;
                set $span_cell_style htmlclass;
                eval $worksheet_row $worksheet_row + 1;
                unset $merge;
                set $merge "True" /if cmp($align, 'center');
                trigger span_cell_style_just;
                /*set $height $row_heights['Byline'];*/
                set $span_cell_value value;
                trigger span_cell start;
                trigger span_cell finish;
                unset $span_cell_index;
        end;

        define event data_note;
            start:
                set $saved_align $align;
                set $align "center" /if cmp(just, 'c');
                set $align "left" /if cmp(just, 'l');
                set $align "right" /if cmp(just, 'r');
                put "</Row>" nl;
                set $in_data_note "True";
                trigger do_data_note;
            finish:
                unset $in_data_note;
                set $dont_close_row "True";
                set $align $saved_align;
        end;

        define event row;
        start:
            /*-------------------------------------------------------eric-*/
            /*-- toggle the stream if we are in a head section.         --*/
            /*-- for proc report and tabulate.                          --*/
            /*----------------------------------------------------19Aug03-*/
            trigger worksheet_or_head;

            trigger do_byline;
            trigger do_caption;

            eval $worksheet_row $worksheet_row + 1;

            /*trigger row_start;*/

            do /if ^$data_row_count;
                eval $data_row_count 0;
            done;

            do /if cmp(section, 'head');
                eval $row_count $row_count+1;

            else /if cmp(section, 'body');
                eval $data_row_count $data_row_count+1;
            done;

            do /if cmp(section, 'body');
                do /if $rowheader_count > $best_rowheader_count;
                    eval $best_rowheader_count $rowheader_count;
                done;
                eval $rowheader_count 0;
            done;

            eval $this_row_height 1;

            open row;


            /*open worksheet;*/

      finish:
            /*-------------------------------------------------------eric-*/
            /*-- toggle the stream if we are in a head section.         --*/
            /*-- for proc report and tabulate.                          --*/
          /*----------------------------------------------------19Aug03-*/
            trigger worksheet_or_head;

            trigger row_start;

            put $$row;
            unset $$row;

            putl '</Row>' /if ^$dont_close_row;
            unset $dont_close_row;
            set $auto_sub_totals_done "True" /if ($auto_sub_totals_done, "Almost");

            open worksheet;
  end;


     define event row_start;
            put  '<Row';
            put  ' ss:AutoFitHeight="1"';
            unset $hidden;
            set $hidden strip($attrs['hidden']) /if $attrs;
            put  ' ss:Hidden="1"' /if cmp($hidden, 'yes');

            do /if ^$do_auto_fit_height;

                do /if cmp(section, 'head');
                    set $tmp $row_heights['Table_head'];
                else;
                    set $tmp $row_heights['Table'];
                done;
                set $tmp '15' /if cmp($tmp, '0');

                putlog "ROWSTART" $this_row_height ":" $tmp /if $debug_level = -2;

                eval $this_row_height inputn($tmp, 'BEST') * $this_row_height;

                putlog "ROWSTART" $this_row_height ":" $tmp /if $debug_level = -2;

                putq ' ss:Height=' $this_row_height;
                do /if $debug_level = -1;
                    putq ' ss:Index=' $worksheet_row;
                done;
            done;
            /*putq ' ss:StyleID=' lowcase(HTMLCLASS);*/
            putl '>';

     end;

    define event colspec_entry;
        start:
            open worksheet;
            unset $colwidth;
            /*---------------------------------------------------------eric-*/
            /*-- This should be there.  But excel has a bug, that causes  --*/
            /*-- autofit to not work if width is specified.  Autofit      --*/
            /*-- doesn't work so well anyway... This is the best we can   --*/
            /*-- do.                                                      --*/
            /*------------------------------------------------------3Jul 03-*/
            set $colwidth strip(colwidth);

            /*
            do /if cmp($proc_name, "tabulate") & $default_widths;
                set $colwidth "0";
            done;
            */

            do /if $debug_level >= 2;
                /*put "COLSPEC:" nl "_________________" nl;
                    putvars event _name_ " : " _value_ nl; 
                    put "==================" nl; */
                putlog "Colwidth" ": " colwidth " Points" ":" $widthpoints " fudge" ":" $widthfudge;
                putlog "datapointsize" ": " $data_point_size ;
                putlog "headerpointsize" ": " $header_point_size ;
            done;

            /*--------------------------------------------------------Vince-*/
            /*-- Compute a default value of header_len based on the      --*/
            /*-- column name.  This will be used in the event that there --*/
            /*-- is no label on the column and if LABEL is not specified --*/
            /*-- with PROC PRINT.                                        --*/
            /*------------------------------------------------------22Dec04-*/

            do /if exists(name);
              eval $header_len length(name);
            else;
              eval $header_len 0;
            done;

    finish:

            do /if $colwidth ;
                eval $number_of_chars inputn($colwidth, 'BEST');
                do /if missing($number_of_chars);
                    eval $number_of_chars 0+0;
                done;
            else;
                eval $number_of_chars 0+0;
            done;

            do /if $debug_level >= 2;
                putlog "Colwidth" ": " colwidth " # of Chars" ":" $number_of_chars;
            done;
            /*---------------------------------------------------eric-*/
            /*-- If no column width get the corresponding default width--*/
            /*-- if we have any.  Or get the corresponding absolute --*/
            /*-- width regardless of what we have.                  --*/
            /*------------------------------------------------29Aug05-*/
            trigger get_alternate_width;

            do /if $widthPoints;
                eval $points $widthPoints;
            else;
                eval $points max(inputn($header_point_size, '3.'), inputn($data_point_size, '3.'));
            done;

            do /if ^$points;
                eval $points 12;
            done;

            do /if $debug_level >= 3;
                Putlog "=======================================";
                Putlog "Colspec Entry, Finish.";
                putlog "Colwidth" ": " $colwidth " HeaderLen" ": " $header_len;
                putlog "Points" ":" $points " fudge" ":" $widthfudge;
                putlog "data point size" ": " $data_point_size ;
                putlog "header point size" ": " $header_point_size ;
                putlog "Number of Chars" ": " $number_of_chars ;
            done;

            do /if exists($number_of_chars, $Points, $widthfudge);

                eval $width $Points * $number_of_chars * $widthfudge;

                do /if $debug_level >= 3;
                    putlog "Calculated Width" ": " $width ;
                done;

                set $table_widths[] $width;

            else;

                /*-----------------------------------------------eric-*/
                /*-- Proc Report doesn't give proper colspecs.  We  --*/
                /*-- don't know the width.  Let's put an entry in   --*/
                /*-- anyway.  At least we'll know we have some columns.--*/
                /*--------------------------------------------2Aug 05-*/
                /* unset $foo;
                set $foo $number_of_chars;
                set $foo $width /if ^$foo;*/
                do /if $number_of_chars;
                    set $table_widths[] $number_of_chars;
                else;
                    set $table_widths[] ' ';
                done;
            done;

            do /if $debug_level >= 5;
                putlog "Table column width entries:" $table_widths;
                Putlog "=======================================";
            done;

            eval $colcount $colcount+1;
        end;

        define event get_alternate_width;

            do /if $absolute_widths;
                trigger get_absolute_width;
            else;
                trigger get_default_width;
                /*---------------------------------------------------eric-*/
                /*-- always let the header adjust the column width as needed.--*/
                /*------------------------------------------------30Aug05-*/
                trigger adjust_width;
            done;

            do /if $debug_level >= 2;
                putlog "Alternate Width?" ": " colwidth " # of Chars" ":" $number_of_chars;
            done;

        end;

        define event get_absolute_width;
            break /if ^$absolute_widths;

            eval $index $absolute_widths;

            do /if $index > 1;
                eval $tmp_colcount $colcount+1;
                eval $index $absolute_widths;

                do /if $index > $tmp_colcount;
                    eval $index $tmp_colcount;

                else /if $tmp_colcount > $index;
                    do /while $tmp_colcount > $index;
                        eval  $tmp_colcount $tmp_colcount - $absolute_widths;
                    done;
                    eval $index $tmp_colcount;
                done;
            done;

            set $defwid $absolute_widths[$index];
            eval $tmp_width inputn($defwid, 'BEST');

            /*---------------------------------------------------eric-*/
            /*-- If the absolute width is negative, then let the    --*/
            /*-- header length come into play.  Adjust to bigger as --*/
            /*-- desired.                                           --*/
            /*------------------------------------------------30Aug05-*/
            do /if $tmp_width < 0;
                eval $number_of_chars $tmp_width * -1;
                trigger adjust_width;
            else;
                eval $number_of_chars $tmp_width;
            done;

            do /if $debug_level >= 3;
                putlog "THIS ABSOLUTE WIDTH" ": " $number_of_chars "   INDEX" ": " $index "<<<<========";
                iterate $absolute_widths;
                do /while _value_;
                    putlog "ABSOLUTE WIDTHS:" _value_;
                    next $absolute_widths;
                done;
                putlog ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
            done;
        end;



        define event get_default_width;
            break /if $number_of_chars ^= 0;

            break /if ^$default_widths;

            eval $index $default_widths;

            do /if $index > 1;
                eval $tmp_colcount $colcount+1;
                eval $index $default_widths;

                do /if $index > $tmp_colcount;
                    eval $index $tmp_colcount;

                else /if $tmp_colcount > $index;
                    do /while $tmp_colcount > $index;
                        eval  $tmp_colcount $tmp_colcount - $default_widths;
                    done;
                    eval $index $tmp_colcount;
                done;
            done;

            set $defwid $default_widths[$index];
            eval $number_of_chars inputn($defwid, 'BEST');
            do /if $debug_level >= 3;
                putlog "THIS DEFAULT WIDTH" ": " $number_of_chars "   INDEX" ": " $index "<<<<========";
                iterate $default_widths;
                do /while _value_;
                    putlog "DEFAULT WIDTHS:" _value_;
                    next $default_widths;
                done;
                putlog ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
            done;

        end;

        /*-------------------------------------------------------eric-*/
        /*-- Adjust width according to header length and size.      --*/
        /*----------------------------------------------------30Aug05-*/
        define event adjust_width;
            do /if $number_of_chars < $header_len;
                eval $difference $header_len - $number_of_chars;

                do /if $debug_level >= 3;
                    putlog "Colspec Entry: number_of_chars=" $number_of_chars " header_len=" $header_len " difference=" $difference;
                done;

                do /if $difference > 0;
                    eval $number_of_chars $number_of_chars + $difference;
                done;

                /* Used to be this.  But it's the same thing. */
                /*
                do /if $difference = 1;
                    eval $number_of_chars $number_of_chars + 1;
                else;
                    eval $number_of_chars $header_len;
                done;
                */

                /*-----------------------------------------------eric-*/
                /*-- I would think that a heuristic something       --*/
                /*-- like this would be better.  It just needs      --*/
                /*-- some experimentation.                          --*/
                /*--------------------------------------------30Aug05-*/
                /*
                do /if $difference < 10;
                    eval $number_of_chars $header_len;
                else /if $difference < 20;
                    eval $number_of_chars $number_of_chars + $header_len / 2 ;
                else /if $difference < 40;
                    eval $number_of_chars $number_of_chars + $header_len / 3 ;
                else;
                    eval $number_of_chars $header_len;
                done;
                */
                unset $difference;
            done;
        end;

        define event sub_colspec_header;
            trigger calculate_header_len;
        end;

    define event calculate_header_len;
        eval $header_len 0;
        unset $tmp_value;
        set $tmp_value strip(value);
        do /if $tmp_value;
            eval $header_len length($tmp_value);
            do /if $debug_level = 3;
                putlog "CALCULATE_HEADER_LEN";
                putlog "Header Len" ": " $header_len " |" $tmp_value "|";
            done;
          /*------------------------------------------------------Vince-*/
          /*-- Recalculate the header length if it contains a split   --*/
          /*-- character.                                             --*/
          /*----------------------------------------------------20Dec04-*/
          eval $headerStringIndex index(value, '&#10;');
          do /if $headerStringIndex > 0;
            eval $headerStringIndex 1;
            eval $header_len 0;
            set $headerFragment scan(value, $headerStringIndex, '&#10;');
            do /while ^cmp($headerFragment, ' ');
              eval $header_len max($header_len, length($headerFragment));
              eval $headerStringIndex $headerStringIndex+1;
              eval $headerFragment scan(value, $headerStringIndex, '&#10;');
            done;
          done;
          unset $headerStringIndex;
          unset $headerFragment;
        done;
        unset $tmp_value;
        /* putlog " "; */
        /* putlog "sub_colspec_header event: value=" value " label=" label " header_len=" $header_len; */
        do /if $attrs;
            do /if $attrs['rotate'];
                set $rotation $attrs['rotate'];
                eval $rotation inputn($rotation, 'BEST');
                eval $actual_header_len $header_len * cos($rotation);
                putlog "Rotation & header_len: " $rotation ":" $actual_header_len /if $debug_level = -2;
            done;
        done;
    end;

    define event MergeAcross;
        do /if colspan;
            eval $mergeAcross inputn(COLSPAN, "3.")-1;
            putq ' ss:MergeAcross=' $mergeAcross;
            unset $mergeAcross;

        else;

            unset $mergeacross;
            set $mergeacross strip($attrs['mergeacross']) /if $attrs;
            do /if $mergeacross;
                do /if cmp($mergeacross, 'yes');
                    putq ' ss:MergeAcross=' $worksheet_widths;
                else;
                    eval $mergeAcross inputn($mergeacross, "BEST.");
                    do /if ^missing($mergeacross);
                        putq ' ss:MergeAcross=' $mergeAcross;
                    done;
                done;
            done;
        done;
    end;

    define event MergeDown;
        eval $mergeDown   inputn(ROWSPAN, "5.")-1;
        putq ' ss:MergeDown=' $mergeDown;
        unset $mergeDown;
    end;

    define event cell_start;
        start:
            unset $just;
            /*---------------------------------------------------eric-*/
            /*-- If there are over-rides write the style            --*/
            /*-- attributes to a stream for safe keeping.           --*/
            /*------------------------------------------------19Aug03-*/
            set $cell_class lowcase(htmlclass);
            do /if contains($cell_class, "ata") |
                contains($cell_class, "eader");
                set $cell_class $cell_class '__' just /if ^$styles_with_just[$cell_class];
            done;
            do /if any(font_face, font_size, font_style,
                font_weight, foreground, background,
                borderwidth, bordercolor, borderstyle,
                bordertopwidth, bordertopcolor, bordertopstyle,
                borderbottomwidth, borderbottomcolor, borderbottomstyle,
                borderrightwidth, borderrightcolor, borderrightstyle,
                borderleftwidth, borderleftcolor, borderleftstyle,
                text_decoration
                );

                set $style_over_ride "true";
                /*-----------------------------------------------eric-*/
                /*-- This event redirects to it's own stream,       --*/
                /*-- ye be warned...                                --*/
                /*--------------------------------------------19Aug03-*/
                do /if $debug_level = -9;
                    putlog "CELL START: Doing xl_style_elements";
                done;

                trigger xl_style_elements;
            else;
                unset $style_over_ride;
            done;

            /*---------------------------------------------------eric-*/
            /*-- Mostly for aesthetics.  stream switching causes    --*/
            /*-- unsightly line breaks.  Save the cell tag away     --*/
            /*-- until we can print it all at once.                 --*/
            /*------------------------------------------------19Aug03-*/
            open cell_start;
            trigger MergeAcross ;
            trigger MergeDown  / if ROWSPAN;
            putq ' ss:Index=' COLSTART;
            close;

            open row;

            set $format_override $attrs['format'] /if $attrs;


            do /if $debug_level = -9;
                putlog "EVENT cell_start";
                putlog "FORMAT_OVER_RIDE" ": " $format_override;
                putlog "CELL_CLASS" ": " $cell_class;
            done;


        finish:

            break /if ^$$cell_start;

            open row;

            put '<Cell';
            putq ' ss:StyleID=' $cell_class;
            unset $cell_class;
            putq ' ss:HRef=' url;
            unset $formula;
            do /if $debug_level = -5;
                stop  /if ^$attrs;
                putlog "CELL FORMULA:";
                putlog ":" $attrs['formula'] ":";
            done;
            iterate $attrs;
            do /while _name_;
                set $formula _value_ /if cmp(_name_, 'formula');
                next $attrs;
            done;
            /*---------------------------------------------------eric-*/
            /*-- single quotes sometimes work but that is           --*/
            /*-- technically invalid XML.  double quotes are good   --*/
            /*-- XML but they don't work if there are embedded      --*/
            /*-- double quotes.                                     --*/
            /*------------------------------------------------24Feb06-*/
            do /if $debug_level = -5;
                putlog "CELL FORMULA2:";
                putlog ":" $formula ":";
                putlog ":" $formula ":";
            done;
            set $formula strip($formula);
            do /if $formula;
                set $type "Number" /if ^$value;
                do / ^cmp($type, 'String');
                    /*put " ss:Formula='" $formula "'";*/
                    set $formula  tranwrd($formula, '"', '&quot;');
                    putq " ss:Formula=" $formula ;
                    do /if $debug_level = -6;
                         putlog "CELL FORMULA3:";
                         putlog ":" $formula ":";
                    done;
                done;
            else;
                trigger subtotals;
            done;

            put $$cell_start;
            put  '>';
            trigger comment;
            unset $$cell_start;

            close;
        end;

        define event subtotals;
                break /if ^$auto_sub_totals;
                break /if ^cmp($proc_name, 'print');
                break /if cmp($type, 'String');
                break /if cmp($auto_sub_totals_done, 'True');
                break /if cmp(section, 'head');
                break /if ^colstart;
                break /if $first_data_column > inputn(colstart, 'BEST');
                /* this is a bug.  It should be able work like this */
                /* break /if ^cmp(event_name, 'header') & ^cmp(name, 'Obs'); */
                do /if ^cmp(event_name, 'header');
                    break /if ^cmp(name, 'Obs');
                done;
                set $tmp_value strip(value);
                do /if $data_row_count < 2;
                    do /if $first_data_column = 0;
                        break;
                    done;
                done;
                do /if $tmp_value;
                    do /if $debug_level = -6;
                         putlog "CELL FORMULA4:";
                         putlog ":" $formula ":";
                    done;
                    /*
                    put nl "ADDING SUBTOTAL: value is  " "|" $tmp_value "|" nl;
                    put "               : section   " "|" section "|" nl;
                    put "               : event_name" "|" event_name "|" nl;
                    put "               : proc_name " "|" $proc_name "|" nl;
                    put "               : colstart  " "|" colstart "|" nl;
                    put "               : first D C " "|" $first_data_column "|" nl;
                    put "               : Data Row  " "|" $data_row_count "|" nl;
                    */
                    eval $tmp_count $data_row_count -1;
                    put ' ss:Formula=';
                    put '"=SUBTOTAL(9,R[-' $tmp_count ']C:R[-1]C)"';
                    unset $tmp_count;
                    set $auto_sub_totals_done "Almost";
                done;
                unset $tmp_value;
        end;

            /*
     <Cell ss:StyleID="s22"><Data ss:Type="String">c</Data>
            <Comment ss:Author="Eric Gebhart"><Data><B xmlns="http://www.w3.org/TR/REC-html40"><Font
             html:Size="12.0" html:Color="#000000">Eric Gebhart:</Font></B>
            <Font html:Size="12.0" html:Color="#000000"
             xmlns="http://www.w3.org/TR/REC-html40">&#10;This is a test</Font></Data></Comment></Cell>
        */
        /*
        <B xmlns="http://www.w3.org/TR/REC-html40"><U>
<Font html:Face="American Typewriter" html:Color="#000000">age
        </Font></U></B>
        */
        define event span;
            start:
            do /if any(foreground, font_face);
                put "<Font";
                putq " html:Color=" foreground;
                putq " html:Face=" font_face;
                put ' xmlns="http://www.w3.org/TR/REC-html40">';
                set $spanfont "True";
            done;
            do /if cmp(font_weight, 'bold');
                put '<B xmlns="http://www.w3.org/TR/REC-html40">';
                set $spanbold "True";
            done;
            do /if cmp(text_decoration, 'underline');
                put '<U xmlns="http://www.w3.org/TR/REC-html40">';
                set $spanunderline "True";
            done;

            put value;
            
            finish:
            do /if $spanunderline;
                put '</U>';
            done;
            do /if $spanbold;
                put '</B>';
            done;
            do /if $spanfont;
                put "</Font>";
            done;
            unset $spanfont;
            unset $spanbold;
            unset $spanunderline;
    end;

    define event comment;
        break /if ^$flyover;
        put '<Comment><Data><Font html:Size="12.0" html:Color="#000000"';
        put ' xmlns="http://www.w3.org/TR/REC-html40">';
        put $flyover;
        put '</Font></Data></Comment>';
        unset $flyover;
    end;


    /*-----------------------------------------------------------eric-*/
    /*-- Write out a style definition for style over-rides.         --*/
    /*-- It just keeps counting and writing because it has          --*/
    /*-- no way of knowing if they are the same or not.             --*/
    /*--                                                            --*/
    /*-- We could know that.  But the expense isn't worth it.       --*/
    /*-- If the number of styles becomes oppressive, the better     --*/
    /*-- answer is to create an ods style that defines style        --*/
    /*-- elements that can be defined once and used many times.     --*/
    /*--------------------------------------------------------19Aug03-*/
    define event style_over_ride;
            /*---------------------------------------------------eric-*/
            /*-- Nothing to do if this isn't set.                   --*/
            /*------------------------------------------------19Aug03-*/
            break /if ^$style_over_ride;
                set $style_overides['__foo__'] 'foo' /if ^$style_overrides;

                unset $key;
                set $key $cell_class $format_override;
                set $key $key "ff" font_face "s" font_size "st" font_style "w" font_weight;
                set $key $key "c" foreground "b" background "bw" borderwidth "bc" bordercolor "bs" borderstyle;
                set $key $key "btw" bordertopwidth "btc" bordertopcolor "bts" bordertopstyle;
                set $key $key "bbw" borderbottomwidth "bbc" borderbottomcolor "bbs" borderbottomstyle;
                set $key $key "brw" borderrightwidth "brc" borderrightcolor "brs" borderrightstyle;
                set $key $key "blw" borderleftwidth "blc" borderleftcolor "bls" borderleftstyle;
                set $key $key "td" text_decoration;
                do /if $debug_level = -9;
                    putlog "Style Over Ride: " $key;
                    putlog  "CELL CLASS" $cell_class;
                    putlog  "STYLE OVERIDE " $style_overrides[$key];
                done;
                do /if ^$style_override_count;
                    eval $style_override_count 0;
                done;


                /*---------------------------------------------------eric-*/
                /*-- If we haven't done an over-ride for this style name     --*/
                /*-- before...                                          --*/
                do /if ^$style_overrides[$key] ;

                    set $cell_class lowcase(htmlclass);

                    do /if contains($cell_class, "ata") |
                        contains($cell_class, "eader");  /* Header */
                        set $cell_class $cell_class '__' just /if ^$styles_with_just[$cell_class];
                    done;
                    do /if $style_list[$cell_class];

                        set $cell_class $cell_class "_";
                        eval $style_list[$cell_class] $style_list[$cell_class] + 1;

                    else;
                        eval $style_list[$cell_class] 1;
                    done;
                    
                    do /if cmp($cell_class, "unknown");
                        set $just just;
                        set $vjust vjust;
                    done;

                    set $cell_class $cell_class $style_list[$cell_class];

                    /* set $cell_class $cell_class $style_override_count; */
                    set $style_overrides[$key] $cell_class;
                    set $style_over_ride "true";
                    unset $$style_elements;
                    trigger xl_style_elements;
                else;
                    set $cell_class $style_overrides[$key] ;
                    unset $$style_elements;
                    unset $style_over_ride;
                done;

                do /if $debug_level = -9;
                    putlog  "CELL CLASS " $cell_class;
                    putlog  "PARENT CLASS " $parent_class;
                done;

            /*---------------------------------------------------eric-*/
            /*-- Ok, it's a new style definition.                   --*/
            /*-- Lets write it out.                                 --*/
            /*------------------------------------------------19Aug03-*/
                flush;
            do /if $style_over_ride;
                open style;
                put '<Style ss:ID="' $cell_class '"';
                putq ' ss:Parent=' $parent_class '>' NL;

                put $$style_elements;
                unset $$style_elements;

                trigger cell_format;

                putl '</Style>';
                close;

                open worksheet;
            done;
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- based on the format, we need to possibly create a          --*/
    /*-- style and keep track of it.  We only have 3 formats.       --*/
    /*-- General, Currency, and percentage.  Two types.             --*/
    /*-- numeric and string.  If's string then it's always          --*/
    /*-- General.                                                   --*/
    /*--------------------------------------------------------18Aug03-*/
    define event resolve_cell_format;
        set $parent_class $cell_class /if ^cmp($cell_class, "unknown");

        do /if $format_override;
            set $cell_class $cell_class "_m";
            set $key $parent_class $format_override;
            set $key $key "ff" font_face "s" font_size "st" font_style "w" font_weight;
            set $key $key "c" foreground "b" background "bw" borderwidth "bc" bordercolor;
            do /if ^$manual_format_styles[$key] ;
                eval $format_override_count $format_override_count+1;
                set $manual_format_styles[$key] $format_override_count ;
                set $cell_class $cell_class $format_override_count '_';
            else;
                set $cell_class $cell_class $manual_format_styles[$key] '_';
            done;

            set $style_over_ride "true";
        else;
            /*---------------------------------------------------eric-*/
            /*-- It's currency.                                     --*/
            /*------------------------------------------------18Aug03-*/
            do /if cmp($format, $currency_format);
                set $cell_class $cell_class "_currency";
                do /if !$currency_styles[$parent_class];
                    set $currency_styles[$parent_class] $cell_class ;
                done;
                set $style_over_ride "true";

            /*---------------------------------------------------eric-*/
            /*-- It's a percentage format.                          --*/
            /*------------------------------------------------18Aug03-*/
            else /if cmp($format, "Percent");
                set $cell_class $cell_class "_percent";
                do /if ^$percentage_styles[$parent_class];
                    set $percentage_styles[$parent_class] $cell_class ;
                done;
                set $style_over_ride "true";
            done;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- write out the style definition.                        --*/
        /*----------------------------------------------------18Aug03-*/
        /*delstream style_elements;*/
        trigger style_over_ride;
        unset $parent_class;
    end;


    define event cell_and_value;

        break /if ^any(value, $empty);
        /*-------------------------------------------------------eric-*/
        /*-- The cell tag hasn't finished up yet.                   --*/
        /*----------------------------------------------------18Aug03-*/
        trigger data_formula;


        do /if $debug_level=-5;
            putlog "CELL_AND_VALUE";
            putlog "cell_class" ": " $cell_class;
            putlog "cell_tag" ": " $cell_tag;
        done;

        do /if ^$cell_tag;
            /*-------------------------------------------------------eric-*/
            /*-- Figure out if it's a string or number and if it's      --*/
            /*-- general, currency, or percentage.                      --*/
            /*----------------------------------------------------18Aug03-*/
            trigger value_type;
            do /if $formula_value;
                set $type "Number";
            done;

            /*---------------------------------------------------eric-*/
            /*-- This is so missing values will be right justified. --*/
            /*------------------------------------------------23Aug05-*/
            set $low_class lowcase($cell_class);
            do /if contains($low_class, 'data');
                set $tmp strip($value);
                do /if missing & ^cmp($type, "Number");
                    set $type "String";
                    set $cell_class $datamissing_style_name "_" $missing_align;
                else /if cmp($tmp, '.');
                    set $type "String";
                    set $cell_class $datamissing_style_name "_" $missing_align;
                done;
                unset $tmp;
            done;

            do /if $debug_level=-5;
                putlog "Doing Cell_tag";
                putlog "cell_class" ": " $cell_class;
            done;

            Set $cell_class "unknown" /if ^$cell_class;

            /*-------------------------------------------------------eric-*/
            /*-- get a style created or used, close up the beginning of --*/
            /*-- the cell tag.                                          --*/
            /*----------------------------------------------------18Aug03-*/
            trigger resolve_cell_format;

            do /if $debug_level=-5;
                putlog "resolved cell format";
                putlog "cell_class" ": " $cell_class;
            done;

            open row;

            /*---------------------------------------------------eric-*/
            /*-- Finish off the opening Cell tag.                   --*/
            /*------------------------------------------------19Aug03-*/
            trigger cell_start finish;

            /*open worksheet;*/
        done;

        /*-------------------------------------------------------eric-*/
        /*-- print the value.                                       --*/
        /*----------------------------------------------------18Aug03-*/
        unset $value /if $formula_value;
        trigger value_put;
    end;

    define event data_formula;
        /*-------------------------------------------------------eric-*/
        /*-- If the data value starts with an = make it a formula.  --*/
        /*----------------------------------------------------19Apr05-*/
        unset $formula_value;
        do /if $formulas;
            set $value strip(VALUE);
            do /if substr($value, 1,1) = '=';
                do /if $debug_level = -5;
                    putlog "FORMULA VALUE:";
                    putlog "$VALUE " $value;
                done;
                set $attrs['formula'] $value;
                unset $value;
                set $formula_value "true";
            done;
        done;
    end;

    define event tagattr_settings;

        unset $attrs;

        /*
        trigger data_formula;
        */

        break /if ^tagattr;
        /*break /if cmp(section, 'head');*/

        /*-------------------------------------------------------eric-*/
        /*-- If there is a : then we need to parse for format       --*/
        /*-- and/or formula.  To add new attributes change the      --*/
        /*-- tagattr_regexp above.                                  --*/
        /*----------------------------------------------------17Dec04-*/

        do /if index(tagattr, ":") > 0;

            eval $index 1;
            /* get the first section to look at */
            eval $tmp lowcase(scan(tagattr, $index, ' '));

            do /while !cmp($tmp, ' ');

                /* look for an attribute */
                do /if prxmatch($tagattr_regex, $tmp);

                    /* get the attribute name */
                    set $attr scan($tmp, 1, ':');
                    /* get what is left */
                    eval $len index($tmp, ':')+1;
                    eval $tmp2 substr($tmp, $len);
                    eval $attrs[$attr] strip(scan($tmp2, 1, " "));

                else;
                    /* it didn't start with a name so add it on */
                    set $attrs[$attr] $attrs[$attr] ' ' $tmp;
                done;

                eval $index $index + 1;
                /* get the next section */
                set $tmp scan(tagattr, $index, ' ');
            done;

            do /if $attrs['format'];
                set $attrs['format'] '@' /if cmp($attrs['format'], 'text');
            done;
        else;
            do /if cmp(tagattr, 'text');
                set $attrs['format'] '@' /if cmp(tagattr, 'text');
            else;
                set $attrs['format'] tranwrd(tagattr, '"', '&quot;');
            done;
        done;

        do /if ^$attrs['type'];
            set $attrs['type'] 'String' /if cmp($attrs['format'], '@');
        done;

        set $attrs['type'] propcase($attrs['type']) /if $attrs['type'];

        do /if $debug_level = -5;
            putlog "Tag Attrs";
            iterate $attrs;
            do /while _name_;
                putlog _name_ " : " _value_;
                next $attrs;
            done;
        done;

    end;

    define event calculate_cellwidth;
        break /if ^cellwidth;

        do /if $debug_level >= 4;
            putlog "Calculate CellWidth" ": " cellwidth;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- For Proc Report.  The colspecs come after the table    --*/
        /*-- head,  So trying to calculate widths doesn't work      --*/
        /*-- until after the colspecs come along, and the worksheet --*/
        /*-- widths array is populated.   The colspecs are          --*/
        /*-- calculated as the headers are generated, so that's     --*/
        /*-- when this comes into play, As the headers are coming   --*/
        /*-- in.                                                    --*/
        /*----------------------------------------------------1Aug 05-*/
        break /if ^$worksheet_widths;*/

        /*-------------------------------------------------------eric-*/
        /*-- Figure out which columns the cell is in.               --*/
        /*-- If more than one, divide the width equally.            --*/
        /*----------------------------------------------------22Apr05-*/
        set $index colstart;

        eval $index inputn(colstart, "BEST");
        do /if colend;
            eval $end inputn(colend, "BEST");
        else;
            eval $end inputn(colstart, "BEST");
        done;

        do /if $debug_level >= 3;
            putlog "EVAL INDEX: Calculate CellWidth;  Cell Index" ": " $index " Colstart" ":" colstart;
            putlog "EVAL END: Calculate CellWidth Cell End" ": " $end  " ColEnd" ":" colend;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- Bail if we've already done this column.  This could    --*/
        /*-- cause problems, if there is multi-table worksheets and --*/
        /*-- more than one table tries to set the same column.      --*/
        /*-- The first one will win.                                --*/
        /*-- The benefit is that this code doesn't                  --*/
        /*-- happen for every single cell.                          --*/
        /*-- Just once per column per worksheet.                    --*/
        /*----------------------------------------------------25Apr05-*/
        break /if cmp($cellwidths[$index], "set");

        do /if $end ^= $index;
            eval $columns  $end - $index;
            eval $points $points / $columns;
        done;

        set $cellwidths[] "unset" /if ^$cellwidths;
        do /if $debug_level >= 3;
            putlog "Calculate CellWidth;" "Cellwidths" " :" $cellwidths " Worksheet Widths" ":" $worksheet_widths;
        done;

        do / if ^$worksheet_widths;
            eval $tmp_counter 0;
        else;
            eval $tmp_counter $worksheet_widths;
        done;

        do /while $cellwidths < $tmp_counter;
            set $cellwidths[] "unset";
        done;

        eval $count 1;
        do /while $count <= $tmp_counter;
            do /if $count >= $index and $count <= $end;
                set $cellwidths[$count] "set";
            done;
            eval $count $count + 1;
        done;

        set $convert_this_size cellwidth;
        trigger convert_to_points;
        eval $col_points $converted_this_size;

        /*-------------------------------------------------------eric-*/
        /*-- Cellwidth always wins.  If someone wants a specific    --*/
        /*-- width they should get it.                              --*/
        /*----------------------------------------------------22Apr05-*/
        do /while $index <= $end;
            set $worksheet_widths[$index] $col_points;
            eval $index $index + 1;
        done;

        do /if $debug_level >= 3;
            putlog "END: " $end;
            putlog "COL POINTS: " $col_points;
            iterate $worksheet_widths;
            do /while _value_;
                putlog "Worksheet_widths" ": " _value_;
                next $worksheet_widths;
            done;
        done;

        unset $col_points;
        unset $cm;
        unset $index;
        unset $count;
    end;

    define event convert_to_points;

        /* $convert_this_size is the variable to populate...  */
        /* wish I had a stack.                                */
        /* The answer will be in $converted_this_size         */

        eval $converted_this_size 0;

        do /if $debug_level >= 2;
            putlog "=======================================================";
            putlog "Event: Convert_to_points;" "Convert_this_size:" $convert_this_size;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- convert centimeters to points                          --*/
        /*----------------------------------------------------26Apr05-*/
        do /if prxmatch($cm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'cm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size * 28.3;

        /*-------------------------------------------------------eric-*/
        /*-- convert millimeters to points                          --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($mm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'mm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size * 2.83;

        /*-------------------------------------------------------eric-*/
        /*-- convert inches to points                               --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($in_re, $convert_this_size);
            eval $unit index($convert_this_size, 'in')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size * 72;

        /*---------------------------------------------------eric-*/
        /*-- Convert pixels to points.  100 dpi sounds good.    --*/
        /*-- That's .72 pixels per point.                       --*/
        /*------------------------------------------------26Apr05-*/
        else /if prxmatch($px_re, $convert_this_size);
            eval $unit index($convert_this_size, 'px')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size * .72;

        /*-------------------------------------------------------eric-*/
        /*-- Convert points with units to points.                   --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($pt_re, $convert_this_size);
            eval $unit index($convert_this_size, 'pt')-1;
            eval $converted_this_size inputn(substr($convert_this_size, 1, $unit), 'BEST');

        else;
            eval $converted_this_size inputn($convert_this_size, 'BEST');
        done;
        unset $unit;

        do /if $debug_level >= 2;
            putlog "Event: Convert_to_points;" "Converted_this_size:" $converted_this_size;
            putlog "=======================================================";
        done;
    end;

    define event convert_to_inches;

        /* $convert_this_size is the variable to populate...  */
        /* wish I had a stack.                                */
        /* The answer will be in $converted_this_size         */

        eval $converted_this_size 0;

        do /if $debug_level >= 2;
            putlog "=======================================================";
            putlog "Event: Convert_to_inches;" "Convert_this_size:" $convert_this_size;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- convert centimeters to inches                          --*/
        /*----------------------------------------------------26Apr05-*/
        do /if prxmatch($cm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'cm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size / 2.54;

        /*-------------------------------------------------------eric-*/
        /*-- convert millimeters to inches                          --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($mm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'mm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size / 25.4;

        /*-------------------------------------------------------eric-*/
        /*-- convert points to inches                               --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($pt_re, $convert_this_size);
            eval $unit index($convert_this_size, 'pt')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size / 72;

        /*---------------------------------------------------eric-*/
        /*-- Convert pixels to inches.  100 dpi sounds good.    --*/
        /*------------------------------------------------26Apr05-*/
        else /if prxmatch($px_re, $convert_this_size);
            eval $unit index($convert_this_size, 'px')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size * .01 ;

        /*-------------------------------------------------------eric-*/
        /*-- Convert inches with units to inches.                   --*/
        /*----------------------------------------------------26Apr05-*/
        else;
            eval $unit index($convert_this_size, 'in')-1;
            eval $converted_this_size inputn(substr($convert_this_size, 1, $unit), 'BEST');
        done;
        unset $unit;

        do /if $debug_level >= 2;
            putlog "Event: Convert_to_inches;" "Converted_this_size:" $converted_this_size;
            putlog "=======================================================";
        done;
    end;

    define event convert_to_scale;

        /* $convert_this_size is the variable to populate...  */
        /* wish I had a stack.                                */
        /* The answer will be in $converted_this_size         */

        eval $converted_this_size 0;

        do /if $debug_level >= 2;
            putlog "=======================================================";
            putlog "Event: Convert_to_scale;" "Convert_this_size:" $convert_this_size;
        done;

        /*-------------------------------------------------------eric-*/
        /*-- convert centimeters to points                          --*/
        /*----------------------------------------------------26Apr05-*/
        do /if prxmatch($cm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'cm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size;

        /*-------------------------------------------------------eric-*/
        /*-- convert millimeters to points                          --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($mm_re, $convert_this_size);
            eval $unit index($convert_this_size, 'mm')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size;

        /*-------------------------------------------------------eric-*/
        /*-- convert inches to points                               --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($in_re, $convert_this_size);
            eval $unit index($convert_this_size, 'in')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size;

        /*---------------------------------------------------eric-*/
        /*-- Convert pixels to points.  100 dpi sounds good.    --*/
        /*-- That's .72 pixels per point.                       --*/
        /*------------------------------------------------26Apr05-*/
        else /if prxmatch($px_re, $convert_this_size);
            eval $unit index($convert_this_size, 'px')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size;

        /*-------------------------------------------------------eric-*/
        /*-- Convert points with units to points.                   --*/
        /*----------------------------------------------------26Apr05-*/
        else /if prxmatch($pt_re, $convert_this_size);
            eval $unit index($convert_this_size, 'pt')-1;
            eval $size inputn(substr($convert_this_size, 1, $unit), 'BEST');
            eval $converted_this_size $size;
        else;
            eval $converted_this_size inputn($convert_this_size, 'BEST');
        done;
        unset $unit;

        eval $converted_this_size round($converted_this_size, 1);

        do /if $debug_level >= 2;
            putlog "Event: Convert_to_scale;" "Converted_this_size:" $converted_this_size;
            putlog "=======================================================";
        done;
    end;

    define event calculate_rowheight;

        break /if ^cmp(event_name, 'header');

        break /if ^value;

        /*-------------------------------------------------------eric-*/
        /*-- Count the breaks.  each one is one line...             --*/
        /*----------------------------------------------------23Sep05-*/
        do /if $debug_level = -2;
            putlog "CALCULATE ROWHEIGHT=================================";
        done;

        eval $tmp_row_height 1;

        do /if index(value, split);
            eval $count 2;
            eval $foo scan(value, 2, split);
            do /while !cmp($foo, ' ');
                eval $foo scan(value, $count, split);
                eval $count $count+1;
                eval $tmp_row_height $tmp_row_height+1;
            done;
        else;

            do /if $tmp_row_height = 0;
                eval $tmp_row_height 1;
            done;

            do /if $debug_level = -2;
                putlog "VALUE" ":" value " " " : "  $tmp_row_height;
            done;

            /*-------------------------------------------------------eric-*/
            /*-- Get the length, accommodating line breaks..            --*/
            /*----------------------------------------------------23Sep05-*/
            trigger calculate_header_len;

            eval $width $header_len;

            eval $index inputn(colstart, "BEST");
            do /if colend;
                eval $end inputn(colend, "BEST");
            else;
                eval $end inputn(colstart, "BEST");
            done;

            do /if $widthPoints;
                eval $points $widthPoints;
            else;
                eval $points max(inputn($header_point_size, '3.'), inputn($data_point_size, '3.'));
            done;

            do /if ^$points;
                eval $points 12;
            done;

            do /if cmp(section, 'head');
                set $tmp $row_heights['Table_head'];
            else;
                set $tmp $row_heights['Table'];
            done;
            set $tmp '15' /if cmp($tmp, '0');

            /*-------------------------------------------------------eric-*/
            /*-- If the text is longer than the available width add the --*/
            /*-- appropriate number of lines that it will take.         --*/
            /*----------------------------------------------------23Sep05-*/
            eval $avail_width 0;
            do /while $index <= $end;
                do /if $worksheet_widths;
                    do /if $worksheet_widths >= $index;
                        set $tmp_width $worksheet_widths[$index];
                        eval $avail_width $avail_width + (inputn($tmp_width, 'BEST') / $widthfudge);
                    else;
                        eval $avail_width $header_len * $points ;
                    done;
                else;
                    eval $avail_width $header_len * $points ;
                done;
                eval $index $index + 1;
            done;

            /*-------------------------------------------------------eric-*/
            /*-- All we really want is how many rows this string might  --*/
            /*-- take up.  So how many times does the available width   --*/
            /*-- go into the length of the string we have.              --*/
            /*----------------------------------------------------23Sep05-*/
            do /if $debug_level = -2;
                eval $tmpwidth $width * $points * $widthfudge;
                putlog "WIDTHS " ":" $width " " " : "  $avail_width " " " : " $end;
            done;

            unset $rotation;
            do /if $width;
                do /if $debug_level = -2;
                    putlog $attrs['rotate'];
                    iterate $attrs;
                    do /while _name_;
                        putlog _name_ ":" _value_ ;
                        next $attrs;
                    done;
                done;
                /*-----------------------------------------------eric-*/
                /*-- If the text is rotated, it's not as long...    --*/
                /*--------------------------------------------19Oct06-*/
                do /if $attrs;
                    do /if $attrs['rotate'];
                        set $rotation $attrs['rotate'];
                        eval $rotation inputn($rotation, 'BEST');
                        eval $width $width * cos($rotation);
                        eval $tmp_row_height $width * sin($rotation);
                        do /if $debug_level = -2;
                            putlog "Rotation & width, height: " $rotation ":" $width ":" $tmp_row_height;
                        done;
                    done;
                done;

                eval $width_over_run  $width * $points * $widthfudge;
                stop /if $width_over_run < $avail_width;

                putlog "WIDTH & avail: " $width_over_run ":" $avail_width /if $debug_level = -2;

                eval $width_over_run  $width_over_run - $avail_width;
                putlog "OVER_RUN: " $width_over_run ":" $avail_width /if $debug_level = -2;

                eval $width_over_run  $width_over_run / $avail_width;
                putlog "DIV_OVER_RUN: " $width_over_run ":" $avail_width /if $debug_level = -2;

                do /if ^$rotation;
                    eval $ceil ceil($width_over_run);
                    eval $tmp_row_height $tmp_row_height + ceil($width_over_run) ;
                done;
            done;

            /*
            do /if $attrs;
                do /if $attrs['rotate'];
                    set $rotation $attrs['rotate'];
                    eval $rotation inputn($rotation, 'BEST');
                    eval $tmp_row_height $width * sin($rotation);
                    putlog "Rotation & height: " $rotation ":" $tmp_row_height /if $debug_level = -2;
                done;
            done;
            */
            /*---------------------------------------------------eric-*/
            /*-- If the row is already tall, and the text will fit, --*/
            /*-- don't grow it.                                     --*/
            /*------------------------------------------------19Oct06-*/
            do /if exists($Points, $tmp_row_height);
                eval $tmp inputn($tmp, 'BEST');
                eval $point_height $tmp_row_height * $points;
                do /if $tmp > $point_height;
                    eval $tmp_row_height 0;
                done;
            done;
            /*
            do /if exists($Points, $tmp_row_height);
                eval $tmp_row_height $Points * $tmp_row_height;
            else;
                eval $tmp_row_height $Points;
            done;
            */
        done;

        eval $this_row_height max($this_row_height, $tmp_row_height);

        do /if $debug_level = -2;
            putlog "THIS ROW HEIGHT " ":" $this_row_height " : " $tmp_row_height;
            putlog "=============================================";
        done;

    end;

    define event data;
        start:
            /*---------------------------------------------------eric-*/
            /*-- This is a real hack.  Proc Report doesn't give     --*/
            /*-- header events when it should.  Only data events.   --*/
            /*-- When Proc report starts behaving properly this     --*/
            /*-- can go away.                                       --*/
            /*------------------------------------------------23Aug05-*/
            set $flyover flyover;
            do /if cmp(section, 'body');
                do /if $debug_level > 0;
                    putlog "event name" ": " event_name ": " $proc_name ": " htmlclass ": " $rowheader_count;
                done;
                do /if cmp(event_name, 'header');
                    eval $rowheader_count $rowheader_count + 1;
                else /if cmp(proc_name, 'Report');
                    do /if contains(htmlclass, 'eader');
                        eval $rowheader_count $rowheader_count + 1;
                    done;
                else /if cmp(proc_name, 'Tabulate');
                    do /if contains(htmlclass, 'eader');
                        eval $rowheader_count $rowheader_count + 1;
                    done;
                done;
            done;


            done;
            trigger calculate_cellwidth;
            trigger tagattr_settings;

            trigger calculate_rowheight;

            unset $format_override;
            do /if cmp(section, 'body');
                do /if ^$first_data_column & cmp(event_name, 'data');
                    /*do /if ^contains(htmlclass, "eader"); */
                    /*putlog "FIRST_DATA_COLUMN: " ":" colstart " Class" ":" htmlclass " Event " ":" event_name;*/
                    eval $first_data_column inputn(colstart, 'BEST') ;
                done;
            done;
            /*---------------------------------------------------eric-*/
            /*-- Save away the beginning of the cell, and the style --*/
            /*-- over-rides.                                        --*/
            /*------------------------------------------------19Aug03-*/
            trigger cell_start start;

            /*---------------------------------------------------eric-*/
            /*-- if we have a value, figure out what format to use, --*/
            /*-- write out the style definition for the over-ride,  --*/
            /*-- if we need to.  write out the value.               --*/
            /*------------------------------------------------19Aug03-*/
            trigger cell_and_value /if value;

            set $in_a_cell "true";

        finish:
            /*---------------------------------------------------eric-*/
            /*-- If it was actually an empty cell and not a         --*/
            /*-- put_value event from proc report we need to        --*/
            /*-- print the Data tag now.                            --*/
            /*------------------------------------------------25Jul03-*/
            do /if !$value_put;
                set $empty "true";
                trigger cell_and_value ;
                unset $empty;
            done;
            unset $value_put;
            unset $in_a_cell;

            open row;

            put '</Data>';

            putl '</Cell>';


            /*open worksheet;*/

    end;

    /*-----------------------------------------------------------eric-*/
    /*-- We only have to do this because procs report, tabulate     --*/
    /*-- and freq don't give the type of the variable.              --*/
    /*-- And even if they did we can only use them as a guideline.  --*/
    /*--                                                            --*/
    /*-- Excel can't handle something like >.001 as a number.  Nor  --*/
    /*-- can it handle percents.  Although once they are loaded it  --*/
    /*-- recognizes them.  inputn works pretty well be we do have   --*/
    /*-- numeric data with spaces in them.  Which are technically   --*/
    /*-- non numeric.                                               --*/
    /*--------------------------------------------------------28Jul03-*/
    define event value_type;

        set $format "General";
        set $value strip(VALUE);

        do /if $value;
            eval $is_numeric prxmatch($number, $value);
            do /if $is_numeric;

                set $type "Number";
                set $value compress($value, $punctuation);

                do /if index(value, "%") > 0;
                    set $format "Percent" /if index(value, "%") > 0;
                    /*putlog "Percent value:" $value;*/
                    do /if $convert_percentages;
                        eval $tmp inputn($value, $test_format)/100;
                    else;
                        eval $tmp inputn($value, $test_format);
                    done;
                    /*putlog "Percent value:" $tmp;*/
                    set $value $tmp;

                else /if index(value, $currency) > 0;
                    set $format $currency_format /if index(value, $currency) > 0;
                done;

            else;
                set $type 'String';
            done;
        done;

        /*putlog "TYPE!! " $attrs['type'] ":" ":" $type ":" ";" type;*/

        do /if $attrs['type'];
            set $type $attrs['type'];

            set  $type "DateTime" / if cmp($type, 'Datetime');

        else /if ^cmp($type, "Number");

            /* default to string for empty values*/
            set  $type "String" ;

            /* only allow actual numbers to pay attention to this */
            do /if $is_numeric;
                set  $type "Number" / if cmp(type, 'int');
                set  $type "Number" / if cmp(type, 'double');
                set  $type "String" / if cmp(type, 'string');
            done;
        done;

    end;


    define event value_put;

        open row;

            do /if !$value_put;
                do /if cmp(event_name, 'header');
                    trigger value_type;
                    set $tmp_val strip(value);
                    set $type "String" /if ^$tmp_val;
                    unset $tmp_val;
                done;
                putq  '<Data ';
                do /if $value;
                    putq  'ss:Type=' $type ;
                else;
                    putq  'ss:Type="String"'  ;
                done;
                put '>';
                set $value_put "true";
                unset  $type;
            done;

            put $value;

            unset $value;

            /*open worksheet;*/
    end;

    /*-----------------------------------------------------------eric-*/
    /*-- These events are to work around the tables that don't      --*/
    /*-- provide colspecs up front.  procs report, tabulate and     --*/
    /*-- freq with crosstabs.                                       --*/
    /*--------------------------------------------------------28Jul03-*/


    /*-----------------------------------------------------------eric-*/
    /*-- if we are in the head section we want rows and cells to go --*/
    /*-- into the table_headers stream.  What a pain.               --*/
    /*--------------------------------------------------------19Aug03-*/
    define event worksheet_or_head;
        do /if $is_a_table_head;
            open table_headers ;
        else;
            open worksheet;
        done;
    end;

    define event rowspec;
        start:
            break /if $is_a_table_head;
            open table_headers;
    end;

    define event table_head;
        start:
            do /if $debug_level > 2;
                putlog "TABLE HEAD" ": " $worksheet_row;
            done;
            do /if ^$colspecs_are_done;
                set $is_a_table_head "true";
                open table_headers;
            done;
        finish:
            do /if $colspecs_are_done;
                unset $colspecs_are_done;
                break;
            done;
            unset $is_a_table_head;
            close;

    end;

    /* just in case */
    define event table_body;
        do /if ^$possible_row_repeat_start;
            do /if $row_count > 1;
                eval $possible_row_repeat_start $worksheet_row - ($row_count - 1);
                eval $possible_row_repeat_end   $worksheet_row;
            else;
                eval $possible_row_repeat_start $worksheet_row;
            done;
        done;

        do /if $$table_headers;

            do /if $titles_are_done;
                unset $titles_are_done;
            else;
                trigger embedded_title;
                trigger do_byline;
            done;

            put $$table_headers;
            unset $$table_headers;
        done;
        do /if $table_count = $autofilter_table;
            do /if ^$autofilter_row;
                eval $autofilter_row $worksheet_row;
            done;
        done;
        unset $is_a_table_head;
        eval $data_row_count 0;
    end;

    define event colspecs;
        start:
            trigger worksheet_or_head;
            unset $table_widths;
        finish:
            eval $colcount $colcount-1;
            set $colspecs_are_done "true";

            trigger embedded_title;
            trigger do_byline;

            put $$table_headers;
            unset $$table_headers;
            set $titles_are_done 'true';


            /*---------------------------------------------------eric-*/
            /*-- move the table column widths into the worksheet    --*/
            /*-- column widths.  The biggest width for a column     --*/
            /*-- wins.                                              --*/
            /*------------------------------------------------17Dec04-*/
            do /if $debug_level >=3;
                putlog "Colspecs Finish;  Table Widths" ": " $table_widths;
            done;

            eval $count 1;
            do /while $table_widths;
                do /if $worksheet_widths[$count];
                    unset $width;
                    eval $width inputn($worksheet_widths[$count], 'Best');
                    do /if $table_widths[1];
                        do /if missing($width);
                            set $worksheet_widths[$count] $table_widths[1];
                        else /if inputn($table_widths[1], 'Best') > $width;
                            set $worksheet_widths[$count] $table_widths[1];
                        done;
                    done;
                else;
                    set $worksheet_widths[] $table_widths[1];
                done;
                unset $table_widths[1];
                eval $count $count + 1;
            done;
    end;

    define event header;
        start:
            /*---------------------------------------------------eric-*/
            /*-- Bring this back when the corresponding code in the --*/
            /*-- data event can be removed...                       --*/
            /*------------------------------------------------23Aug05-*/
            /*
            do /if cmp(section, 'body');
                eval $rowheader_count $rowheader_count + 1;
            done;
            */
            trigger data;
        finish:
            trigger data;
    end;

    define event embedded_title;
        break /if ^$embedded_titles;
        break /if ^$titles;

        do /if cmp($sheet_interval, "bygroup");
           do /if $one_embedded_title_set;
               unset $titles /breakif $worksheet_has_titles;
               set $worksheet_has_titles "True";
           done;
        done;

        do /if ^$worksheet_row;
            eval $worksheet_row 0;
        done;

        eval $count 1;
        set $height $row_heights['Title'];
        do /while $count <= $titles ;
            eval $worksheet_row $worksheet_row + 1;
            set $url $title_urls[$count];
            set $span_cell_style $title_styles[$count];
            unset $merge;
            set $merge "True" /if cmp($align, 'center');
            set $span_cell_value $titles[$count];
            trigger span_cell start;
            trigger span_cell finish;
            eval $count $count+1;
        done;

        /* a blank row for padding. */
        unset $span_cell_style;
        unset $titles;
        unset $title_urls;
        unset $height;
        /* A blank line after the titles?  Perhaps... */
        set $skip_multiplier $skip_factor['Title'] ;
        trigger parskip;
    end;

    define event span_cell_style_just;
        do /if ^$styles_with_just[$span_cell_style];
            set $span_cell_style $span_cell_style "__" ;
            set $span_cell_style $span_cell_style substr($align, 1,1);
        done;
    end;

    define event embedded_footnotes;
        break /if ^$embedded_footnotes;
        break /if ^$footers;
        /* a blank row for padding.  Opposite logic than worksheet end. */
        do /if cmp($sheet_interval, 'Table');
            set $skip_multiplier $skip_factor['Table'] ;
            trigger parskip;
        done;

        do /if ^$worksheet_row;
            eval $worksheet_row 0;
        done;

        eval $count 1;
        set $height $row_heights['Footer'];
        do /while $count <= $footers ;
            set $url $footer_urls[$count];
            set $span_cell_style $footer_styles[$count];
            eval $worksheet_row $worksheet_row + 1;
            unset $merge;
            set $span_cell_value $footers[$count];
            trigger span_cell start;
            trigger span_cell finish;
            eval $count $count+1;
        done;
        unset $height;
        /* A blank line after the footers?  Perhaps... */
        set $skip_multiplier $skip_factor['Footer'];
        trigger parskip;
        unset $footers;
    end;

    define event span_cell;
        start:
            /*---------------------------------------------------eric-*/
            /*-- defeat the non merging of left justified titles etc...--*/
            /*------------------------------------------------5Jan 07-*/
            set $merge "True";
            putq '<Row';
            putq ' ss:Height=' $height;
            do /if $debug_level = -1;
                putq ' ss:Index=' $worksheet_row;
            done;
            do /if $merge;
                putq  ' ss:StyleID=' $body_class;
            else;
                putq ' ss:StyleID=' lowcase($span_cell_style);
            done;
            put '>';
            do /if $span_cell_value;
                put  '<Cell';
                do /if $merge;
                    putq ' ss:StyleID=' lowcase($span_cell_style);
                    putq ' ss:MergeAcross=' $colcount;
                done;
                putq ' ss:HRef=' $url /if ^cmp($url, "$$$$$");
                put ">";
                putq '<Data ss:Type="String"';
                put '>';
            done;
            unset $url;
            put $span_cell_value;
        finish:
            do /if $span_cell_value;
                put '</Data>';
                put '</Cell>';
            done;
            unset $span_cell_value;
            put '</Row>' nl;
    end;

    define event hyperlink;
        trigger put_value;
    end;

    /*
    define event breakline;
        break /if $in_data_note;
        put "&#13;";
    end;
    */

    define event put_value;
        trigger do_data_note /breakif $in_data_note;
        do /if $in_a_cell;
            trigger cell_and_value /if value;
        else;
            put strip(VALUE);
        done;
    end;

    define event put_value_cr;
        do /if $in_a_cell;
            trigger cell_and_value /if value;
        else;
            put strip(VALUE) nl;
        done;
    end;

    /*-------------------------------------------------------------eric-*/
    /*-- This is a bit painful.  We want to have all of our titles    --*/
    /*-- and footnotes but the xml only allows for one header tag     --*/
    /*-- and one footer tag.  So we're putting all the titles in      --*/
    /*-- the one tag with a newline between them.  excel seems to     --*/
    /*-- know what to do with it so I guess this is ok.               --*/
    /*----------------------------------------------------------2Jul 03-*/
    define event page_setup;
        start:
            unset $$page_setup;
            unset $titles;
            unset $title_urls;
            unset $footers;
            unset $footer_urls;
            open page_setup;


        finish:
            close;

            /* reopen the worksheet stream */
            open worksheet;

            /* possibly close an open worksheet */
            trigger worksheet finish /if cmp($sheet_interval, "table");
            trigger worksheet finish /if cmp($sheet_interval, "page");
            /* start a new worksheet */
            trigger worksheet start /if cmp($sheet_interval, "page");
            /* It might be the first time and the interval is none */
            trigger worksheet start /if cmp($sheet_interval, "none");
            /* It might be the first time and the interval is proc */
            trigger worksheet start /if cmp($sheet_interval, "proc");
    end;

    define event Print_Header;
        putq ' x:Data=' $print_header;
    end;

    define event Print_Footer;
        putq ' x:Data=' $print_footer;
    end;

    define event system_title_setup_group;
        start:
            open page_setup;
            unset $titles;
            unset $title_urls;
            unset $title_styles;
            set $xheader "True";
            put  '<x:Header ';
            putq 'x:Margin=' $print_header_margin;
            trigger Print_Header /if $embedded_titles;
        finish:
            do /if $not_first;
                putl '"' /if ^$embedded_titles;
            done;
            putl '/>' ;
            unset $not_first;
    end;

    define event system_footer_setup_group;
        start:
            open page_setup;
            unset $footers;
            unset $footer_styles;
            set $xfooter "True";
            put  '<x:Footer ';
            putq 'x:Margin=' $print_footer_margin;
            trigger Print_Footer /if $embedded_footnotes;
        finish:
            do /if $not_first;
                putl '"' /if ^$embedded_footnotes;
            done;
            putl '/>' ;
            unset $not_first;
            unset $not_first;
    end;

    /*-------------------------------------------------------------eric-*/
    /*-- Print out the titles and footnotes with newlines between them.--*/
    /*----------------------------------------------------------3Jul 03-*/
    define event title_data;

        do /if $not_first;
            put "&#13;";
        else;
            putq " ss:StyleID=" lowcase(htmlclass);
            putq ' Data="';
        done;

        put value;

        /*-------------------------------------------------------eric-*/
        /*-- The flush causes everything to go into the page_setup  --*/
        /*-- stream.  Without it, some of the titles, - every other --*/
        /*-- second title, where the second one has style           --*/
        /*-- over-rides, will go to the output file.                --*/
        /*----------------------------------------------------24Nov04-*/
        flush;

        set $not_first "True";
    end;

    define event system_title_setup;
        trigger title_data /if ^$embedded_titles;
        set $tmp_value strip(value);
        set $tmp_value ' ' /if ^$tmp_value;
        set $titles[] $tmp_value;
        do /if url;
            set $title_urls[] url;
        else;
            set $title_urls[] "$$$$$";
        done;
        unset $tmp_value;
        trigger title_footer_over_rides;
        set $title_styles[] $style_name;
        set $system_title_setup "True";
    end;

   define event super;
       put '<B xmlns="http://www.w3.org/TR/REC-html40"><Sup>' value '</Sup></B>';
   end;

   define event newline;
            unset $value;
            do /if value;
                break /if index(value,"-");
                eval $ncount inputn(value, "3.");
                do /if $ncount > 256;
                    eval $ncount 256;
                done;
            else;
                eval $ncount 1;
            done;

            do /while $ncount;
                put "&#13;" nl;
                eval $ncount $ncount-1;
            done;
            unset $ncount;
        end;

    define event system_footer_setup;
        trigger title_data /if ^$embedded_footnotes;
        set $tmp_value strip(value);
        set $tmp_value ' ' /if ^$tmp_value;
        set $footers[] $tmp_value;
        do /if url;
            set $footer_urls[] url;
        else;
            set $footer_urls[] "$$$$$";
        done;
        unset $tmp_value;
        trigger title_footer_over_rides;
        set $footer_styles[] $style_name;
        set $system_footer_setup "True";
    end;


    define event title_footer_over_rides;
        set $style_name lowcase(htmlclass);
        unset $title_style_over_ride;
        set $title_style_over_ride "True" /if any(font_face, font_size, font_style,
                                                    font_weight, foreground, background,
                                                    borderwidth, bordercolor);
            /*---------------------------------------------------eric-*/
            /*-- The contains is a workaround for a bug in inline   --*/
            /*-- formatting in SAS 9.1.3.                           --*/
            /*-- 7Nov 06                                            --*/
            /*--                                                    --*/
            /*-- Any time a title has inline formatting, the        --*/
            /*-- non-recursive event processor looses it's mind and --*/
            /*-- thinks it's the last event that happened, instead  --*/
            /*-- of the current real event.                         --*/
            /*------------------------------------------------7Nov 06-*/
            set $align getoption('center');
            do /if ^cmp($align, 'center');
                set $align 'left';
            else;
                set $align lowcase(just);
            done;

        do /if cmp(event_name, "system_title_setup") | contains ($style_name, "title");;
                do /if $title_style_over_ride;
                    do /if $title_style_count;
                        eval $title_style_count $title_style_count + 1;
                    else;
                        eval $title_style_count 1;
                    done;
                done;
                set $span_cell_style $style_name;
                trigger span_cell_style_just;
                set $style_name $span_cell_style;
                set $style_name $style_name "_" $title_style_count /if $title_style_over_ride;

            else /if cmp(event_name, "system_footer_setup") | contains ($style_name, "ooter");
                do /if $title_style_over_ride;
                    do /if $footer_style_count;
                        eval $footer_style_count $footer_style_count + 1;
                    else;
                        eval $footer_style_count 1;
                    done;
                done;
                set $span_cell_style $style_name;
                trigger span_cell_style_just;
                set $style_name $span_cell_style;
                set $style_name $style_name "_" $footer_style_count /if $title_style_over_ride;
            done;

        do /if any(font_face, font_size, font_style,
            font_weight, foreground, background,
            borderwidth, bordercolor);

            /*putlog "TITLE_FOOTER_OVER_RIDES: " $style_name " : " $htmlclass " : " event_name;*/
            /*-----------------------------------------------eric-*/
            /*-- This event redirects to it's own stream,       --*/
            /*-- ye be warned...                                --*/
            /*--------------------------------------------19Aug03-*/
            trigger xl_style_elements;


            open style;
            put '<Style ss:ID="' $style_name '"';
            putq ' ss:Parent=' $span_cell_style '>' NL;

            put $$style_elements;
            unset $$style_elements;

            putl '</Style>';
            close;

            open page_setup;

        done;
    end;


    /* for debugging */
    define event putvars;
        put NL "----- Event Variables -----" NL;
        putvars EVENT  _NAME_ "=" _VALUE_ NL;
        put "----- Style Variables -----" NL;
        putvars STYLE  _NAME_ "=" _VALUE_ NL;
        put NL;
    end;

end;

    define tagset tagsets.config_debug;

        default_event = 'basic';

        indent = 2;

        define event basic;
            start:
                put '<' event_name;

                put ' value=' value;
                put ' name=' name;
                put ' label=' label;

                put '/' / if empty;
                put '>' nl;
                break / if empty;
                ndent;
            finish:
                break / if empty;
                xdent;
                put '</' event_name '>' nl;
        end;

        define event initialize;
            trigger set_options_defaults;
            trigger set_valid_options;
            trigger set_options;
        end;

        /*--------------------------------------------------------------eric-*/
        /*-- This one happens when options(...) are given on the ods markup--*/
        /*-- statement.                                                    --*/
        /*-----------------------------------------------------------14Jun04-*/
        define event options_set;
            trigger set_options;
        end;

        define event set_options;
            trigger check_valid_options;
            trigger options_setup;
            trigger documentation;
        end;

        define event check_valid_options;
            iterate $options;
            do /while _name_;
                do /if ^$valid_options[_name_];
                    putlog "Unrecognized option: " _name_;
                done;
                next $options;
            done;
        end;


        /*-------------------------------------------------------eric-*/
        /*-- These get over ridden in the child class....           --*/
        /*----------------------------------------------------16Mar07-*/
        define event options_setup;
            trigger config_debug_options_setup;
        end;
        define event set_options_defaults;
            trigger config_debug_set_options_defaults;
        end;
        define event set_valid_options;
            trigger config_debug_set_valid_options;
        end;

        define event config_debug_options_setup;
            /* Debug Level */
            unset $option;
            set $option $options['DEBUG_LEVEL'];

            eval $debug_level inputn($option, 'BEST');
            do /if missing($debug_level);
                set $option $option_defaults['DEBUG_LEVEL'];
                eval $debug_level inputn($option, 'BEST');
            done;
            putlog "DEBUG" ": " $debug_level /if $debug_level ^= 0;


            /* Configuration Name */
            unset $configuration_name;
            set $configuration_name $options['CONFIGURATION_NAME'];
            set $configuration_name $option_defaults['CONFIGURATION_NAME'] /if ^$configuration_name;


            /* Configuration File */
            unset $configuration_file;
            set $configuration_file $options['CONFIGURATION_FILE'];
            set $configuration_file $option_defaults['CONFIGURATION_NAME'] /if ^$configuration_file;

            /*---------------------------------------------------eric-*/
            /*-- Possibly blank it out.  one way or the other.      --*/
            /*------------------------------------------------16Mar07-*/
            unset $configuration_file /if cmp($configuration_file, 'none');
            set $configuration_file strip($configuration_file);

            do /if $configuration_file;
                trigger read_config_ini;
            else;
                unset $configuration_file;
            done;

            trigger write_ini;

        end;

        define event documentation;
            break /if ^$options;
            trigger help /if cmp($options['DOC'], 'help');
            trigger settings /if cmp($options['DOC'], 'settings');
            trigger quick /if cmp($options['DOC'], 'quick');
        end;

        define event settings;
            putlog "  Configuration_Name: "  $configuration_name;
            putlog "  Configuration_File: "  $configuration_file;
            putlog "  Debug Level: "  $debug_level;
        end;

        define event config_debug_set_valid_options;
            set $valid_options['DEBUG_LEVEL'] 'Numeric value to turn on various debug messages';
            set $valid_options['CONFIGURATION_FILE'] 'An ini file to read option settings from' ;
            set $valid_options['CONFIGURATION_NAME'] 'A section name in an ini file that holds option settings';
        end;

        define event config_debug_set_options_defaults;
            set $option_defaults['DEBUG_LEVEL'] '0';
            set $option_defaults['CONFIGURATION_FILE'] 'none';
            set $option_defaults['CONFIGURATION_NAME'] 'none';
        end;

        define event config_debug_help;
            putlog " ";
            putlog "Configuration_Name: ";
            putlog "     Description:  Name of the configuration to read or write";
            putlog "                   in the .ini file.";
            putlog " ";
            putlog "     Possible Values: Any reasonable string.";
            putlog "     Default value:  " $defaults['CONFIGURATION_NAME'];
            putlog "     Current value: " $configuration_name;
            putlog " ";
            putlog "Configuration_File: ";
            putlog "     Description:  Name of the configuration file to read.";
            putlog "                   This is a .ini formatted file as written";
            putlog "                   to the data file if one is given";
            putlog "                   If given, the options for the configuration";
            putlog "                   will be loaded on top of any options given on the";
            putlog "                   ods statement.  A file may contain more than one";
            putlog "                   configuration section.  Only the first section that";
            putlog "                   matches the configuration name will be loaded.";
            putlog " ";
            putlog "     Possible Values: A valid file name.";
            putlog "     Default value: " $defaults['CONFIGURATION_FILE'];
            putlog "     Current value: " $configuration_file;
            putlog " ";
            putlog "Debug_Level: ";
            putlog "     Description:  Determine what level of debugging information should";
            putlog "                   be printed to the log. ";
            putlog " ";
            putlog "     Possible Values: Any positive or negative number";
            putlog "     Default value: " $defaults['DEBUG_LEVEL'];
            putlog "     Current value: " $debug_level;
            putlog " ";
        end;


        define event write_ini;
            file=data;

            /* It is a bug that this needs to be done */
            break /if ^cmp(dest_file, 'data');

            /*---------------------------------------------------------------eric-*/
            /*-- Only write a configuration once.  If the name changes          --*/
            /*-- it's ok to write it again. It doesn't cover all possibilities  --*/
            /*-- but it should be good enough.                                  --*/
            /*------------------------------------------------------------11Feb05-*/
            break /if cmp($ini_written, $configuration_name);
            set $ini_written $configuration_name;

            put '[' $Configuration_name ']' nl;

            put "Tagset_name =" tagset  nl;

            iterate $options;

            do /while _name_;
                put _name_ ' = ' _value_ nl;
                next $options;
            done;

            put ' ' nl;
            put ' ' nl;

        end;

        define event read_config_ini;
            set $read_file $configuration_file;
            putlog "READING configuration_file" ":" $configuration_file;
            trigger readfile;

            do /if $debug_level >= 1;
                putlog "OPTIONS LOADED from " ":" $configuration_file " : " $configuration_name;
                iterate $options;
                do /while _name_;
                    putlog _name_ " : " _value_;
                    next $options;
                done;
            done;
        end;

        /*---------------------------------------------------------------eric-*/
        /*-- Look for a section that matches the configuration name.        --*/
        /*-- Once found, read the variable in and load them into            --*/
        /*-- the options array.                                             --*/
        /*--                                                                --*/
        /*-- If another section is encountered quit scanning                --*/
        /*-- for options.                                                   --*/
        /*------------------------------------------------------------11Feb05-*/
        define event process_data;

            break /if $done_reading_section;

            do /if $debug_level >= 2;
                do /if ^$done_reading_section;
                    putlog "LOOKING [" $configuration_name "]" " " $record ;
                done;
            done;


            /*-- If a record starts with a [ then it is the start of a new section.--*/
            /*------------------------------------------------------------11Feb05-*/
            set $record_start substr($record, 1,1);

            do /if cmp('[', $record_start);

                set $config_name_pattern "[" $configuration_name "]";
                do /if cmp($config_name_pattern, $record);
                    putlog "Reading configuration: " $configuration_name;
                    set $reading_section "True";
                else;
                    set $done_reading_section "True" /if $reading_section;
                    unset $reading_section;
                done;

            else /if $reading_section;

                do /if $debug_level >= 2;
                    putlog "LOADING [" $configuration_name "]" " " $record ;
                done;

                set $key scan($record, 1, '=');
                set $key_value scan($record, 2, '=');

                set $key strip($key);
                set $key_value strip($key_value);

                set $options[$key] $key_value;
            done;


        end;

        define event readfile;

            /*---------------------------------------------------eric-*/
            /*-- Set up the file and open it.                       --*/
            /*------------------------------------------------13Jun03-*/

            set $filrf "myfile";
            eval $rc filename($filrf, $read_file);

            do /if $debug_level >= 5;
                putlog "File Name" ":" $rc " : " $read_file;
            done;

            eval $fid fopen($filrf);

            do /if $debug_level >= 5;
                putlog "File ID" ":" $fid;
            done;


            /*---------------------------------------------------eric-*/
            /*-- datastep functions  will bind directly to the      --*/
            /*-- variable space as it exists.                       --*/
            /*--                                                    --*/
            /*-- Tagset variables are not like datastep             --*/
            /*-- variables but we can create a big one full         --*/
            /*-- of spaces and let the functions write to it.       --*/
            /*--                                                    --*/
            /*-- This creates a variable that is 200 spaces so      --*/
            /*-- that the function can write directly to the        --*/
            /*-- memory location held by the variable.              --*/
            /*-- in VI, 200i<space>                                 --*/
            /*------------------------------------------------27Jun03-*/
            set $file_record  "

                                                               ";

            /*---------------------------------------------------eric-*/
            /*-- Loop over the records in the file                  --*/
            /*------------------------------------------------13Jun03-*/
            do /if $fid > 0 ;

                do /while fread($fid) = 0;

                    set $rc fget($fid,$file_record ,200);

                    do /if $debug_level >= 5;
                        putlog 'Fget' ':' $rc 'Record' ':' $file_record;
                    done;

                    set $record trim($file_record);

                    trigger process_data;

                    /* trimn to get rid of the spaces at the end. */
                    /*put trimn($file_record ) nl;*/

                done;
            done;

           /*-----------------------------------------------------eric-*/
           /*-- close up the file.  set works fine for this.         --*/
           /*--------------------------------------------------13Jun03-*/

            set $rc close($fid);
            set $rc filename($filrf);

        end;

end;

%ExcelXP;

run;

