/*************************************************************************************************/
/***************                                                        **************************/
/***************               	 Week 6: Simple Regression              **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear                                                            
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week6_template.log", replace 

* Load data
bcuse bwght, clear

* Have a look at the data
describe 
sum


* THIS CLASS: SIMPLE REGRESSIONS
* ------------------------------

* Question: Can number of cigarettes smoked help predict birthweight?

* scatter plots
twoway scatter bwght cigs

* fitting a straight line through the data to see linear relationship more easily
twoway (scatter bwght cigs) (lfit bwght cigs)

* estimating the intercept and slope of this line - running a simple linear regression
reg bwght cigs 
* beta_0: 119.77 (intercept-predicted bwght of baby with non-smoking mom)
* beta_1: -0.51 (slope-way in which marginal cigarettes affect bwght)

* fitted values (=predicted values)
predict bwghthat 

* look at fitted values for heavy smokers
gsort -cigs
list cigs bwght bwghthat in 1/10

* graph fitted values
twoway (scatter bwghthat cigs) (lfit bwght cigs)

* graphing everything in one plot
twoway (scatter bwght bwghthat cigs) (lfit bwght cigs)

* residuals (difference between actual and predicted values)
predict resid, residuals

* look at those
browse bwght bwghthat resid

* scatter plot of residuals
twoway scatter resid cigs

* regression on constant only
reg bwght
* intercept-avg bwght for sample

* functional forms - non-linear relationships between dependent and independent variable
gen logbwght = log(bwght)
gen logcigs = log(cigs)

* model with constant percentage effect
reg logbwght cigs
* beta_1-one cigarette more is associated with beta_1*100 increase/decrease
* one more cig will decrease birthweight by .4%!

* model with constant elasticity
reg logbwght logcigs
* beta_1 - one percent more of cigarette smoking is associated with beta_1*100 
* increase/decrease in bwght
* a 1% increase in cigarettes decreases bwght by .027%

log close 
exit

