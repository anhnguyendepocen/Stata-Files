/*************************************************************************************************/
/***************                                                        **************************/
/***************                 Week 10: Binary Variables              **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week10.log", replace 

* Load data
bcuse card, clear

* Have a look at the data
describe 
sum


* Question: What helps predict education of an individual?
* --------------------------------------------------------

* income
* parents' education
* age
* family structure


* SLR on a Dummy
* --------------
reg educ momdad14

* Interpreting the coefficients:
* ------------------------------ 
* intercept: 12.287 - years of education without mom & dad
* slope: 1.236 - increase in education with mom & dad
* intercept + slope: total education predicted with mom & dad

* alternative ways to get expected years of education by family structure
margins, by(momdad14)
bysort momdad14: sum educ

* MLR with binary independent variables
* -------------------------------------
twoway (lfit educ fatheduc if momdad14==1, clc(red)) (lfit educ fatheduc  if momdad14==0, clc(green))

* 1) different intercept, same slopes
* -----------------------------------
reg educ momdad14 fatheduc

* producing graph
predict eduhat
scatter eduhat fatheduc

* 2) different intercepts, different slopes
* -----------------------------------------

* need interaction term!

* 1) generate interaction variable by hand
gen interact=momdad14*fatheduc
reg educ momdad14 fatheduc interact

* 2) use STATA command => look into hand-out for more info!
reg educ i.momdad14##c.fatheduc

* producing graph 
predict eduhat2
scatter eduhat2 fatheduc

* interacting with multiple variables
reg educ i.momdad14##c.(fatheduc motheduc)

* Please review handout for interpretation of all coefficients!


* Chow test
* ---------
* 1) by hand

* 2) use stata
* H_0: both slope and intercept same for both subgroups
* H_1: at least one of the two is different
reg educ i.momdad14##c.fatheduc
testparm i.momdad14 i.momdad14#c.(fatheduc)
* reject null hypothesis, some evidence for different intercepts and slopes

log close 
exit

