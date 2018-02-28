clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment9.log", replace 


* Question 1

use "L:\EC227\PS9_q2.dta", clear
regress lwage urban ne nc west exper expersq educ
ivregress 2sls lwage (educ=tuit18),first
ivregress 2sls lwage (educ=tuit18 sibs),first
reg educ tuit18 sibs
test tuit18 sibs
ivregress 2sls lwage (educ=urban),first

log close 
exit
