clear all 
set more off

global pathdofiles 	"../do_files"
global pathdata 	"../data"
global pathoutput 	"../replication_output"

quietly capture cd $pathdata
if (_rc) {
   display as result in smcl `"{error}Not in correct path: Please use Stata's {stata "cd"} command to navigate to {bf:./StataFiles/Dofiles} folder before running {bf:0_MAIN.do}."'
    exit 601
}

********************************************************************************
*							   A) Preparing data
********************************************************************************

*** --- 1) Merging data to panel --- ***
do "$pathdofiles/1_merging.do"
drop if session=="P0" | session=="P1" | session=="P2" /*Pilot sessions*/

*** --- 2) Generating variables, scores, interaction variables and exclusion criteria --- ***
do "$pathdofiles/2_variables.do"

*** --- 3) Applying labels to data --- ***
do "$pathdofiles/3_labels.do"

save "$pathoutput/prepared_panel_data.dta", replace


********************************************************************************
*							   B) Analysis
********************************************************************************
use "$pathoutput/prepared_panel_data.dta", clear
drop if exclusion>=3

do "$pathdofiles/4_regression_globals_corr.do"

cd "$pathoutput"

*** --- 5) Regression tables: Tables 2-6, A2, and A4-A13 --- ***

do "$pathdofiles/5-tex_regressions.do" /*Generates tables in tex for Latex*/

do "$pathdofiles/5-rtf_regressions.do" /*Generates same tables in rtf for Word*/

*** --- 6) Tables with descriptive statistics: Tables 1, A1, and A3  --- ***

do "$pathdofiles/6-tex_descriptivestats" /*Generates tables in tex for Latex*/

do "$pathdofiles/6-rtf_descriptivestats" /*Generates same tables in rtf for Word*/

clear
exit
