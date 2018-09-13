clear all
set more off
capture log close
cd "U:\"
log using ".\J3.log", replace
use "U:\Economics 705 Spring 2018 CPS MORG 2011 Data.dta"

* Problem 1
gen school2=ihigrdc^2
gen school3=ihigrdc^3
reg earnwke ihigrdc
reg earnwke ihigrdc school2
reg earnwke ihigrdc school2 school3
* In the first two regressions, all of the explanatory variables are
* statistically significant. In the first regression, school has a positive 
* sign, and in the second regression, school has a negative sign and the
* squared term has a positive sign. However, in the third regression, only
* the cubic term is statistically significant, and it has a positive sign.

* Problem 2
generate _8l=0
replace _8l=1 if ihigrdc<=8
generate _911=0
replace _911=1 if ihigrdc>=9 & ihigrdc<=11
generate _12=0
replace _12=1 if ihigrdc==12
generate _1315=0
replace _1315=1 if ihigrdc>=13 & ihigrdc<=15
generate _16=0
replace _16=1 if ihigrdc==16
generate _g16=0
replace _g16=1 if ihigrdc>16
reg earnwke _911 _12 _1315 _16 _g16

* Problem 6
keep if ihigrdc==12 | ihigrdc==16
generate college=0
replace college=1 if ihigrdc==16

* Problem 7
ttest earnwke, by(college)
* In this sample, the treated units earn 382.29 more on average. This is a 
* fairly significant (~50% increase) treatment effect. With a t-score of
* 34, this is statistically significant at a very high level.

* Problem 8
gen age2=age^2
gen femage=female*age
gen femage2=female*age2
probit college age age2 female femage femage2
predict pr
rename pr pscore

* Problem 9
egen bins=cut(pscore), at(0(0.05)1) icodes
graph bar (count) pscore, over(college) over(bins, label(nolab)) asyvars

* Problem 10
teffects psmatch (earnwke) (college age age2 female femage femage2), nn(1) atet

* Problem 11
tebalance summarize

* Problem 12
psmatch2 college age age2 female femage femage2, kernel kerneltype(normal) bwidth(0.005) outcome(earnwke)
psmatch2 college age age2 female femage femage2, kernel kerneltype(normal) bwidth(0.05) outcome(earnwke)
psmatch2 college age age2 female femage femage2, kernel kerneltype(normal) bwidth(0.5) outcome(earnwke)

* Problem 13
teffects ipw (earnwke) (college age age2 female femage femage2, probit), atet

log close
exit
