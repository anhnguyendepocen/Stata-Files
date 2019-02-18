clear
eststo clear                                                                     
set more off 
capture log close 
log using ".\Analysis.log", replace 
use "U:\706 Project\mydata.dta", clear
* ssc install ftools
* ssc install reghdfe
* Data cleaning performed in "Cleaning.R"


********** Renaming Variables **********

rename hhid HHID
label variable HHID "Household Identifier" 
rename age Age
label variable Age "Age" 
rename gender Male
label variable Male "Male" 
rename yrseduc Education
label variable Education "Education" 
rename hhsize_0_1 HH_Size_0_1
label variable HH_Size_0_1 "Household Size 0-1"
rename hhsize_2_5 HH_Size_2_5
label variable HH_Size_2_5 "Household Size 2-5"
rename hhsizem HH_Size
label variable HH_Size "Household Size 6+" 
rename mxhea Health
label variable Health "Healthcare" 
rename mxinsur Insurance
label variable Insurance "Insurance" 
rename totminc Income
label variable Income "Income"
rename mxcig Tobacco
label variable Tobacco "Tobacco"
rename mxalc Alcohol
label variable Alcohol "Alcohol"
rename yxtrad Trad_Med
label variable Trad_Med "Traditional Medicine"
rename births Births
label variable Births "Births"
rename year Year
label variable Year "Year (1993 or 1998)"
label variable one_birth "One Birth"
label variable two_births "Two Births"
label variable three_plus "Three+ Births"
gen HH_Total = HH_Size_0_1 + HH_Size_2_5 + HH_Size
label variable HH_Total "Total HH Size"
gen TobAlc = Tobacco + Alcohol
label variable TobAlc "Tobacco/Alcohol"

********** Making dummies **********

gen African=(race==1)
label variable African "1 if African, 0 if Indian" 
drop race
gen clustnum=int(HHID/1000)
gen Treat = (Births > 0)
gen lnHealth = ln(1+Health)
gen lnIncome = ln(Income)
gen lnTrad_Med = ln(Trad_Med)
xtset HHID Year

********** Analysis **********

* Summary Statistics
estpost sum Age Male African Education HH_Total Health Insurance Income Tobacco Alcohol Trad_Med Births
esttab using table1.tex, cells((mean(fmt(%9.3f)) sd(fmt(%9.3f)) min(fmt(%9.3f)) max(fmt(%9.3f)))) nonumber nomtitle replace title(Summary Statistics\label{tab1})

* Birth Counts
estpost tab Births if Year==1998
esttab using table2.tex, cells((b pct(fmt(%9.3f)) cumpct(fmt(%9.3f)))) nonumber nomtitle replace title(Birth Numbers\label{tab2})

* Effect of any births
eststo: quietly xtreg lnHealth Treat
eststo: quietly xtreg lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med Treat
eststo: quietly xtreg lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med Treat, fe
eststo: quietly reghdfe lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med Treat, a(HHID) vce(cluster clustnum HHID)
esttab, se
esttab using table3.tex, b(3) se label replace title(Regression table\label{tab3})
eststo clear

* Effect of different births
eststo: quietly xtreg lnHealth one_birth two_births three_plus
eststo: quietly xtreg lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med one_birth two_births three_plus
eststo: quietly xtreg lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med one_birth two_births three_plus , fe
eststo: quietly reghdfe lnHealth Age Male Education HH_Size_0_1 HH_Size_2_5 HH_Size Insurance lnIncome TobAlc Trad_Med one_birth two_births three_plus, a(HHID) vce(cluster clustnum HHID)
esttab, se
esttab using table4.tex, b(3) se label replace title(Regression table\label{tab4})
eststo clear

log close 
exit
