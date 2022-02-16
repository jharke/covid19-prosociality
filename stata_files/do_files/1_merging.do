********************************************************************************
*							  1) Merging data to panel
********************************************************************************

clear
use "$pathdata/corona_donation_experiment_anonymized.dta"

merge n:1 location using "$pathdata/UTLAdata_lnskew.dta", keepus(region)
drop if _merge==2
rename _merge merge_UTLA

