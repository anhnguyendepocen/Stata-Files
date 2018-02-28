/*************************************************************************************************/
/***************                                                        **************************/
/***************               	 Week 8: ANOVA & Standard Errors        **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week8_template.log", replace 

* Load data
bcuse nbasal, clear

* Have a look at the data
describe 
sum

* Question: What helps predict the wage of an NBA player?


* ANOVA
* -----
* How much of the variation in the dependent variable can the model explain
graph twoway (scatter wage points) (lfit wage points)

* SST - total sum of squares
* SSE - total sum of explained squares
* SSR - total sum of residuals

* running a simple regression
reg wage points

* R^2= SSE/SST = 1-SSR/SST

* running a multiple regression
reg wage points allstar minutes exper 

* adjusted R^2 - adjusts for the number of regressors


* Standard Errors & Statistical Significance
* ------------------------------------------


* standard errors: How sure am I my estimates?
* confidence interval: 95% interval guess
* t-value: standardized coefficient, if larger than 1.96 in magnitude, it's significant (statistically) at 5%
* p-value: under the assumption that the true coefficient is zero, how probable is the estimated coefficient?
* 		   if p-valie<0.05, significant at the 5% level


* Economic Significance
* ---------------------

* 1) standardize by standard deviation of dependent and independent variable

* 2) calculate elasticities
margins, eyex(*) 
* this gives average elasticities for all regressors


* Saving and Displaying Regression Results
* ----------------------------------------
* install estout package
ssc install estout, replace

* save estimates
reg wage points 
estimates store REG1
reg wage points assists
estimates store REG2

* presenting regression results
estout REG1 REG2

* or:
esttab REG1 REG2


log close 
exit

