clear all
set more off
capture log close
cd "U:\"
log using ".\PS3.log", replace

* Problem 2

use "U:\cen4049.dta"
gen age2 = age^2
gen dearn = 0
replace dearn = 1 if lnearn > 6
reg lnearn educ black smsa married age age2
reg dearn educ black smsa married age age2
* The coefficients are somewhat similar in these two regressions. All of the
* variables are statistically significant, and many of the regressors have
* close coefficient values. However, this is to be expected because we are
* estimating log earnings, so even highly impactful factors will have a low
* reading on the log scale. Likewise, when estimating the probability in the
* second regression, the coefficient correspond to increased probabilities,
* so they will also naturally have lower coefficients.

probit dearn educ black smsa married age age2
logit dearn educ black smsa married age age2
* The coefficients from the probit and logit regressions are fairly different.
* While they are all statistically significant, the coefficient estimates
* from the logistic regression are much larger. The coefficients from the logit
* and probit models are both much larger than the second regression's outputs.

probit dearn educ black smsa married age age2
margins, dydx(*) atmeans
logit dearn educ black smsa married age age2
margins, dydx(*) atmeans
* The probit and logit models both give similar marginal effects estimates,
* although like the regression outputs, the logit results are slightly higher.
* These marginal effects should be similar to the output from the second 
* regression because 'dearn' is roughtly the probability that log earnings
* are greater than the mean, so the marginal effects computed at the mean
* give very similar outputs.

probit dearn educ black smsa married age age2, vce(bootstrap)
estat bootstrap, percentile
* Compared to the probit regression, the bootstrap standard errors are 
* slightly higher. The estat command gives very similar results to the 
* original probit model.

log close
exit
