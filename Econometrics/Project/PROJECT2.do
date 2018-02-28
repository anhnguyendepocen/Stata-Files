clear                                                                         
set more off 
capture log close 
cd "L:\EC227\KIDS 1993 and 1998 for release- STATA\1998\orig\construct"
log using ".\project.log", replace 

*** CLEANING DATA SETS *** 
use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1998\Version 1\basic\roster.dta", clear
keep if pcode==1
merge m:1 hhid using nf1x01
keep if _merge==3
drop _merge
save project2.dta,replace

merge m:1 hhid using nf2x02
keep if _merge==3
drop _merge
save project2.dta,replace

merge m:1 hhid using expend98
keep if _merge==3
drop _merge
save project2.dta,replace

use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1998\Version 1\construct\hhsize98.dta", clear
merge m:1 hhid using project2
drop _merge
save project2.dta,replace

use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1998\Version 1\construct\income98.dta", clear
merge m:1 hhid using project2
drop _merge
save project2.dta,replace

* use "L:\EC227\KIDS 1993 and 1998 for release- STATA\1998\Version 1\basic\health.dta", clear
* merge m:1 hhid using project2
* keep if _merge==3
* drop _merge
* save project2.dta,replace

*** CLEANING UP VARIABLES ***
drop nonlaby flagnlab hhycas flagycas flagyreg monthtvl montheat monthhse 
drop flagagr rentimp flagval hhysemp flagsemp hhsizep clustnum hhyrem hhyagr 
drop origcore newcore relhd93 alive98 yrdeath flagremr flaghse relhd98
drop finance activity educ yxtrad yxmedsp yxhfee yxdoc head pcode
drop lived resident spouse father mother mother resmem nresmem nonmem source 
drop mxewr mxent mxnews mxtel mxcar mxtran1 mxchil mxdues
drop mxpcare mxdon mxhelp mxwash mxener mxtot flagreg yxkit yxhom yxbed yxcmat 
drop yxholi yxlux yxcerem yxedfee yxedbk yxedothr yxtot flagocc mxtrem flagrem 
drop mxtfood flagfood totmexpr flagrent mxrent mxoth1 yxkdcl yxadcl yxfurn
drop mxoth2 mxper mxtransp mxcloth mxhous
* drop charge consult sick mxper mxoth mxcloth mxhous time_get time_tre

rename gender male
gen age2=age^2
label variable age2 "98: age squared"
* gen sickInWork=days_sic-days_out
* label variable sickInWork "98: days sick at work"
gen mxheaZ = (mxhea>0)
label variable mxheaZ "98: 1 if mxhea>0, 0 if mxhea=0"

*** ANALYSIS ***

* reg mxhea days_sic totminc hhsizem race male age yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed  totmexp age2 sickInWork
* hettest
* reg mxhea days_sic totminc hhsizem race male age yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed  totmexp age2 sickInWork, robust
* test days_sic sickInWork

* Note: after I did this part of the analysis, I went back and used the data 
* before we merged with the "days sick" data set so I could have a larger sample

*** OLS MODEL ***

reg mxhea hhnwage totminc hhsizem race male age yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed totmexp age2
hettest
reg mxhea hhnwage totminc hhsizem race male age yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed totmexp age2
test totminc hhnwage
reg mxhea hhsizem race male age yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed totmexp age2, robust
test age age2
reg mxhea hhsizem race male yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed totmexp, robust
test hhsizem race
reg mxhea male yrseduc mxcig mxalc yxins_l yxins_m yxins_s mxed totmexp, robust
test yrseduc yxins_l

*** PROBIT MODEL ***

* Note: race (African/Indian) was originally 1 and 3, so I made a new dummy
* so that the marginal effect would be accurate
gen African=(race==1)
label variable mxheaZ "98: 1 if Africa, 0 if Indian"
probit mxheaZ male yrseduc age age2 African hhsizem
mfx compute

log close 
exit
