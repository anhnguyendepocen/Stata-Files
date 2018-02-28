clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\PS3.log", replace 

* Question 2

use "\\appsstorage.bc.edu\petrier\EC373\ps3_q2_FA16-1.dta", clear
desc  depressed age currently_married dead_child children lnincpc 
sum  depressed age currently_married dead_child children lnincpc 
regress depressed age currently_married dead_child children lnincpc,  robust
ivregress 2sls depressed age  currently_married dead_child children (lnincpc=yrs_edu)  ,   robust first
reg lnincpc age currently_married dead_child children yrs_educ
test yrs_educ
ivregress 2sls depressed age  currently_married dead_child children (lnincpc=yrs_edu)  ,   robust first
estat first
reg lnincpc age currently_married dead_child children yrs_edu, robust
predict lnincpchat
predict resid, resid
regress depressed age  currently_married dead_child children lnincpc resid, robust
test resid
ivregress 2sls depressed age  currently_married dead_child children (lnincpc=yrs_edu),   robust first
estat endogenous
regress depressed age  currently_married dead_child children lnincpchat, robust
ivregress 2sls depressed age  currently_married dead_child children (lnincpc=yrs_edu avglnincpc),   robust first
estat overid
ivregress 2sls depressed age  currently_married dead_child children (lnincpc= avglnincpc),   robust first
ivregress 2sls depressed age  currently_married dead_child children (lnincpc=yrs_edu avglnincpc),    first
estat first

log close 
exit
