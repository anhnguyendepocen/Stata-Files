/*************************************************************************************************/
/***************                                                        **************************/
/***************    Week 12: Multicollinearity, Omitted Variables       **************************/ 
/***************                   & Misspecification                   **************************/
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week12_template.log", replace 

* Load data
bcuse mlb1, clear

* Have a look at the data
describe 
sum

* Multicollinearity
* -----------------
* two or more independent variables in your regression are highly correlated with each other
* => inflated standard errors
reg lsalary games runs hits

* 

* Checking for multicollinearity:
* -------------------------------

* 1) checking the correlation
corr games runs hits

* 2) checking the variance inflation factor (VIF)
estat vif

* if largest VIF greater than 10 => collinearity problem


* What to do? 
* -----------

* 1) ignore if coefficient of interest significant regardless

* 2) respecify the model
gen hitspergame=hits/games
reg lsalary runs hitspergame

* 3) increase sample size/get better sample



* Omitted Variables
* -----------------
* zero-conditional mean assumption might not hold
* => biased estimates

* better to put more than less: better over-fit than under-fit!
reg lsalary hitspergame

* positive coefficient on hitspergame

* BUT: we know that runs has a positive and significant coefficient as well

* We will obtain biased results if hitspergame and truns are correlated

* check correlation:
corr hitspergame runs
* we have positive and fairly high correlation => upward bias of coefficients on hitspergame

* rerun regression:
reg lsalary hitspergame runs
* coefficient on hitspergame goes down



log close 
exit

