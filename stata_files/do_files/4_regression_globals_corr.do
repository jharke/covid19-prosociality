********************************************************************************
*							 4) Regression globals
********************************************************************************

global H1controls " playerinitial_donation"

global H2controls " treatment playerinitial_donation"

global H3controls " initialUKshare"

global H4controls " treatment initialUKshare"

global basecontrols " age UKbirth female socioeconomicstatus householdsize "
global basecontrols_I " age UKbirth female socioeconomicstatus householdsize "

global financialcontrols " hhincome mem_future_1 mem_future_2 mem_future_3  i.income_decreased i.income_future_decrease i.mem_before"
global financialcontrols_I " hhincome mem_future_1 mem_future_2 mem_future_3  _Iincome_d* _Iincome_f* _Imem_b*" 

global health " health_faffected_lot health_faffected_somewhat health_affected_lot health_affected_somewhat health_risk_vhigh health_risk_high"

global areacontrols " age16_19per100 age20_24per100 age25_34per100 age35_49per100 age50_64per100 age65plusper100 lnskewgood_healthper100 lnskewfair_healthper100 lnskewbad_healthper100 lnskewjobs_density annual_pay hourly_pay hours_worked lnskewNHSper100 lnskewagricultureper100 lnskewminingper100 lnskewmanufacturingper100 lnskewconstructionper100 lnskewmotor_tradesper100 lnskewwholesaleper100 lnskewretailper100 lnskewtransportper100 lnskewaccommodationper100 lnskewinformationper100 lnskewfinancialper100 lnskewpropertyper100 lnskewprofessionalper100 lnskewbusinessper100 lnskewpublicper100 lnskeweducationper100 lnskewhealthper100 lnskewartsper100 lnskewpopdensity" 

global perceivedimportance " gdpdifference povertydifference pandemic_UK_more pandemic_UK_equally"
global timecontrols " i.session "
global timecontrols_I "  _Isession_2 _Isession_3 _Isession_4 _Isession_5 _Isession_6 _Isession_7 _Isession_8 _Isession_9 _Isession_10 _Isession_11 _Isession_12 _Isession_13 _Isession_14 _Isession_15 _Isession_16 _Isession_17 _Isession_18 _Isession_19 _Isession_20 _Isession_21 _Isession_22 "



global socio " place_big_city place_small_city place_suburbs  status_employed status_unemployed status_student status_apprentice status_retired hh_kids  news_high_quality news_medium_quality "

global workchange " work_change_lost_prm work_change_lost_tmpwithoutp work_change_lost_tmpwithp work_change_reduced commute_before_days commute_after_days  remote_fully remote_partly"

global outcomes " playerdonation playerdonation_d playerdonation_p donationshareUK donationshareUK_0 donationshareUK_1"

global main " casesnormal playerinitial_donation playerinitial_global_share age UKbirth female socioeconomicstatus householdsize hhincome"

