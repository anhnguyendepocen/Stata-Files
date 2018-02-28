/*************************************************************************************************/
/***************                                                        **************************/
/***************                 	 Week 9: Inference                  **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week9_template.log", replace 

* Load data
bcuse nbasal, clear

* Have a look at the data
describe 
sum

* Question: What helps predict the wage of an NBA player?

reg wage center points rebounds assists

* Testing a single restriction
* ----------------------------

* 1) Testing whether a coefficient is significant (=significantly different from zero):
* H_0: beta=0
* H_1: beta!=0

* Look at the regression output:

* T-statistic: If greater than critical value, e.g. 1.96 for 5% significance, reject H_0.

* P-value: If less than alpha significance level, then reject H_0.

* Perform F-test: 

test points=0 /* refers to previous regression, tests at 0 */
test points

* P-value<alpha -> reject H_0, beta is statistically significant

test assists

* P-Value>alpha -> Fail to reject H_0

* 2) Testing whether a coefficient is equal to a certain number:
* H_0: beta=number
* H_1: beta!=number

test points=70

* fail to reject


* 3) Testing whether two coefficients are the SAME/perfect substitutes:
* H_0: beta1=beta2
* H_A: beta1!=beta2

test points=rebounds

* can't reject




* Testing multiple restrictions
* -----------------------------
corr points rebounds assists
* especially relevant if some variables are highly correlated
* H_0: beta1=0 & beta2=0
* H_A: at least one of the coefficients does not equal zero

* e.g. test of JOINT significance:
test (points=0) (assists=0)


log close 
exit

