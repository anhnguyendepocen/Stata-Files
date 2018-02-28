clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\PS2.log", replace 

*** START ***

* Variables of Interest:
* murder rate, violent crime rate, robbery rate,
* assault rate, burglary rate, larceny rate, auto theft rate
* Key Explanatory Variables:
* execution rate, insured unemployment rate, black, urban, 
* age demographics, infant mortality

bcuse statecrime, clear
xtset stid year
rename pc_mur murderRate
rename cri_viol violentCrimeRate
rename pc_assa assaultRate
rename pc_burg burglaryRate
rename pc_larc larcenyRate
rename pc_auto autoTheftRate
rename pc_rob robberyRate
rename r_execut executionRate
rename r_death prisonMortality
rename r_ue unemploymentRate
rename r_black percentBlack
rename r_urban percentUrban
rename r_infd infantDeathRate
describe executionRate prisonMortality murderRate violentCrimeRate assaultRate burglaryRate larcenyRate autoTheftRate robberyRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64

xtreg murderRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg violentCrimeRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg assaultRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg burglaryRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg larcenyRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg autoTheftRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg robberyRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust

xtreg murderRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg violentCrimeRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg assaultRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg burglaryRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg larcenyRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg autoTheftRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
xtreg robberyRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust

eststo: quietly xtreg murderRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg violentCrimeRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg assaultRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg burglaryRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg larcenyRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg autoTheftRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg robberyRate executionRate prisonMortality unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
esttab, se

eststo: quietly xtreg murderRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg violentCrimeRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg assaultRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg burglaryRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg larcenyRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg autoTheftRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
eststo: quietly xtreg robberyRate executionRate unemploymentRate percentBlack percentUrban infantDeathRate r_0_14 r_15_24 r_25_44 r_45_64, fe robust
esttab, se

log close 
exit
