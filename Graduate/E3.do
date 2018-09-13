clear all
set more off
capture log close
cd "U:\"
log using ".\E3.log", replace

* Problem 1

use "U:\cen4049.dta"
gen age2=age^2
* A
reg lnearn educ black smsa married age age2, robust
ivregress 2sls lnearn black smsa married age age2 (educ = qtrbrth), robust
ivregress 2sls lnearn black smsa married age age2 (educ = i.qtrbrth##i.year), robust
* B
gen rqob = runiformint(0,3)
ivregress 2sls lnearn black smsa married age age2 (educ = i.rqob##i.year), robust
* C
gen neduc = lnearn-0.1*educ
reg neduc black smsa married age age2 qtrbrth, robust
test qtrbrth
* D
drop neduc
gen neduc = lnearn-0.13*educ
reg neduc black smsa married age age2 qtrbrth, robust
test qtrbrth
drop neduc
gen neduc = lnearn-0.47*educ
reg neduc black smsa married age age2 qtrbrth, robust
test qtrbrth
* E
drop neduc
gen neduc = lnearn-0.05*educ
reg neduc black smsa married age age2 rqob, robust
test rqob
drop neduc
gen neduc = lnearn+0.05*educ
reg neduc black smsa married age age2 rqob, robust
test rqob

log close
exit
