********************************************************************************
*							 3) Applying labels to data
********************************************************************************

lab var treatment "COVID-19 reference"
lab def l_treatment 0 "Control" 1 "Treatment"
lab values treatment l_treatment
lab var casesnormal100 "Relative local severity of the pandemic"
lab var casesnormal "Relative local severity"


		*** --- UTLA information --- ***

lab var age16_19per100 "People aged 16 to 19 per 100 inhabitants"
lab var age20_24per100 "People aged 20 to 24 per 100 inhabitants"
lab var age25_34per100 "People aged 25 to 34 per 100 inhabitants"
lab var age35_49per100 "People aged 35 to 49 per 100 inhabitants"
lab var age50_64per100 "People aged 50 to 64 per 100 inhabitants"
lab var age65plusper100 "People aged over 65 per 100 inhabitants"
lab var casesper100 "COVID-19 cases"
lab var casesper100_7days "COVID-19 cases, last 7 days, per 100,000"
lab var  cases_utla_7_daysin1000 "COVID-19 cases, last 7 days, in tsd."
lab var lnskewgood_healthper100 "People in good health per 100 inhabitants, zero-skewness log of"
lab var lnskewfair_healthper100 "People in fair health per 100 inhabitants, zero-skewness log of" 
lab var lnskewbad_healthper100 "People in bad health per 100 inhabitants, zero-skewness log of"
lab var lnskewjobs_density "Job density, zero-skewness log of"
lab var annual_pay "Mean annual pay for full-time workers"
lab var hourly_pay "Mean hourly pay for full-time workers"
lab var hours_worked "Mean work hours for full-time workers"
lab var lnskewNHSper100 "Number of NHS hopitals per 100 inhabitants, zero-skewness log pf"
lab var lnskewagricultureper100 "Employees in agriculture per 100 inhabitants, zero-skewness log of"
lab var lnskewminingper100 "Employees in mining per 100 inhabitants, zero-skewness log of"
lab var lnskewmanufacturingper100 "Employees in manufacturing per 100 inhabitants, zero-skewness log of"
lab var lnskewconstructionper100 "Employees in construction per 100 inhabitants, zero-skewness log of"
lab var lnskewmotor_tradesper100 "Employees in motor trades per 100 inhabitants, zero-skewness log of"
lab var lnskewwholesaleper100 "Employees in whole sales per 100 inhabitants, zero-skewness log of"
lab var lnskewretailper100 "Employees in retail per 100 inhabitants, zero-skewness log of"
lab var lnskewtransportper100 "Employees in transportation per 100 inhabitants, zero-skewness log of"
lab var lnskewaccommodationper100 "Employees in accommodation and food service per 100 inhabitants, zero-skewness log of"
lab var lnskewinformationper100 "Employees in information information per 100 inhabitants, zero-skewness log of"
lab var lnskewfinancialper100 "Employees in finance per 100 inhabitants, zero-skewness log of"
lab var lnskewpropertyper100 "Employees in real estate per 100 inhabitants, zero-skewness log of"
lab var lnskewprofessionalper100 "Employees in science and technology per 100 inhabitants, zero-skewness log of"
lab var lnskewbusinessper100 "Employees in administration and support service per 100 inhabitants, zero-skewness log of"
lab var lnskewpublicper100 "Employees in public administration per 100 inhabitants, zero-skewness log of"
lab var lnskeweducationper100 "Employees in education per 100 inhabitants, zero-skewness log of"
lab var lnskewhealthper100 "Employees in health-care and social work per 100 inhabitants, zero-skewness log of"
lab var lnskewartsper100 "Employees in arts per 100 inhabitants, zero-skewness log of"
lab var articles_wide_mwe_surrounding_co "Number of articles"
lab var articles10 "Articles"
 
       		
		*** --- Demografic information --- ***

lab var age "Age"
lab var age_cat "Age"
lab def l_Agecat 1 "18-24" 2 "25-34" 3 "35-49" 4 "50-64" 5 "65+"
lab values age_cat l_Agecat
lab var female "Female"
lab var gender "Gender"
lab def l_Gender 2 "male" 1 "female"
lab values gender l_Gender
lab var UKbirth "Born in UK"
lab var firstlanguageenglish "First language English"
lab var place_big_city "Big city"
lab var place_small_city "Small city"
lab var place_suburbs "Suburbs"
lab var place_rural "Rural"
lab var status_employed "Employed"
lab var status_unemployed "Unemployed but actively looking for work"
lab var status_student "Student"
lab var status_apprentice "Apprentice"
lab var status_retired "Retired"
lab var status_inactive "Not in the workforce for health or family reasons"
lab var serious "Length of open field entry, log of"


		*** --- Income and economic status --- ***
		
lab var socioeconomicstatus "Socio-economic status"
lab var householdsize "Household members"		
lab var hh_adults "Number of adults in houshold"
lab var hh_kids "Number of children in houshold"
lab var income_category "Income category"
lab def l_IncomeCategory 1 "Less than £10,000" 2 "£10,000 - £15,999" 3 "£16,000 - £19,999" 4 "£20,000 - £29,999" 5 "£30,000 - £39,999" 6 "£40,000 - £49,999" 7 "£50,000 - £59,999" 8 "£60,000 - £69,999" 9 "£70,000 - £79,999" 10 "£80,000 - £89,999" 11 "£90,000 - £99,999" 12 "£100,000 - £149,999" 13 "Above £150,000"
lab values income_category l_IncomeCategory
lab var income_category_1 "Less than £10,000"
lab var income_category_2 "£10,000 - £15,999"
lab var income_category_3 "£16,000 - £19,999"
lab var income_category_4 "£20,000 - £29,999"
lab var income_category_5 "£30,000 - £39,999"
lab var income_category_6 "£40,000 - £49,999"
lab var income_category_7 "£50,000 - £59,999"
lab var income_category_8 "£60,000 - £69,999"
lab var income_category_9 "£70,000 - £79,999"
lab var income_category_10 "£80,000 - £89,999"
lab var income_category_11 "£90,000 - £99,999"
lab var income_category_12 "£100,000 - £149,999"
lab var income_category_13 "Above £150,000"
lab var hhyearlyincome "Annual household income"
lab var hhincome	"Household income"	
lab var equalized_hhincome "Equalized monthly household income"
lab var income_future_decrease "Expected change in household income"
lab def l_IncomeFutureDecrease 1 "decrease a lot" 2 "decrease somewhat" 3 "stay the same" 4 "increase somewhat" 5 "increase a lot"
lab values income_future_decrease l_IncomeFutureDecrease 
lab var mem_future "Making ends meet since COVID-19"
lab def l_Mem 1 "great difficulty" 2 "some difficulty" 3 "fairly easily" 4  "easily"
lab values  mem_future l_Mem
lab var mem_future_1 "Making ends meet since COVID-19: great difficulty"
lab var mem_future_2 "Making ends meet since COVID-19: some difficulty"
lab var mem_future_3 "Making ends meet since COVID-19: fairly easily"
lab var mem_future_4 "Making ends meet since COVID-19: easily"
lab var income_decreased "Change in household income since COVID-19"
label def l_IncomeDecreased 1 "decreased a lot" 2 "decreased somewhat" 3 "stayed the same" 4 "increased somewhat" 5 "increased a lot"
lab values income_decreased l_IncomeDecreased
lab var mem_before "Making ends meet before COVID-19"
lab values mem_before l_Mem
label var income_decreased_d "Dummy income decreased since the outbreak of the pandemic"
label var income_f_decreased_d"Dummy income expected to decrease in the next 12 months"
label var work_loss "Work situation negatively affected"

		
		*** --- Opinions on COVID-19, risk and policies --- ***
		
lab var risk_perceived_COVID "Perceived risk of COVID-19"
lab def l_RiskPerceivedCOVID 1 "Most people have no symptoms or only few flu-like symptoms" 2 "Only people with several pre-existing conditions die" 3 "Older members of the population and risk groups can become seriously ill" 4 "Anyone can become seriously ill" 5 "Many people infected with COVID-19 become seriously ill" 6 "Most people infected with COVID-19 become seriously ill"
lab values risk_perceived_COVID l_RiskPerceivedCOVID
lab var lockdown_perceived_COVID "Perception of COVID-19 lockdown"
lab def l_LockdownPerceivedCOVID 1 "There shouldn't have been any lockdown" 2 "The health benefits of the lockdown do not outweigh the economic risks" 3 "The health benefits of the lockdown might not outweigh the economic risks" 4 "Lockdown is necessary to contain the spread" 5 "No measure is too costly to contain the spread"
lab values lockdown_perceived_COVID l_LockdownPerceivedCOVID
lab var policies_perceived "perception of COVID-19 policies"
lab def	l_PoliciesPerceived 1 "Much too harsh"  2 "Somewhat too harsh" 3 "Just right" 4 "Somewhat too lax" 5 "Much too lax"
lab values policies_perceived l_PoliciesPerceived
lab var errorcasesUTLA "Misestimation of confirmed COVID-19 cases in UTLA"
lab var pandemic_UTLA_more "UTLA more affected by COVID-19 than other areas in England"
lab var pandemic_UTLA_equally "UTLA equally affected by COVID-19 as other areas in England"
lab var pandemic_UTLA_less "UTLA less affected by COVID-19 than other areas in England"
lab var errorcasesUK "Misestimation of confirmed COVID-19 cases in UK"
lab var pandemic_UK_more "UK more affected"
lab var pandemic_UK_equally "UK equally affected"
lab var pandemic_UK_less "UK less affected"
lab var errorcases "Mean estimation error of COVID-19 cases in UTLA and UK"
lab var COVID_manmade "Agree: COVID-19 is man-made dummy "
lab var COVID_natural "Agree: COVID-19 is natural in origin"
lab var COVID_on_purpose "Agree: COVID-19 was spread on purpose"
lab var COVID_unintentional "Agree: Coronavirus was spread unintentionally"
lab var pandemic_overcome "Months till COVID-19 will be overcome in UK" 
lab var vaccine_available "Months till vaccine against COVID-19 will be widely available in UK" 
lab var vaccinate "Willingness to get vaccinated against COVID-19"
lab def l_Vaccinate 1 "Definitely not" 2 "Probably not" 3 "Not sure" 4 "Rather yes" 5 "Definitely yes"
lab values vaccinate l_Vaccinate 


		*** --- Rule followers --- ***

lab var contacts_reduced "Reduced social contacts outside of household"
lab def l_ContactsReduced 1 "A lot" 2 "Somewhat" 3 "Not at all"
lab values contacts_reduced l_ContactsReduced
lab var contacts_reduced_lot "Reduced social contacts outside of household: a lot"
lab var contacts_reduced_somewhat "Reduced social contacts outside of household: somewhat"
lab var contacts_reduced_not "Reduced social contacts outside of household: not at all"
lab var stock_increased_lot "Stocked up on basic necessities/ medication/ sanitary products: a lot"
lab var stock_increased_somewhat "Stocked up on basic necessities/ medication/ sanitary products: somewhat"
lab var stock_increased_not "Stocked up on basic necessities/ medication/ sanitary products: not at all"
lab var mask "Wore mask when leaving home"
lab def l_Mask 1 "Always" 2 "Sometimes" 3 "Never"
lab values mask l_Mask 
lab var mask_always "Wore mask when leaving home: always"
lab var mask_sometimes "Wore mask when leaving home: sometimes"
lab var mask_never "Wore mask when leaving home: never"
lab var leave_home_church "Reason to leave house: attend church services"
lab var leave_home_restaurant_cafe "Reason to leave house: restaurant or café"
lab var leave_home_work	"Reason to leave house: work"
lab var leave_home_grocery "Reason to leave house: basic grocery shopping"
lab var leave_home_shopping "Reason to leave house: other shopping"
lab var leave_home_outdoors_alone "Reason to leave house: physical activity outdoors alone"
lab var leave_home_doctor_pharmacy "Reason to leave house: doctor or pharmacy"
lab var leave_home_friends_relatives "Reason to leave house: meet friends or relatives"
lab var leave_home_dog "Reason to leave house: walk a dog"
lab var leave_home_helping "Reason to leave house: help neighbours or family in need"
lab var COVID_rule_follow "Extent of following rules and recommendations regarding COVID-19"
lab def l_COVIDRuleFollow 1 "All rules and recommendations" 2 "Most rules and recommendations" 3 "Some rules and recommendations" 4 "Generally not following rules and recommendations" 5 "Never following rules and recommendations"
lab values COVID_rule_follow l_COVIDRuleFollow 
lab var COVID_contribution "Agreement on having done one's bit to prevent and tackle COVID-19"
lab def l_COVIDContribution 1 "Disagree totally" 2 "Disagree partly" 3 "Neither agree nor disagree" 4 "Agree partly" 5 "Agree totally"
lab values COVID_contribution l_COVIDContribution


		*** --- Media --- ***

lab var news_high_quality "Main news sources: hight quality"
lab var news_medium_quality "Main news sources: medium quality"
lab var news_low_quality "Main news sources: low quality"


		*** --- Health --- ***

lab var health_affected "Personal health or health of family negatively affected by COVID-19"
lab def		l_HealthAffected 1 "a lot" 2 "somewhat" 3 "not at all"
lab values	health_affected l_HealthAffected
lab var health_affected_lot "Health negatively affected by COVID-19: a lot"
lab var health_affected_somewhat "Health negatively affected by COVID-19: somewhat"
lab var health_affected_not "Health negatively affected by COVID-19: not at all"
lab var health_faffected "Expected negative impact on health"
lab values	health_faffected l_HealthAffected
lab var health_faffected_lot "Expected negative impact on health: a lot"
lab var health_faffected_somewhat "Expected negative impact on health: somewhat"
lab var health_faffected_not "Expected negative impact on health: not at all"
lab var health_risk "Vulnerability to COVID-19"
lab def l_Risk 1 "high risk" 2 "moderate risk" 3 "low risk"
lab values health_risk l_Risk 
lab var health_risk_vhigh "Vulnerability to COVID-19: high risk"
lab var health_risk_high "Vulnerability to COVID-19: moderate risk"
lab var health_risk_low "Vulnerability to COVID-19: low risk"


		*** --- Commute --- ***
		
lab var commute_before_days "Days per week commuting to work or university before COVID-19"
lab var commute_before_mode_public "Mode of transportation before COVID-19: public transport"
lab var commute_before_mode_car "Mode of transportation before COVID-19: private transport"
lab var commute_before_time "Commuting time before COVID-19"
lab def l_CommuteTime 1 "Less than 1 hour" 2 "Less than 2 hours" 3 "More than 2 hours"
lab values commute_before_time l_CommuteTime
lab var commute_before_less_1 "Commuting time before COVID-19: less than 1 hour"
lab var commute_before_less_2 "Commuting time before COVID-19: less than 2 hours"
lab var commute_before_more_2 "Commuting time before COVID-19: more than 2 hours"
lab var commute_after_days "Days per week commuting to work or university since COVID-19"
lab var commute_after_mode_public "Mode of transportation since COVID-19: public transport"
lab var commute_after_mode_car "Mode of transportation since COVID-19: private transport"
lab var commute_after_time
lab values commute_after_time l_CommuteTime
lab var commute_after_less_1 "Commuting time since COVID-19: less than 1 hour"
lab var commute_after_less_2 "Commuting time since COVID-19: less than 2 hours"
lab var commute_after_more_2 "Commuting time since COVID-19: more than 2 hours"
lab var distance_work "maintaining social distancing outside household"
lab def l_DistanceWork 1 "Always" 2 "Mostly" 3 "Rarely" 4 "Never"
lab values distance_work l_DistanceWork
lab var distance_always "Maintaining social distancing outside household: always"
lab var distance_mostly "Maintaining social distancing outside household: mostly"
lab var distance_rarely "Maintaining social distancing outside household: rarely"
lab var distance_never "Maintaining social distancing outside household: never"


		*** --- Work --- ***

lab var work_change "Change in work situation since COVID-19"
lab def l_WorkChange 1 "Permanently layed off" 2 "Temporarily layed off (without pay)" 3 "Temporarily layed off (with pay)" 4 "Not working now still employed" 5 "Working reduced hours" 6 "Working the same number of hours as before" 7 "Working more hours than before" 8 "Started working"
lab values work_change l_WorkChange 
lab var remote_work "Working remotely"
lab def l_RemoteWork 1 "Work or can work fully remotely" 2 "Sometimes available" 3 "Not an option" 4 "Not applicable"
lab values remote_work l_RemoteWork
lab var remote_fully "Working remotely: fully"
lab var remote_partly "Working remotely: sometimes"
lab var remote_no "Working remotely: not an option"
lab var not_applicable "Working remotely: not applicable"
	
	
		*** --- Donations --- ***

lab var playerdonation "Donation amount"	
lab var playerinitial_donation "Initial slider position"	
lab var gdpdifference "GDP in UK vs. in developing countries"		
lab var povertydifference "Poverty in UK vs. in developing countries"
lab var donationshareUK "Donation share between UK and developing countries"
lab var initialUKshare "Initial slider position: donation share to UK"
lab var playerglobal_donation "Donation to the world program in pounds"
lab var donationUK "Donation to the UK program in pounds"
lab var playerdonation "Donation choice: overall amount"	
lab var playerdonation_d "share of donors" 
lab var playerdonation_p "positive amount"
lab var donationshareUK   "Donation share to UK project: overall" 
lab var donationshareUK_0 "if donation equal to zero" 
lab var donationshareUK_1 "if donation positive"
lab var playerinitial_donation "Initial slider: donation"
lab var playerinitial_global_share "Initial slider: share UK"


		*** --- Scores --- ***
		
lab var lnskewCOVID_sceptic "Scepticism score, zero-skewness log of"
lab var COVID_behavior_score	"Behavior score"	
lab var economic_risk_score "Economic risk score"
lab var health_score "Health score"
lab var distancing "Distancing score"
lab var empathy "Empathy score"
	
	
		*** --- Interaction effects --- ***

lab var treatment_casesper100 "Treatment effect x confirmed COVID-19 cases per 100 inhabitants"
lab var treatment_sceptic "Treatment effect x scepticism score"
lab var treatment_behavior_score "Treatment effect x behavior score"
lab var treatment_casesnormal100 "COVID-19 reference * local severity"	
lab var treatment_gdpdifferenc "Treatment effect x difference in expected GDP development"
lab var treatment_povertydifference "Treatment effect x difference in expected poverty development"
lab var treatment_pandemic_UK_more "Treatment effect x opinion: UK more affected by COVID-19"

