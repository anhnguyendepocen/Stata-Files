clear                                                                         
set more off 
capture log close 
cd "L:\EC227\KIDS 1993 and 1998 for release- STATA\1993\orig\construct"
log using ".\project.log", replace 

*** CLEANING DATA SETS *** 
use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1993\orig\construct\HHEXPTL.dta", clear
merge m:1 hhid using HHINCTL
drop _merge
save project.dta, replace
drop _merge
use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1993\orig\basic\m8_hrost.dta", clear
keep if pcode==1
merge m:1 hhid using project
drop _merge
save project.dta,replace
use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1993\orig\basic\m3_hea1.dta", clear
keep if pcode==1
merge m:1 hhid using project
keep if _merge==3
drop _merge
save project.dta,replace

*** CLEANING UP VARIABLES ***
keep mxhea mxinsur mxsav hhsizep totminc age gender days_sic days_out
gen sickInWork=days_sic-days_out
gen age2=age^2
label variable sickInWork "Days sick at work"
label variable age2 "Age Squared"

*** ANALYSIS ***
reg mxhea days_sic age age2 gender mxinsur mxsav hhsizep totminc sickInWork
hettest

log close 
exit
