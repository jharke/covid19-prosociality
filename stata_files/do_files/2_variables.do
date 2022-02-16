********************************************************************************
* 2) Generating variables, scores, interaction variables and exclusion criteria
********************************************************************************

replace playerqcasesukestimated=50000 if playersurvey_comments=="I missed a zero off of my estimate, I wrote 500 when I meant 5000."


********************************************************************************
*								harmonize values
********************************************************************************

foreach var of varlist 	playerqincomefuture playerqmemfuture playerqincomechange playerqmembefore ///
	playerqpolicies playerqcasesutlamoresevere playerqcasesukmoresevere playerqvaccinate ///
	playerqcontactsreduced playerqbasicstock playerqmask playerqfollowrules playerqcovidcontribution ///
	playerqhealth playerqhealthfuture playerqhealthrisk {		
replace `var'= lower(`var')
}


********************************************************************************
*							  generate variables
********************************************************************************

rename playertreatment_covid treatment


		*** --- UTLA information --- ***

gen casesper100= cases_utla*100/population_2020
gen casesper100_7days= cases_utla_7_days*100/population_2020
gen casesper100_estimated= playerqcasesutlaestimated*100/population_2020
gen deathsper100= deaths_region*100/population_2020
gen deathsper100_7days= deaths_region_7_days*100/population_2020

gen casesnormal= cases_utla_normalized
gen casesnormal100=casesnormal*100

gen casesnormalpopulation= cases_utla_normalized/population_share
gen casesnormal7= cases_utla_normalized_7_days
gen cases_utla_7_daysin1000=cases_utla_7_days/1000
gen casesnormalpopulation7= cases_utla_normalized_7_days/population_share
gen casesabsolute= cases_utla

gen score =num_rejections/ num_approvals

gen age16_19=(_of_all_16_who_are_aged_1619/100)*population_2020
gen age20_24=(_of_all_16_who_are_aged_2024/100)*population_2020
gen age25_34=(_of_all_16_who_are_aged_2534/100)*population_2020
gen age35_49=(_of_all_16_who_are_aged_3549/100)*population_2020
gen age50_64=(_of_all_16_who_are_aged_5064/100)*population_2020
gen age65plus=(_of_all_16_who_are_aged_65/100)*population_2020

gen good_health=((good_health_disabilityhealthcare/100)+(very_good_health_disabilityhealt/100))*population_2020
gen fair_health=(fair_health_disabilityhealthcare/100)*population_2020
gen bad_health=((bad_health_disabilityhealthcare_/100)+(very_bad_health_disabilityhealth/100))*population_2020

gen agriculture=(agriculture_per/100)*population_2020
gen mining=		(mining_per/100)*population_2020
gen manufacturing=(manufacturing_per/100)*population_2020
gen construction=(construction_per/100)*population_2020
gen motor_trades=(motor_trades_per/100)*population_2020
gen wholesale=	(wholesale_per/100)*population_2020
gen retail=		(retail_per/100)*population_2020
gen transport=	(transport_per/100)*population_2020
gen accommodation=(accommodation_per/100)*population_2020
gen information=(information_per/100)*population_2020
gen financial=	(financial_per/100)*population_2020
gen property=	(property_per/100)*population_2020
gen professional=(professional_per/100)*population_2020
gen business=	(business_per/100)*population_2020
gen public=		(public_per/100)*population_2020
gen education=	(education_per/100)*population_2020
gen health=		(health_per/100)*population_2020
gen arts=		(arts_per/100)*population_2020

rename nhs NHS

gen popdensity=population_2020/area

foreach var in age16_19 age20_24 age25_34 age35_49 age50_64 age65plus good_health fair_health bad_health jobs_density NHS agriculture mining manufacturing construction motor_trades wholesale retail transport accommodation information financial property professional business public education health arts {
gen `var'per100=(`var')*100/population_2020
drop `var'
}

foreach var in good_healthper100 fair_healthper100 bad_healthper100 jobs_density NHSper100 agricultureper100 miningper100 manufacturingper100 constructionper100 motor_tradesper100 wholesaleper100 retailper100 transportper100 accommodationper100 informationper100 financialper100 propertyper100 professionalper100 businessper100 publicper100 educationper100 healthper100 artsper100 popdensity {
lnskew0 lnskew`var' =`var'
drop `var'
}

gen articles10=articles_wide_mwe_surrounding_co/10


		*** --- Demografic information (except income) --- ***

gen age_cat=1 if (age>=18 & age<=24)
replace age_cat=2 if (age>=25 & age<=34)
replace age_cat=3 if (age>=35 & age<=49)
replace age_cat=4 if (age>=50 & age<=64)
replace age_cat=5 if (age>=65 & age<=100)

gen female=(sex=="Female")
replace female=. if sex=="CONSENT REVOKED"

gen gender=female
recode gender 0=2

gen UKbirth=(countryofbirth=="United Kingdom")
replace UKbirth=1 if countryofbirth=="United Kingdom" & mi(countryofbirth)

gen firstlanguageenglish=(firstlanguage=="English")
replace firstlanguageenglish=1 if firstlanguage=="English" & mi(firstlanguage)

gen place_big_city=(playerqurban=="In a city with over 100,000 inhabitants")
gen place_small_city=(playerqurban=="In a city with up to 100,000 inhabitants")
gen place_suburbs=(playerqurban=="In the commuter belt around a city")
gen place_rural=(playerqurban=="In a rural area")

gen status_employed=(playerqstatus=="Employed or self-employed")
replace status_employed=1 if playerqstatus=="Employed"
gen status_unemployed=(playerqstatus=="Unemployed but actively looking for work")
gen status_student=(playerqstatus=="Student")
gen status_apprentice=(playerqstatus=="Apprentice")
gen status_retired=(playerqstatus=="Retired")
gen status_inactive=(playerqstatus=="Not in the workforce")


		*** --- Income and economic status --- ***

destring socioeconomicstatus householdsize, replace

gen hh_adults=playerqhouseholdadults

gen hh_kids=playerqhouseholdchildren

gen income_category=.
replace income_category=1 	if regexm(householdincomegbp, "Less than .*£10,000")==1
replace income_category=2 	if regexm(householdincomegbp, ".*£10,000 - .*£15,999")==1
replace income_category=3 	if regexm(householdincomegbp, ".*£16,000 - .*£19,999")==1
replace income_category=4 	if regexm(householdincomegbp, ".*£20,000 - .*£29,999")==1
replace income_category=5 	if regexm(householdincomegbp, ".*£30,000 - .*£39,999")==1
replace income_category=6 	if regexm(householdincomegbp, ".*£40,000 - .*£49,999")==1
replace income_category=7 	if regexm(householdincomegbp, ".*£50,000 - .*£59,999")==1
replace income_category=8 	if regexm(householdincomegbp, ".*£60,000 - .*£69,999")==1
replace income_category=9 	if regexm(householdincomegbp, ".*£70,000 - .*£79,999")==1
replace income_category=10 	if regexm(householdincomegbp, ".*£80,000 - .*£89,999")==1
replace income_category=11 	if regexm(householdincomegbp, ".*£90,000 - .*£99,999")==1
replace income_category=12 	if regexm(householdincomegbp, ".*£100,000 - .*£149,999")==1
replace income_category=13 	if regexm(householdincomegbp, "More than .*£150,000")==1 
replace income_category=2   if regexm(playerqincome, "^Up to.*£2000")==1 & mi(income_category) 
replace income_category=6   if regexm(playerqincome, "2000 up to.*£5000")==1 & mi(income_category) 
replace income_category=11  if regexm(playerqincome, "5000 up to.*£10000")==1 & mi(income_category)
replace income_category=12  if regexm(playerqincome, "^More than.*£10000$")==1 & regexm(playerqincome, "5000")==0 & mi(income_category)


foreach i of numlist 1/13 {
gen income_category_`i'= (income_category==`i') 
}

gen hhyearlyincome=.
replace hhyearlyincome=5000 	if regexm(householdincomegbp, "Less than .*£10,000")==1
replace hhyearlyincome=12500 	if regexm(householdincomegbp, ".*£10,000 - .*£15,999")==1
replace hhyearlyincome=17500 	if regexm(householdincomegbp, ".*£16,000 - .*£19,999")==1
replace hhyearlyincome=25000 	if regexm(householdincomegbp, ".*£20,000 - .*£29,999")==1
replace hhyearlyincome=35000 	if regexm(householdincomegbp, ".*£30,000 - .*£39,999")==1
replace hhyearlyincome=45000 	if regexm(householdincomegbp, ".*£40,000 - .*£49,999")==1
replace hhyearlyincome=55000 	if regexm(householdincomegbp, ".*£50,000 - .*£59,999")==1
replace hhyearlyincome=65000 	if regexm(householdincomegbp, ".*£60,000 - .*£69,999")==1
replace hhyearlyincome=75000 	if regexm(householdincomegbp, ".*£70,000 - .*£79,999")==1
replace hhyearlyincome=85000 	if regexm(householdincomegbp, ".*£80,000 - .*£89,999")==1
replace hhyearlyincome=95000 	if regexm(householdincomegbp, ".*£90,000 - .*£99,999")==1
replace hhyearlyincome=125000 	if regexm(householdincomegbp, ".*£100,000 - .*£149,999")==1
replace hhyearlyincome=175000 	if regexm(householdincomegbp, "More than .*£150,000")==1 

replace hhyearlyincome=12000  	if regexm(playerqincome, "^Up to.*£2000")==1 & mi(hhyearlyincome)
replace hhyearlyincome=42000  	if regexm(playerqincome, "£2000 up to.*£5000")==1 & mi(hhyearlyincome)
replace hhyearlyincome=90000  	if regexm(playerqincome, "£5000 up to.*£10000")==1 & mi(hhyearlyincome)
replace hhyearlyincome=180000 	if regexm(playerqincome, "^More than.*£10000$")==1 & regexm(playerqincome, "5000")==0 & mi(hhyearlyincome)

gen hhincome=hhyearlyincome/12

gen equalized_hhincome=hhincome/sqrt(hh_adults+ hh_kids)			

gen income_future_decrease=1 	 if playerqincomefuture=="decrease a lot"
replace income_future_decrease=2 if playerqincomefuture=="decrease somewhat"
replace income_future_decrease=3 if playerqincomefuture=="stay the same"
replace income_future_decrease=4 if playerqincomefuture=="increase somewhat"
replace income_future_decrease=5 if playerqincomefuture=="increase a lot"

gen mem_future=1 if (playerqmemfuture=="with great difficulty")
replace mem_future=2 if (playerqmemfuture=="with some difficulty")
replace mem_future=3 if (playerqmemfuture=="fairly easily")
replace mem_future=4 if (playerqmemfuture=="easily")

gen mem_future_1=(playerqmemfuture=="with great difficulty")
gen mem_future_2=(playerqmemfuture=="with some difficulty")
gen mem_future_3=(playerqmemfuture=="fairly easily")
gen mem_future_4=(playerqmemfuture=="easily")

gen income_decreased=1 	   if playerqincomechange=="decreased a lot"
replace income_decreased=2 if playerqincomechange=="decreased somewhat"
replace income_decreased=3 if playerqincomechange=="stayed the same"
replace income_decreased=4 if playerqincomechange=="increased somewhat"
replace income_decreased=5 if playerqincomechange=="increased a lot"

gen mem_before=1 	 if playerqmembefore=="with great difficulty"
replace mem_before=2 if playerqmembefore=="with some difficulty"
replace mem_before=3 if playerqmembefore=="fairly easily"
replace mem_before=4 if playerqmembefore=="easily"

gen income_decreased_d=(playerqincomechange=="decreased a lot" |  playerqincomechange=="decreased somewhat")

gen income_f_decreased_d=(playerqincomefuture=="decrease a lot" |  playerqincomefuture=="decrease somewhat")


		*** --- Opinions on Covid-19, risk and policies --- ***
		
gen risk_perceived_COVID=1 	   if regexm(playerqcovidrisk, "Most people have no symptoms or only few flu-like symptoms")==1
replace risk_perceived_COVID=2 if regexm(playerqcovidrisk, "Only people with several pre-existing conditions die")==1 
replace risk_perceived_COVID=3 if regexm(playerqcovidrisk, "Older members of the population and risk groups can become seriously ill")==1
replace risk_perceived_COVID=4 if regexm(playerqcovidrisk, "Anyone can become seriously ill after infection with COVID-19.*")==1
replace risk_perceived_COVID=5 if regexm(playerqcovidrisk, "Many people infected with COVID-19 become seriously ill.*")==1
replace risk_perceived_COVID=6 if regexm(playerqcovidrisk, "Most people infected with COVID-19 become seriously ill.*")==1

gen lockdown_perceived_COVID=1     if regexm(playerqlockdown, "There shouldn.* have been any lockdown")==1
replace lockdown_perceived_COVID=2 if regexm(playerqlockdown, "the health benefits of the lockdown do not outweigh the economic risks")==1 
replace lockdown_perceived_COVID=3 if regexm(playerqlockdown, "the health benefits of the lockdown might not outweigh the economic risks")==1 
replace lockdown_perceived_COVID=4 if regexm(playerqlockdown, "The lockdown is necessary to contain the spread")==1 
replace lockdown_perceived_COVID=5 if regexm(playerqlockdown, "No measure is too costly to contain the spread")==1 

gen policies_perceived=1     if playerqpolicies=="much too harsh" 
replace policies_perceived=2 if playerqpolicies=="somewhat too harsh" 
replace policies_perceived=3 if playerqpolicies=="just right" 
replace policies_perceived=4 if playerqpolicies=="somewhat too lax" 
replace policies_perceived=5 if playerqpolicies=="much too lax"

gen errorcasesUTLA=(abs(playerqcasesutlaestimated-cases_utla))/ cases_utla /*the lower, the lower the misestimation. This is better as proposed earlier*/
replace errorcasesUTLA=1 if errorcasesUTLA>1

gen pandemic_UTLA_more=(playerqcasesutlamoresevere=="more severe")
gen pandemic_UTLA_equally=(playerqcasesutlamoresevere=="equally severe")
gen pandemic_UTLA_less=(playerqcasesutlamoresevere=="less severe")

gen errorcasesUK=(abs(playerqcasesukestimated-cases_uk))/ cases_uk /*the lower, the lower the misestimation. This is better as proposed earlier*/
replace errorcasesUK=1 if errorcasesUK>1

gen pandemic_UK_more=(playerqcasesukmoresevere=="more severe")
gen pandemic_UK_equally=(playerqcasesukmoresevere=="equally severe")
gen pandemic_UK_less=(playerqcasesukmoresevere=="less severe")

gen errorcases=(errorcasesUTLA + errorcasesUK)/2 

gen COVID_manmade=(regexm(playerqcovidmanmade, "Coronavirus is man-made")==1)
gen COVID_natural=(regexm(playerqcovidmanmade, "Coronavirus is natural in origin")==1)

gen COVID_on_purpose=(regexm(playerqcovidonpurpose, "Coronavirus was spread on purpose")==1)
gen COVID_unintentional=(regexm(playerqcovidonpurpose, "Coronavirus was spread unintentionally")==1) 

gen pandemic_overcome=playerqcovidovercome/2

gen vaccine_available=playerqvaccine/2 

gen vaccinate=1 if playerqvaccinate=="definitely not"
replace vaccinate=2 if playerqvaccinate=="probably not"
replace vaccinate=3 if playerqvaccinate=="not sure"
replace vaccinate=4 if playerqvaccinate=="rather yes"
replace vaccinate=5 if playerqvaccinate=="definitely yes"


	*** --- Rule followers --- ***

gen contacts_reduced=1     if playerqcontactsreduced == "a lot"
replace contacts_reduced=2 if playerqcontactsreduced == "somewhat"
replace contacts_reduced=3 if playerqcontactsreduced == "not at all"

gen contacts_reduced_lot=	(playerqcontactsreduced == "a lot") 
gen contacts_reduced_somewhat=(playerqcontactsreduced == "somewhat") 
gen contacts_reduced_not=	(playerqcontactsreduced == "not at all")

gen stock_increased_lot=	(playerqbasicstock=="a lot")
gen stock_increased_somewhat=(playerqbasicstock=="somewhat")
gen stock_increased_not=	(playerqbasicstock=="not at all")

gen mask=1 	   if playerqmask=="always"
replace mask=2 if playerqmask=="sometimes"
replace mask=3 if playerqmask=="never"

gen mask_always=	(playerqmask == "always")
gen mask_sometimes=	(playerqmask == "sometimes")
gen mask_never=		(playerqmask == "never") 

gen leave_home_work 				=(playerqleavehome1==1)
gen leave_home_church 				=(playerqleavehome2==1)
gen leave_home_restaurant_cafe		=(playerqleavehome3==1)
gen leave_home_grocery				=(playerqleavehome4==1)
gen leave_home_shopping				=(playerqleavehome5==1)
gen leave_home_dog 					=(playerqleavehome6==1)
gen leave_home_outdoors_alone 		=(playerqleavehome7==1)
gen leave_home_outdoors_other 		=(playerqleavehome8==1)
gen leave_home_doctor_pharmacy		=(playerqleavehome9==1)
gen leave_home_friends_relatives	=(playerqleavehome10==1)
gen leave_home_helping				=(playerqleavehome11==1)
gen leave_home_demonstration		=(playerqleavehome12==1)

gen COVID_rule_follow=1     if playerqfollowrules=="always" |  regexm(playerqfollowrules, "all the rules")==1
replace COVID_rule_follow=2 if playerqfollowrules=="very often" |  regexm(playerqfollowrules, "most of the rules")==1
replace COVID_rule_follow=3 if playerqfollowrules=="sometimes" |  regexm(playerqfollowrules, "some of the rules")==1
replace COVID_rule_follow=4 if playerqfollowrules=="rarely" |  regexm(playerqfollowrules, "generally do not follow the rules")==1
replace COVID_rule_follow=5 if playerqfollowrules=="never" |  regexm(playerqfollowrules, "definitely do not follow the rules")==1

gen COVID_contribution=1     if playerqcovidcontribution=="disagree totally"
replace COVID_contribution=2 if playerqcovidcontribution=="disagree partly"
replace COVID_contribution=3 if playerqcovidcontribution=="neither agree nor disagree"
replace COVID_contribution=4 if playerqcovidcontribution=="agree partly"
replace COVID_contribution=5 if playerqcovidcontribution=="agree totally"

gen serious=length(playerqcovidcontributionhow)
gen logserious =log(serious )
replace serious=logserious


		*** --- Media --- ***
		
gen news_high_quality=(regexm(playerqnews, "The BBC tv station")==1 | playerqnews=="The BBC radio" | regexm(playerqnews, "Print or online versions of The Guardian")==1 | playerqnews=="Government and official news sources")

gen news_medium_quality=(playerqnews=="Other tv stations" | playerqnews=="Other radio stations" | playerqnews=="Print or online versions of other newspapers and magazines")

gen news_low_quality=(playerqnews=="Other online news" | playerqnews=="Search engines and other websites" | playerqnews=="Magazines" | playerqnews=="Friends and family" | playerqnews=="Social media")


		*** --- Health --- ***

gen health_affected=1     if regexm(playerqhealth, "a lot")==1
replace health_affected=2 if regexm(playerqhealth, "somewhat")==1
replace health_affected=3 if regexm(playerqhealth, "not at all")==1

gen health_affected_lot=	 (regexm(playerqhealth, "a lot")==1)
gen health_affected_somewhat=(regexm(playerqhealth, "somewhat")==1)
gen health_affected_not=	 (regexm(playerqhealth, "not at all")==1) 

gen health_faffected=1	   if playerqhealthfuture=="a lot"
replace health_faffected=2 if playerqhealthfuture=="somewhat"
replace health_faffected=3 if playerqhealthfuture=="not at all"

gen health_faffected_lot=	(playerqhealthfuture=="a lot")
gen health_faffected_somewhat=(playerqhealthfuture=="somewhat")
gen health_faffected_not=	(playerqhealthfuture=="not at all") 

gen health_risk=1     if regexm(playerqhealthrisk, "high risk")==1
replace health_risk=2 if regexm(playerqhealthrisk, "moderate risk")==1
replace health_risk=3 if playerqhealthrisk=="neither of the above"

gen health_risk_vhigh=(regexm(playerqhealthrisk, "high risk")==1)
gen health_risk_high=(regexm(playerqhealthrisk, "moderate risk")==1)
gen health_risk_low=(playerqhealthrisk=="neither of the above") 


		*** --- Commute --- ***
		
gen commute_before_days=playerqcommutebefore

gen commute_before_mode_public=(playerqcommutemodebefore == "Public transport") 
gen commute_before_mode_car=(playerqcommutemodebefore == "Private transport") 

gen commute_before_time=1     if playerqcommutetimebefore=="Less than 1 hour"
replace commute_before_time=2 if playerqcommutetimebefore=="Less than 2 hours"
replace commute_before_time=3 if playerqcommutetimebefore=="More than 2 hours"

gen commute_before_less_1=(playerqcommutetimebefore=="Less than 1 hour")
gen commute_before_less_2=(playerqcommutetimebefore=="Less than 2 hours")
gen commute_before_more_2=(playerqcommutetimebefore=="More than 2 hours") 

gen commute_after_days=playerqcommuteafter

gen commute_after_mode_public=(playerqcommutemodeafter == "Public transport") 
gen commute_after_mode_car=(playerqcommutemodeafter == "Private transport") 

gen commute_after_time=1     if playerqcommutetimeafter=="Less than 1 hour" 
replace commute_after_time=2 if playerqcommutetimeafter=="Less than 2 hours"
replace commute_after_time=3 if playerqcommutetimeafter=="More than 2 hours"

gen commute_after_less_1=(playerqcommutetimeafter=="Less than 1 hour")
gen commute_after_less_2=(playerqcommutetimeafter=="Less than 2 hours")
gen commute_after_more_2=(playerqcommutetimeafter=="More than 2 hours") 

gen distance_work=1     if playerqdistancework == "Always"
replace distance_work=2 if playerqdistancework == "Mostly"
replace distance_work=3 if playerqdistancework == "Rarely"
replace distance_work=4 if playerqdistancework == "Never"
 
gen distance_always=(playerqdistancework=="Always")
gen distance_mostly=(playerqdistancework=="Mostly")
gen distance_rarely=(playerqdistancework=="Rarely")
gen distance_never=(playerqdistancework=="Never") 


		*** --- Work --- ***

gen smallplayerqworkchangetext = lower(playerqworkchangetext)

gen changetext_permanently_laid_off=1 if strpos(smallplayerqworkchangetext , "laid off") | ///
	strpos(smallplayerqworkchangetext , "close") | ///
	strpos(smallplayerqworkchangetext , "furloughed") | ///
	strpos(smallplayerqworkchangetext , "lost a job") | ///
	strpos(smallplayerqworkchangetext , "end") | ///
	strpos(smallplayerqworkchangetext , "finished") | ///
	strpos(smallplayerqworkchangetext , "lay off") | ///
	strpos(smallplayerqworkchangetext , "reduction in employees")  | ///
	strpos(smallplayerqworkchangetext , "forlough")  | ///
	strpos(smallplayerqworkchangetext , "lost one job") | ///
	strpos(smallplayerqworkchangetext , "lost job")
 
gen changetext_laid_off_with_pay=1 if strpos(smallplayerqworkchangetext , "salary") | ///
	strpos(smallplayerqworkchangetext , "pay rates cut") | ///
	strpos(smallplayerqworkchangetext , "%") | ///
	strpos(smallplayerqworkchangetext , "sighed off")

gen changetext_laid_off_without_pay=1 if strpos(smallplayerqworkchangetext , "without pay") 

gen changetext_reduced_hours=1 if  strpos(smallplayerqworkchangetext , "reduced") 
 
gen changetext_increased_hours=1 if strpos(smallplayerqworkchangetext , "incresed") | ///
	strpos(smallplayerqworkchangetext , "extra hours") 

gen changetext_start_of_a_new_job=1 if strpos(smallplayerqworkchangetext , "finding work") | ///
	strpos(smallplayerqworkchangetext , "postponed") | ///
	strpos(smallplayerqworkchangetext , "offer") | ///
	strpos(smallplayerqworkchangetext , "new job") 

		
gen work_change=1 if playerqworkchange=="I have been permanently layed off" | ///
					 playerqworkchange=="Permanently layed off" | ///
					 playerqworkchange=="Permanently laid off" | ///
					 changetext_permanently_laid_off==1
replace work_change=2 if playerqworkchange=="I have been temporarily layed off (without pay)" | ///
						 playerqworkchange=="Temporarily layed off (without pay)" | ///
						 playerqworkchange=="Temporarily laid off (without pay)" | ///
						 changetext_laid_off_without_pay==1
replace work_change=3 if playerqworkchange=="I have been temporarily layed off (with pay)" | ///
						 playerqworkchange=="Temporarily layed off (with pay)" | ///
						 playerqworkchange=="Temporarily laid off (with pay)" |	///
						 changetext_laid_off_with_pay==1
replace work_change=4 if playerqworkchange=="I am working reduced hours" | ///
						 playerqworkchange=="Reduced number of working hours" | ///
						 changetext_reduced_hours==1 | ///
						 playerqworkchangetext=="Self-employed - I have had to keep working, but on very reduced pay, and with a great deal of lost work."
replace work_change=5 if playerqworkchange=="None of the above" | ///
						 playerqworkchange=="I am working the same number of hours as before" | ///
						 playerqworkchangetext=="Working from home and in school"
replace work_change=6 if playerqworkchange=="I am working more hours than before" | ///
						 playerqworkchange=="Increased number of working hours" | ///
						 changetext_increased_hours==1
replace work_change=7 if playerqworkchange=="Start of a new job" | ///
						 changetext_start_of_a_new_job==1

gen work_change_lost_prm=(playerqworkchange=="I have been permanently layed off" | ///
						  playerqworkchange=="Permanently layed off" | ///
						  playerqworkchange=="Permanently laid off"  | ///
						  changetext_permanently_laid_off==1)

gen work_change_lost_tmpwithoutp=(playerqworkchange=="I have been temporarily layed off (without pay)" | ///
								  playerqworkchange=="Temporarily layed off (without pay)" | ///
								  playerqworkchange=="Temporarily laid off (without pay)" | ///
								  changetext_laid_off_without_pay==1)

gen work_change_lost_tmpwithp=	(playerqworkchange=="I have been temporarily layed off (with pay)" | ///
								 playerqworkchange=="Temporarily layed off (with pay)" | ///
								 playerqworkchange=="Temporarily laid off (with pay)" | ///
								 changetext_laid_off_with_pay==1)

gen work_change_reduced=(playerqworkchange=="I am working reduced hours" | ///
						 playerqworkchange=="Reduced number of working hours" | ///
						 changetext_reduced_hours==1)

gen work_change_no=(playerqworkchange=="None of the above" | ///
					playerqworkchange=="I am working the same number of hours as before")

gen work_change_more=(playerqworkchange=="I am working more hours than before" | ///
					  playerqworkchange=="Increased number of working hours" | ///
					  changetext_increased_hours==1)

gen work_started=(playerqworkchange=="Start of a new job" | changetext_start_of_a_new_job==1)
		
gen remote_work=1 	  if regexm(playerqremotework, "I work .or can work. fully remotely")==1
replace remote_work=2 if regexm(playerqremotework, "this option is only sometimes available")==1
replace remote_work=3 if regexm(playerqremotework, "I do not have the option")==1
replace remote_work=4 if playerqremotework=="Not applicable"

gen remote_fully=  (regexm(playerqremotework, "I work .or can work. fully remotely")==1)
gen remote_partly= (regexm(playerqremotework, "this option is only sometimes available")==1)
gen remote_no=     (regexm(playerqremotework, "I do not have the option")==1)
gen not_applicable=(playerqremotework=="Not applicable") 

gen work_loss= (work_change_lost_prm==1 | work_change_lost_tmpwithoutp==1 | work_change_lost_tmpwithp==1 | work_change_reduced==1)


		*** --- GDP/poverty --- ***
		
gen gdpdifference=-playerqgdpuk+1.4-3.7+ playerqgdpdeveloping 

gen povertydifference=playerqpoveryuk-22+23 -playerqpoverydeveloping 


		*** --- Donations --- ***

gen donationshareUK=1-playerglobal_share

gen initialUKshare=1-playerinitial_global_share
		
gen donationUK=playerdonation - playerglobal_donation if playerdonation!=0 & playerglobal_donation<=playerdonation 
replace donationUK=(100 - playerglobal_donation)/100 if playerdonation==0 

gen playerdonation_d=(playerdonation>0) 

gen playerdonation_p=playerdonation if playerdonation>0

gen donationshareUK_0=donationshareUK if playerdonation==0

gen donationshareUK_1=donationshareUK if playerdonation>0


		*** --- Fixed effects --- ***

destring session , gen(week) i(S a b)
replace week=week+4 if week>=13

tab week, gen(weekd)

tab location_region_id, gen(location_region_idd)

foreach var in  weekd1 weekd2 weekd3 weekd4 weekd5 weekd6 weekd7 weekd8 weekd9 weekd10 weekd11 weekd12 weekd13 weekd14 weekd15 weekd16 weekd17 weekd18 weekd19 weekd20 weekd21 {
foreach z in location_region_idd1 location_region_idd2 location_region_idd3 location_region_idd4 location_region_idd5 location_region_idd6 location_region_idd7 location_region_idd8 location_region_idd9{
gen `var'`z'=`var'*`z'
}
}		


********************************************************************************
*							   scores
********************************************************************************

gen COVID_sceptic = risk_perceived_COVID + lockdown_perceived_COVID + policies_perceived + pandemic_overcome + vaccine_available + vaccinate 
replace COVID_sceptic=COVID_sceptic + 5 if COVID_manmade==1
replace COVID_sceptic=COVID_sceptic + 1 if COVID_natural==1
replace COVID_sceptic=COVID_sceptic + 5 if COVID_on_purpose==1
replace COVID_sceptic=COVID_sceptic + 1 if COVID_unintentional==1

lnskew0 lnskewCOVID_sceptic=COVID_sceptic

foreach i of numlist 1/12 {
gen temp_leavehome`i'=(playerqleavehome`i'==1)
	if `i'==6 | `i'==11 {
	recode temp_leavehome`i' (1=2)
	}	
	if `i'==5 | `i'==8 {
	recode temp_leavehome`i' (1=3)
	}
}

egen leave_home_score=rowtotal(temp_leavehome1-temp_leavehome12)

drop temp_leavehome*

gen COVID_behavior_score =  (contacts_reduced + mask + COVID_rule_follow)
replace COVID_behavior_score = COVID_behavior_score + 1 if leave_home_score <= 5
replace COVID_behavior_score = COVID_behavior_score + 2 if leave_home_score > 5 & leave_home_score <= 10
replace COVID_behavior_score = COVID_behavior_score + 3 if leave_home_score > 10

gen economic_risk_score = income_category*3/ (hh_adults + hh_kids/2) + income_decreased + income_future_decrease + mem_before + mem_future + work_change 

gen health_score= health_affected+ health_faffected + health_risk

gen distancing=remote_work + distance_work 
replace distancing=distancing + commute_before_days*commute_before_time*commute_before_mode_public if commute_before_days>0
replace distancing=distancing 	+ commute_after_days*commute_after_time*commute_after_mode_public if commute_after_days>0

gen empathy=(300-playerqempathy2 -playerqempathy4 -playerqempathy5+playerqempathy1+playerqempathy3+playerqempathy6 + playerqempathy7)/100

destring socioeconomicstatus, force replace		
destring householdsize, force replace			
replace householdsize=hh_adults+hh_kids if householdsize==.	

		
********************************************************************************
*						interaction effect
********************************************************************************

gen treatment_casesper100=treatment*casesper100

gen treatment_casesper100_7days=treatment*casesper100_7days

gen treatment_casesper100_estimated=treatment*casesper100_estimated

gen treatment_deathsper100=treatment*deathsper100

gen treatment_deathsper100_7days=treatment*deathsper100_7days

gen treatment_casesnormal100=treatment*casesnormal100

gen treatment_sceptic=treatment*lnskewCOVID_sceptic 

gen treatment_behavior_score=treatment*COVID_behavior_score

gen treatment_gdpdifferenc=treatment*gdpdifference

gen treatment_povertydifference=treatment*povertydifference

gen treatment_pandemic_UK_more=treatment*pandemic_UK_more


********************************************************************************
*							exclusion criteria
********************************************************************************

gen exclusion=(time_taken<300)
replace exclusion=exclusion+1 if time_taken>1500
replace exclusion=exclusion+1 if playerqcasesukestimated>30000000
replace exclusion=exclusion+1 if playerqcasesukestimated<30000
replace exclusion=exclusion+1 if playerqcasesutlaestimated>playerqcasesukestimated/10
replace exclusion=exclusion+1 if hh_adults+hh_kids>8
replace exclusion=exclusion+1 if playerqpoveryuk<10
replace exclusion=exclusion+1 if playerqpoverydeveloping<10
replace exclusion=exclusion+1 if playerqgdpuk>10 
replace exclusion=exclusion+1 if currentukareaofresidence !=region
replace exclusion=exclusion+1 if (regexm(householdincomegbp, "Less than .*£10,000")==1 | regexm(householdincomegbp, ".*£10,000 - .*£15,999")==1) & regexm(playerqincome, "^Up to.*2000")!=1 & !mi(householdincomegbp)  & !mi(playerqincome)
replace exclusion=exclusion+1 if (regexm(householdincomegbp, ".*£20,000 - .*£29,999")==1 | regexm(householdincomegbp, ".*£30,000 - .*£39,999")==1 | regexm(householdincomegbp, ".*£40,000 - .*£49,999")==1 | regexm(householdincomegbp, ".*£50,000 - .*£59,999")==1) & regexm(playerqincome, "2000 up to.*5000")!=1 & !mi(householdincomegbp) & !mi(playerqincome)
replace exclusion=exclusion+1 if (regexm(householdincomegbp, ".*£60,000 - .*£69,999")==1 | regexm(householdincomegbp, ".*£70,000 - .*£79,999")==1 | regexm(householdincomegbp, ".*£80,000 - .*£89,999")==1 | regexm(householdincomegbp, ".*£90,000 - .*£99,999")==1 | regexm(householdincomegbp, ".*£100,000 - .*£149,999")==1) & regexm(playerqincome, "5000 up to.*10000")!=1 & !mi(householdincomegbp) & !mi(playerqincome)
replace exclusion=exclusion+1 if (regexm(householdincomegbp, ".*£100,000 - .*£149,999")==1 | regexm(householdincomegbp, "Above .*£150,000")==1) & regexm(playerqincome, "^More than.*10000$")!=1 & regexm(playerqincome, "5000")==0 & !mi(householdincomegbp) & !mi(playerqincome)
destring householdsize, force replace
replace exclusion=exclusion+1 if (householdsize!=hh_adults+hh_kids & householdsize!=hh_adults+hh_kids+1 & householdsize!=hh_adults+hh_kids-1) & householdsize!=.
replace exclusion=exclusion+1 if (playerqstatus=="Employed or self-employed" | playerqstatus=="Employed") & (employmentstatus!="Full-Time" | employmentstatus!="Part-Time") & !mi(playerqstatus) & !mi(employmentstatus) & employmentstatus!="DATA EXPIRED"
replace exclusion=exclusion+1 if playerqstatus!="Unemployed but actively looking for work" & employmentstatus=="Unemployed (and job seeking)" & !mi(playerqstatus) & !mi(employmentstatus)
	
