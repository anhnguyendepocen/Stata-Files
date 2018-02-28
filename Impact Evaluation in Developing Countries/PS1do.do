clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\PS1.log", replace 

* Question 1
use "\\appsstorage.bc.edu\petrier\EC373\PS1_SMOKE_FA16.DTA", clear
reg cigs lincome educ restaurn age agesq lcigpric
test educ=-1

* Question 2
use "\\appsstorage.bc.edu\petrier\EC373\PS1_SMOKE_FA16.DTA", clear
reg cigs lincome educ
reg cigs lincome
reg educ lincome
gen deduc=150*educ
reg cigs lincome deduc
reg deduc lincome


* Question 3
use "\\appsstorage.bc.edu\petrier\EC373\PS1_ZCMpt1_FA16.dta", clear
reg y x 
predict yhat
scatter y x || line yhat x
gen lny=log(y)
reg lny x
predict resid, resid
scatter resid x

* Question 4
use "\\appsstorage.bc.edu\petrier\EC373\PS1_ZCMpt2_FA16.dta", clear
gen trueu=(score-94+4*missed)
scatter trueu missed
reg score missed
predict scorehat
scatter score missed || line scorehat missed
predict resid, resid
scatter resid missed

log close 
exit
