/*************************************************************************************************/
/***************                                                        **************************/
/***************                 Week 11: Heteroskedasticity            **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week11.log", replace 

* Load data
bcuse card, clear

* Have a look at the data
describe 
sum

* Question: What helps predict education of an individual?
* --------------------------------------------------------
* father's education
* mother's education
* family situation: both mom and dad in the HH?

* Worrying about one standard assumption of OLS: Homoskedasticity
* ---------------------------------------------------------------

* Looking at a graph - SLR:
* -------------------------
reg educ fatheduc
predict u, resid
scatter u fatheduc

* Looking at numbers - MLR:
* -------------------------

* standard case - assuming homoskedasticity (variance of the error term does not depend on regressors)
reg educ momdad14 fatheduc

* not assuming homoskedasticity - allowing for heteroskedasticity (variance of the error term depends on regressors)
reg educ momdad14 fatheduc, robust

* Coefficient estimates are the same with or without homoskedasticity
* Standard errors change, which affect t statistics, f statistics, etc.

* F-test under homoskedasticity
reg educ momdad14 fatheduc
test momdad14 fatheduc

* F-test under heteroskedasticity
reg educ momdad14 fatheduc, robust
test momdad14 fatheduc

* Both reject H_0 but with different test statistics 
* We could have a case where H_0 is rejected for one but not the other


* Which one to use? Testing for heteroskedasticity
* ------------------------------------------------
 
* Breusch-Pagan test (linear funtional form between variance of error term and regressors)
* ----------------------------------------------------------------------------------------
* H_0: homoskedasticity
* H_1: heteroskedasticity
reg educ momdad14 fatheduc
estat hettest
* p-value=0 - reject homoskedasticity assumption 

* White test (allows for non-linear relation between variance of error term and regressors)
* -----------------------------------------------------------------------------------------
* H_0: homoskedasticity
* H_1: heteroskedasticity 
reg educ momdad14 fatheduc
estat imtest, white
*  

* 

log close 
exit

