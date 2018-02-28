clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\PS2.log", replace 

* Question 2


* Question 3
use "\\appsstorage.bc.edu\petrier\EC373\ps2_q3_FA16.dta", clear
reg depressed age currently_married dead_child children lnincpc i.year,    robust
xtset pid year
xtreg depressed age currently_married dead_child children lnincpc i.year,  fe  robust
xtreg depressed age currently_married dead_child children lnincpc i.year,  robust


log close 
exit
