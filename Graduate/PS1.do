clear all
set more off
capture log close
cd "U:\"
log using ".\PS1.log", replace

* Problem 2

use "U:\twins90.dta"
drop if mi(logwage1,logwage2,educ1,educ2)
reg dlogwage deduc, nocons
reg dlogwage deduc
* The coefficients on deduc are not the same. Including the intercept slightly
* increases the size of deduc. The regression with the constant corresponds to
* the first differencing equation because first differencing yields the same
* slope coefficient as an OLS regression.

egen mean_dlogwage=mean(dlogwage)
egen mean_deduc=mean(deduc)
gen wlogwage=dlogwage-mean_dlogwage
gen weduc=deduc-mean_deduc
reg wlogwage weduc, nocons
reg wlogwage weduc
* The coefficients on weduc are slightly different, however I suspect that this
* is due to some type of rounding error because the results should be the same
* analytically. Beacuse of this, the regression with no constant equals the
* regression from part a with the constant, and the regression with a constant
* is extremely close.

stack logwage1 educ1 logwage2 educ2, into(logwage educ)
egen id = seq(), f(1) t(149)
xtset id
xtreg logwage educ, fe
* From the fixed effects regression, we get the same slope as the regression
* from part a with no constant. This is because fixed effects is a within
* estimator, which means that it compares movements in the data to group means
* instead of the mean for the entire dataset. 

log close
exit
