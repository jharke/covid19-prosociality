********************************************************************************
*							 5) Regression tables
********************************************************************************
********************************************************************************
*							Setting control variables
********************************************************************************
		*** --- Figure A5 --- ***

twoway (lpolyci playerdonation week if week<13, level(90) ) (lpolyci playerdonation week if week>16, level(90) ) (scatter casesnormal week, yaxis(2))  if location=="Kent" ,title(Kent)
twoway (lpolyci playerdonation week if week<13, level(90) ) (lpolyci playerdonation week if week>16, level(90) ) (scatter casesnormal week, yaxis(2))  if location=="Birmingham" ,title(Birmingham)
twoway (lpolyci playerdonation week if week<13, level(90) ) (lpolyci playerdonation week if week>16, level(90) ) (scatter casesnormal week, yaxis(2))  if location=="Hertfordshire" ,title(Hertfordshire)
twoway (lpolyci playerdonation week if week<13, level(90) ) (lpolyci playerdonation week if week>16, level(90) ) (scatter casesnormal week, yaxis(2))  if location=="Essex" ,title(Essex)


*****************************************************************************
*							Regression tables
********************************************************************************
*							 Main Hypotheses
********************************************************************************

		*** --- Table 1 --- ***
*do $pathdofiles/6_descriptivestats.do		

		
		*** --- Table 2 --- ***
		*** --- H1: Covid-19 increases donations --- ***

eststo  clear
eststo: xi: reg playerdonation treatment $H1controls $basecontrols $timecontrols, vce(robust)

eststo: xi: reg playerdonation treatment $H1controls $basecontrols $timecontrols $financialcontrols, vce(robust)

eststo: xi: reg playerdonation treatment $H1controls $basecontrols $timecontrols $financialcontrols $health, vce(robust)

esttab using "Tables_regressions.rtf", replace ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        drop( $H1controls _cons) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table 2: H1: The COVID-19 frame increases donations. Outcome variable: donation") ///
        mtitles("(1)" "(2)" "(3)") ///
        note("Note: Sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Baseline controls are slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, and number of household members. Financial controls include monthly household income, making ends meet dummies (before the pandemic and since the pandemic), and income change dummies (since the pandemic and expected in the future). Health controls include health negatively affected by COVID-19 dummies, expected negative impact on health dummies, and vulnerability to COVID-19: high risk or moderate risk dummies.")


		*** --- Table 3 --- ***		
		*** --- H2: Local severity --- ***

eststo  clear
eststo: xi: reg playerdonation casesnormal100 $H2controls $basecontrols $timecontrols, vce(robust)
estimates store modelH2_1

eststo: xi: reg playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health, vce(robust)
estimates store modelH2_2

eststo: xi: reg playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $areacontrols $financialcontrols $health, vce(robust)
estimates store modelH2_3

eststo: xi: areg playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store modelH2_4

estfe model*, labels(location "Location fixed effect")

esttab modelH2_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(casesnormal100 treatment) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table 3: H2:  Individuals in more affected places will give more (or less) than individuals in less affected places. Outcome variable: donation") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects). Financial controls include monthly household income, making ends meet dummies (before the pandemic and since the pandemic), income change dummies (since the pandemic and expected in the future). Health controls include health negatively affected by COVID-19 dummies, expected negative impact on health dummies, and vulnerability to COVID-19: high risk or moderate risk dummies. Area controls include dummies for shares of different age groups; population density; dummies for shares of people with good, fair, and bad health; job density; mean annual pay for full-time workers; mean hourly pay for full-time workers; mean work hours for full-time workers; number of National Health Service hospitals per 100 inhabitants; and shares of employees in different sectors of the economy.")


		*** --- Table 4 --- ***
		*** --- H2 modified: attention through articles--- ***
		
eststo  clear
eststo: xi: reg playerdonation articles10 $H2controls $basecontrols $timecontrols, vce(robust)
estimates store modelH2b_1

eststo: xi: reg playerdonation articles10 $H2controls $basecontrols  $timecontrols $financialcontrols $health, vce(robust)
estimates store modelH2b_2

eststo: xi: reg playerdonation articles10 $H2controls $basecontrols $timecontrols $areacontrols $financialcontrols $health, vce(robust)
estimates store modelH2b_3

eststo: xi: areg playerdonation articles10 $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store modelH2b_4

estfe model*, labels(location "Location fixed effect")

esttab modelH2b_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(articles10 treatment) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table 4: Number of articles about outbreaks/hotspots for a specific location and donations in the experiment. Outcome variable: donation") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: See notes to Table 3. The variable Articles is scaled by 10 to ease the readability of the coefficient.")
		

		*** --- Table 5 --- ***		
		*** --- H3: national vs international charities --- ***

eststo  clear
eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols if playerdonation!=0 , vce(robust)

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $financialcontrols if playerdonation!=0 , vce(robust)

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $health if playerdonation!=0 , vce(robust)

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $financialcontrols $health $perceivedimportance if playerdonation!=0 , vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(treatment $perceivedimportance) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table 5: H3: The national project will benefit more from the COVID-19 frame than the international project. Outcome variable: share of donation to UK") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects). Financial controls include monthly household income, making ends meet dummies (before the pandemic and since the pandemic), and income change dummies (since the pandemic and expected in the future). Health controls include health negatively affected by COVID-19 dummies, expected negative impact on health dummies, and vulnerability to COVID-19: high risk or moderate risk dummies.") 
	
 
		*** --- Table 6 --- ***
		*** --- H4: national vs international charities --- ***

eststo  clear
eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols if playerdonation!=0 , vce(robust)
estimates store modelH4_1

eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health if playerdonation!=0 , vce(robust)
estimates store modelH4_2

eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health $areacontrols if playerdonation!=0 , vce(robust)
estimates store modelH4_3

eststo: xi: areg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health if playerdonation!=0 , vce(robust) a(location)
estimates store modelH4_4

estfe model*, labels(location "Location fixed effect")

esttab modelH4_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
		keep(casesnormal100 treatment) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", 	labels("Yes" "No")) ///
        title("Table 6: H4: Individuals in more affected places will shift their giving more to local causes than those in less affected places. Outcome variable: share of donation to UK") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: See note to Table 3.")


		*** --- Table A1 --- ***
		*** --- Descriptive statistics and balancing table --- ***
*do $pathdofiles/6_descriptivestats.do		


		*** --- Table A2: --- ***
		*** ---  Robustness check H1 --- ***	

eststo  clear
xi: tobit playerdonation treatment  $H1controls $basecontrols $timecontrols, vce(robust) ul ll
eststo: margins , dydx(treatment  $H1controls $basecontrols_I $timecontrols_I) 

xi: tobit playerdonation treatment  $H1controls $basecontrols $timecontrols $financialcontrols, vce(robust) ul ll
eststo: margins , dydx(treatment  $H1controls $basecontrols_I $timecontrols_I $financialcontrols_I) 

xi: tobit playerdonation treatment  $H1controls $basecontrols $timecontrols $financialcontrols $health, vce(robust) ul ll
eststo: margins , dydx(treatment  $H1controls $basecontrols_I $timecontrols_I  $financialcontrols_I $health) 

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(treatment)  ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A2: H1: The COVID-19 reference increases donations. Marginal effects after tobit. Outcome variable: donation") ///
		mtitles ("(1)" "(2)" "(3)" "(4)")  ///
		note("Note: See note to Table 2.") 


		*** --- Table A3 --- ***	
		*** --- Mean donations by category --- ***
*do $pathdofiles/6_descriptivestats.do		

		
		*** --- Table A4 --- ***	
		*** --- Local severity - correlations between pandemic severity and subjective perceptions --- ***

eststo  clear
eststo: xi: areg  pandemic_UTLA_more casesnormal100 $timecontrols, vce(robust) a(location)
estimates store tableA4_1

eststo: xi: areg  pandemic_UTLA_equally casesnormal100 $timecontrols, vce(robust) a(location)
estimates store tableA4_2

eststo: xi: areg  pandemic_UTLA_less casesnormal100 $timecontrols, vce(robust) a(location)
estimates store tableA4_3

estfe tableA*, labels(location "Location fixed effect")

esttab tableA4_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(casesnormal100 ) ///
		indicate(`r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A4: The effect of the relative local severity of the pandemic on subjective perceptions of local severity. Outcome variable: subjective perceptions of local severity") ///
        mtitles("(1) More severe" "(2) Equally severe" "(3) Less severe" ) ///
        note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include time fixed effects and location fixed effects.")
		
		
		*** --- Table A5 --- ***
		*** ---  Robustness check H2 Local severity --- ***

eststo  clear
xi: tobit playerdonation casesnormal100 $H2controls $basecontrols $timecontrols, vce(robust) ul ll
eststo: margins, dydx(casesnormal100 $H2controls $basecontrols_I $timecontrols_I)

xi: tobit playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) ul ll
eststo: margins, dydx(casesnormal100 $H2controls $basecontrols_I $timecontrols_I $financialcontrols_I $health)

xi: tobit playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health $areacontrols , vce(robust) ul ll
eststo: margins, dydx(casesnormal100 $H2controls $basecontrols_I $timecontrols_I $financialcontrols_I $health $areacontrols)

xi: tobit playerdonation casesnormal100 $H2controls $basecontrols  $timecontrols $financialcontrols $health i.location, vce(robust) ul ll
eststo: margins, dydx(casesnormal100 $H2controls $basecontrols_I  $timecontrols_I $financialcontrols_I $health  _Ilocation* )

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se pr2 keep(casesnormal100 treatment) ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" "Location fixed effect = _Ilocation*" "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A5: H2: Individuals in more affected places will give more (or less) than individuals in less affected places. Marginal effects after a two-limit Tobit. Outcome variable: donation") ///
		mtitles ("(1)" "(2)" "(3)" "(4)")  ///
		note("Note: See note to Table 3.") 


		*** ---  Table A6 --- ***
		*** --- t x region effects --- ***

eststo  clear

eststo: xi: areg playerdonation casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health  weekd1location_region_idd1 weekd1location_region_idd2 weekd1location_region_idd3 weekd1location_region_idd4 weekd1location_region_idd5 weekd1location_region_idd6 weekd1location_region_idd7 weekd1location_region_idd8 weekd1location_region_idd9 weekd2location_region_idd1 weekd2location_region_idd2 weekd2location_region_idd3 weekd2location_region_idd4 weekd2location_region_idd5 weekd2location_region_idd6 weekd2location_region_idd7 weekd2location_region_idd8 weekd2location_region_idd9 weekd3location_region_idd1 weekd3location_region_idd2 weekd3location_region_idd3 weekd3location_region_idd4 weekd3location_region_idd5 weekd3location_region_idd6 weekd3location_region_idd7 weekd3location_region_idd8 weekd3location_region_idd9 weekd4location_region_idd1 weekd4location_region_idd2 weekd4location_region_idd3 weekd4location_region_idd4 weekd4location_region_idd5 weekd4location_region_idd6 weekd4location_region_idd7 weekd4location_region_idd8 weekd4location_region_idd9 weekd5location_region_idd1 weekd5location_region_idd2 weekd5location_region_idd3 weekd5location_region_idd4 weekd5location_region_idd5 weekd5location_region_idd6 weekd5location_region_idd7 weekd5location_region_idd8 weekd5location_region_idd9 weekd6location_region_idd1 weekd6location_region_idd2 weekd6location_region_idd3 weekd6location_region_idd4 weekd6location_region_idd5 weekd6location_region_idd6 weekd6location_region_idd7 weekd6location_region_idd8 weekd6location_region_idd9 weekd7location_region_idd1 weekd7location_region_idd2 weekd7location_region_idd3 weekd7location_region_idd4 weekd7location_region_idd5 weekd7location_region_idd6 weekd7location_region_idd7 weekd7location_region_idd8 weekd7location_region_idd9 weekd8location_region_idd1 weekd8location_region_idd2 weekd8location_region_idd3 weekd8location_region_idd4 weekd8location_region_idd5 weekd8location_region_idd6 weekd8location_region_idd7 weekd8location_region_idd8 weekd8location_region_idd9 weekd9location_region_idd1 weekd9location_region_idd2 weekd9location_region_idd3 weekd9location_region_idd4 weekd9location_region_idd5 weekd9location_region_idd6 weekd9location_region_idd7 weekd9location_region_idd8 weekd9location_region_idd9 weekd10location_region_idd1 weekd10location_region_idd2 weekd10location_region_idd3 weekd10location_region_idd4 weekd10location_region_idd5 weekd10location_region_idd6 weekd10location_region_idd7 weekd10location_region_idd8 weekd10location_region_idd9 weekd11location_region_idd1 weekd11location_region_idd2 weekd11location_region_idd3 weekd11location_region_idd4 weekd11location_region_idd5 weekd11location_region_idd6 weekd11location_region_idd7 weekd11location_region_idd8 weekd11location_region_idd9 weekd12location_region_idd1 weekd12location_region_idd2 weekd12location_region_idd3 weekd12location_region_idd4 weekd12location_region_idd5 weekd12location_region_idd6 weekd12location_region_idd7 weekd12location_region_idd8 weekd12location_region_idd9 weekd13location_region_idd1 weekd13location_region_idd2 weekd13location_region_idd3 weekd13location_region_idd4 weekd13location_region_idd5 weekd13location_region_idd6 weekd13location_region_idd7 weekd13location_region_idd8 weekd13location_region_idd9 weekd14location_region_idd1 weekd14location_region_idd2 weekd14location_region_idd3 weekd14location_region_idd4 weekd14location_region_idd5 weekd14location_region_idd6 weekd14location_region_idd7 weekd14location_region_idd8 weekd14location_region_idd9 weekd15location_region_idd1 weekd15location_region_idd2 weekd15location_region_idd3 weekd15location_region_idd4 weekd15location_region_idd5 weekd15location_region_idd6 weekd15location_region_idd7 weekd15location_region_idd8 weekd15location_region_idd9 weekd16location_region_idd1 weekd16location_region_idd2 weekd16location_region_idd3 weekd16location_region_idd4 weekd16location_region_idd5 weekd16location_region_idd6 weekd16location_region_idd7 weekd16location_region_idd8 weekd16location_region_idd9 weekd17location_region_idd1 weekd17location_region_idd2 weekd17location_region_idd3 weekd17location_region_idd4 weekd17location_region_idd5 weekd17location_region_idd6 weekd17location_region_idd7 weekd17location_region_idd8 weekd17location_region_idd9 weekd18location_region_idd1 weekd18location_region_idd2 weekd18location_region_idd3 weekd18location_region_idd4 weekd18location_region_idd5 weekd18location_region_idd6 weekd18location_region_idd7 weekd18location_region_idd8 weekd18location_region_idd9 weekd19location_region_idd1 weekd19location_region_idd2 weekd19location_region_idd3 weekd19location_region_idd4 weekd19location_region_idd5 weekd19location_region_idd6 weekd19location_region_idd7 weekd19location_region_idd8 weekd19location_region_idd9 weekd20location_region_idd1 weekd20location_region_idd2 weekd20location_region_idd3 weekd20location_region_idd4 weekd20location_region_idd5 weekd20location_region_idd6 weekd20location_region_idd7 weekd20location_region_idd8 weekd20location_region_idd9 weekd21location_region_idd1 weekd21location_region_idd2 weekd21location_region_idd3 weekd21location_region_idd4 weekd21location_region_idd5 weekd21location_region_idd6 weekd21location_region_idd7 weekd21location_region_idd8 weekd21location_region_idd9 , vce(robust) a(location)
estimates store tableA6_1

estfe tableA*, labels(location "Location fixed effect")	
	
esttab tableA6_1 using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted nogap nobaselevels ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(casesnormal100 treatment) ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" `r(indicate_fe)' "Time fixed effects = $timecontrols_I" "Time fixed effects x Region fixed effects = weekd*location_regio*", labels("Yes" "No")) ///
        title("Table A6: Regional trends") ///
        mtitles("(1)") ///
        note("Note: See note to Table 3.")
	
		
		*** --- Table A7 --- ***
		*** --- SH0: interaction effect --- ***
			
eststo  clear
eststo: xi: reg playerdonation casesnormal100 treatment_casesnormal100 $H2controls $basecontrols $timecontrols, vce(robust)
estimates store tableA7_1

eststo: xi: reg playerdonation casesnormal100 treatment_casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health, vce(robust)
estimates store tableA7_2

eststo: xi: reg playerdonation casesnormal100 treatment_casesnormal100 $H2controls $basecontrols $timecontrols $areacontrols $financialcontrols $health, vce(robust)
estimates store tableA7_3

eststo: xi: areg playerdonation casesnormal100 treatment_casesnormal100 $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store tableA7_4

estfe tableA*, labels(location "Location fixed effect")

esttab tableA7_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(casesnormal100 treatment treatment_casesnormal100) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A7: Interaction effect. Outcome variable: donation amount") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: See note to Table 3.")
		
		
		*** --- Table A8 --- ***	
		*** --- H2: Local severity --- ***
		
eststo  clear
eststo: xi: reg playerdonation cases_utla_7_daysin1000 $H2controls $basecontrols $timecontrols, vce(robust)
estimates store tableA8_1

eststo: xi: reg playerdonation cases_utla_7_daysin1000 $H2controls $basecontrols $timecontrols $financialcontrols $health, vce(robust)
estimates store tableA8_2

eststo: xi: reg playerdonation cases_utla_7_daysin1000 $H2controls $basecontrols $timecontrols $areacontrols $financialcontrols $health, vce(robust)
estimates store tableA8_3

eststo: xi: areg playerdonation cases_utla_7_daysin1000 $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store tableA8_4

estfe tableA*, labels(location "Location fixed effect")
esttab tableA8_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(cases_utla_7_daysin1000 treatment) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A8: H2: Individuals in more affected places will give more (or less) than individuals in less affected places. Alternative specification of local severity: absolute number of COVID-19 cases in the last 7 days (in tsd.). Outcome variable: donation"/label{H2/_table}) ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: See note to Table 3.")

		
		*** --- Table A9 --- ***	

eststo  clear
eststo: xi: reg playerdonation casesper100_7days $H2controls $basecontrols $timecontrols, vce(robust)
estimates store tableA9_1

eststo: xi: reg playerdonation casesper100_7days $H2controls $basecontrols $timecontrols $financialcontrols $health, vce(robust)
estimates store tableA9_2

eststo: xi: reg playerdonation casesper100_7days $H2controls $basecontrols $timecontrols $areacontrols $financialcontrols $health, vce(robust)
estimates store tableA9_3

eststo: xi: areg playerdonation casesper100_7days $H2controls $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store tableA9_4

estfe tableA*, labels(location "Location fixed effect")

esttab tableA9_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label onecell nogap nobaselevels noomitted ///
        nogap nobaselevels nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
        keep(casesper100_7days treatment) ///
        indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A9: H2: Individuals in more affected places will give more (or less) than individuals in less affected places. Alternative specification of local severity: number of COVID-19 cases in the last 7 days per 100,000. Outcome variable: donation") ///
        mtitles("(1)" "(2)" "(3)" "(4)") ///
        note("Note: See note to Table 3.")

		
		*** --- Table A10 --- ***	
		*** --- Oster like test --- ***

eststo  clear
eststo: xi: areg playerdonation casesnormal100  treatment playerinitial_donation $timecontrols, vce(robust) a(location)
estimates store tableA10_1

eststo: xi: areg playerdonation casesnormal100  treatment playerinitial_donation $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA10_2

eststo: xi: areg playerdonation casesnormal100 treatment playerinitial_donation$basecontrols $timecontrols $financialcontrols  , vce(robust) a(location)
estimates store tableA10_3

eststo: xi: areg playerdonation casesnormal100 treatment playerinitial_donation $basecontrols $timecontrols $financialcontrols $health , vce(robust) a(location)
estimates store tableA10_4

eststo: xi: areg playerdonation casesnormal100 treatment playerinitial_donation $basecontrols $timecontrols $financialcontrols $health $socio , vce(robust) a(location)
estimates store tableA10_5

eststo: xi: areg playerdonation casesnormal100 treatment playerinitial_donation $basecontrols $timecontrols $financialcontrols $health $socio $workchange, vce(robust) a(location)
estimates store tableA10_6

estfe tableA*, labels(location "Location fixed effect")	
	
esttab tableA10_* using "Tables_regressions.rtf", append ///
         b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
		keep(casesnormal100) ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Other socioeconomic controls = $socio" "Work change controls = $workchange" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A10: The effect of observables on the coeficient of interest. Outcome variable: donation amount") ///
		mtitle("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
		note("Note: robust errors. All columns include time fixed effects, and location fixed effects. For baseline, financial, and health controls see note to Table 2. Other socioeconomic controls include place of living dummy (big city, small city, suburbs), employement status dummy (employed, unemployed, student, apprentice, retired), number of children in the household, and primarily source of news dummy (high quality, medium quality). Work change controls include work change since COVID-19 dummies (lost permanently, lost temporarily without pay, lost temporarily with pay, hours reduced), number of days commuting before COVID-19 and since COVID-19, and remote work dummies (fully, partly).")
	

		*** --- Table A11 --- ***	

eststo clear
eststo: xi: areg playerdonation  treatment $H1controls $basecontrols $timecontrols income_decreased_d, vce(robust) a(location)
estimates store tableA11_1

eststo:xi: areg playerdonation income_f_decreased_d treatment $H1controls $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA11_2

eststo:xi: areg playerdonation health_affected_lot treatment $H1controls $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA11_3

eststo:xi: areg playerdonation health_faffected_lot treatment $H1controls $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA11_4

eststo:xi: areg playerdonation health_risk_vhigh treatment $H1controls $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA11_5

eststo:xi: areg playerdonation health_risk_high treatment $H1controls $basecontrols $timecontrols, vce(robust) a(location)
estimates store tableA11_6

estfe tableA*, labels(location "Location fixed effect")

esttab tableA11_* using "Tables_regressions.rtf", append ///
		b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
		keep(income_decreased_d income_f_decreased_d health_affected_lot health_faffected_lot health_risk_vhigh health_risk_high) ///
		indicate("Baseline controls = $basecontrols_I"  `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
		title("Table A11: Correlation between economic and health variables and donation amount. Outcome variable: donation amount") ///
		mtitle("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
		note("The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following controls location fixed effects, slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).")


		*** --- Table A12 --- ***
		*** ---  Robustness checks H3 --- ***	

eststo  clear
eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols, vce(robust)
estadd local add_perceivedimportance "Yes"
estadd local add_financialcontrols "No"
estadd local add_healthcontrols "No"

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $financialcontrols, vce(robust)
estadd local add_perceivedimportance "No"
estadd local add_financialcontrols "Yes"
estadd local add_healthcontrols "No"

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $health, vce(robust)
estadd local add_perceivedimportance "No"
estadd local add_financialcontrols "No"
estadd local add_healthcontrols "Yes"

eststo: xi: reg donationshareUK treatment $H3controls $basecontrols $timecontrols $financialcontrols $health $perceivedimportance, vce(robust)
estadd local add_perceivedimportance "Yes"
estadd local add_financialcontrols "No"
estadd local add_healthcontrols "No"

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
		keep(treatment $perceivedimportance)  ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A12: H3: The national project will benefit more from the COVID-19 frame than the global project. Outcome variable: donation share to UK program") ///
		mtitles ("(1)" "(2)" "(3)" "(4)")  ///
		note("Note: See note to Table 5. The sample consists of first-stage donors and non-donors.") 
		

		*** --- Table A13 --- ***
		*** ---  Robustness checks H4 --- ***	

eststo  clear
eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols, vce(robust)
estimates store tableA13_1

eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health  , vce(robust)
estimates store tableA13_2

eststo: xi: reg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health $areacontrols  , vce(robust)
estimates store tableA13_3

eststo: xi: areg donationshareUK casesnormal100 $H4controls $basecontrols $timecontrols $financialcontrols $health, vce(robust) a(location)
estimates store tableA13_4

estfe tableA*, labels(location "Location fixed effect")

esttab tableA13_* using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.10 ** 0.05 *** 0.01) se r2 ///
		keep(casesnormal100 treatment)  ///
		indicate("Baseline controls = $basecontrols_I" "Financial controls = $financialcontrols_I" "Health controls = $health" "Area controls = $areacontrols" `r(indicate_fe)' "Time fixed effects = $timecontrols_I", labels("Yes" "No")) ///
        title("Table A13: H4: Individuals in more affected places will shift their giving to local causes more than those in less affected places. Outcome variable: donation share to UK program") ///
		mtitles ("(1)" "(2)" "(3)" "(4)")  ///
		note("Note: See note to Table 6. The sample consists of first-stage donors and non-donors.")
	
		
********************************************************************************
*						Supporting Hypotheses
*						Described in the Appendix D
********************************************************************************

				*** --- SH0: interaction effect --- ***

eststo clear
eststo: xi: reg playerdonation treatment casesnormal100 treatment_casesnormal100 playerinitial_donation $basecontrols , vce(robust)
eststo: xi: reg donationshareUK treatment casesnormal100 treatment_casesnormal100 $H3controls $basecontrols $timecontrols, vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment casesnormal100 treatment_casesnormal100)  ///
        title("SH0: local severity of COVID-19 pandemic interacts with the treatment dummy. Outcome variable: donation and share donation to UK") ///
		mtitles ("(1)" "(2)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 
		

		*** --- SH1: sceptics --- ***

eststo clear
eststo: xi: reg playerdonation treatment lnskewCOVID_sceptic treatment_sceptic $H1controls $basecontrols $timecontrols, vce(robust)
esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment lnskewCOVID_sceptic  treatment_sceptic)  ///
        title("SH1: COVID-19 skeptics will decrease giving in the COVID-19 frame. Outcome variable: donation") ///
		mtitles ("(1)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Column includes the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 
		
		
		*** --- SH2: followers --- ***
eststo clear
eststo: xi: reg playerdonation treatment COVID_behavior_score treatment_behavior_score $H1controls $basecontrols $timecontrols, vce(robust)
esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment COVID_behavior_score treatment_behavior_score)  ///
        title("SH2: Those who follow the rules and recommendations regarding COVID-19 will increase their giving in the COVID-19 frame. Outcome variable: donation") ///
		mtitles ("(1)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Column includes the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 

	
		*** --- SH3: The role of the media --- ***		
/* not enough variation in the share of national versus developing countries news about COVID-19 */	

		
		*** --- SH4: Perceived relative importance --- ***		

eststo clear
eststo: xi: reg donationshareUK treatment gdpdifference treatment_gdpdifferenc $H3controls $basecontrols $timecontrols if playerdonation!=0 , vce(robust)

eststo: xi: reg donationshareUK treatment povertydifference treatment_povertydifference $H3controls $basecontrols $timecontrols if playerdonation!=0 , vce(robust)

eststo: xi: reg donationshareUK treatment pandemic_UK_more treatment_pandemic_UK_more $H3controls $basecontrols $timecontrols if playerdonation!=0 , vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment gdpdifference treatment_gdpdifferenc povertydifference treatment_povertydifference pandemic_UK_more treatment_pandemic_UK_more)  ///
        title("SH4a-c: The relative amount of giving to the UK program versus the world program will reflect the perception of how negatively the UK will be impacted relative to developing countries.  Outcome variable: share donation to UK") ///
		mtitles ("(1)" "(2)" "(3)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 
		
		
		*** --- SH5: personal situation --- ***	
 
eststo clear
eststo: xi: reg playerdonation economic_risk_score treatment $H1controls $basecontrols $timecontrols, vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment  economic_risk_score)  ///
        title("SH5a: Individuals whose economic situation has been negatively affected since the spread of COVID-19 and those fearing such negative consequences will donate less than others. We expect beta to be positive (lower score means more affected or at higher risk in the future). Outcome variable: donation") ///
		mtitles ("(1)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Column includes the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 
 
eststo clear
eststo: xi: reg playerdonation health_score treatment $H1controls $basecontrols $timecontrols, vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment  health_score)  ///
        title("SH5b: Individuals whose health status has been negatively affected since the spread of COVID-19 and those fearing such health deterioration will donate less than others. We expect beta to be positive (lower score means more affected or at higher risk in the future). Outcome variable: donation") ///
		mtitles ("(1)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Column includes the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).")
		
eststo clear
eststo: xi: reg playerdonation distancing treatment $H1controls $basecontrols $timecontrols, vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment  distancing)  ///
        title("SH5c: Individuals with less work (or university) related distancing opportunities will donate less than others. We expect beta to be negative (higher score means less distancing opportunities). Outcome variable: donation") ///
		mtitles ("(1)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. Column includes the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 


		*** --- Empathy --- ***	

eststo clear
eststo: xi: reg playerdonation COVID_contribution treatment $H1controls $basecontrols $timecontrols, vce(robust)

eststo: xi: reg playerdonation empathy treatment $H1controls $basecontrols $timecontrols, vce(robust)

esttab using "Tables_regressions.rtf", append ///
        b(%8.3f) compress label  onecell nogap nobaselevels noomitted nogap nobaselevels noomitted ///
        nonumbers star(* 0.005 ** 0.0025 *** 0.0005) se r2 ///
		keep(treatment COVID_contribution empathy)  ///
        title("COVID-19 individual contribution and the level of empathy. Outcome variable: donation") ///
		mtitles ("(1)" "(2)")  ///
		note("Note: The sample used excludes individuals with inconsistent answers (see Online Appendix, section B); robust errors. All columns include the following baseline controls: slider initial position, age, dummy born in the UK, female dummy, socioeconomic status, number of household members, and session dummies (time fixed effects).") 
		

