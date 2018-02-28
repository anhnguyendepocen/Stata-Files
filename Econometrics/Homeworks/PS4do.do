clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment4.log", replace 
use "L:\EC227\SMOKE.dta", clear

* Question 1

reg cigs lincome educ age agesq lcigpric

log close 
exit

