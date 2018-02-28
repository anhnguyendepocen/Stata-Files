/*************************************************************************************************/
/***************                                                        **************************/
/***************        Week 5: Appending & Merging Data Sets           **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week5.log", replace 

* Load data
bcuse bwght, clear


* LAST CLASS: MANIPULATING DATA - all commands in Lab Handout

* sort command also important for by command
sort male
by male: sum bwght
* or use
bysort male: sum bwght


* dropping and keeping variables and observations

* variables - columns 
drop lfaminc cigtax
keep bwght male cigs white

* observations - rows
drop if white==0
keep if male==1

* saving data and reopening saved data
save birthweight.dta, replace
clear all
use birthweight.dta, clear




* THIS CLASS: APPENDING & MERGING DATA SETS

* Appending Data Sets
* -------------------
* same variables
* different observations

* creating data set 1
clear all
set obs 100
gen id = _n
gen var1 = 1
save dataset1.dta, replace




* creating data set 2
clear all 
set obs 50
gen id = _n +100
gen var1=2
save dataset2.dta, replace



* appending the two data sets
clear all
use dataset1.dta
append using dataset2.dta
clear all




* Merging Data Sets
* -----------------
* same observations
* different variables - except for the matching variable(s)


* One-to-one Merges
* -----------------

* data set 1
webuse autosize, clear
save autosize, replace
list


* data set 2
webuse autoexpense, clear
save autoexpense, replace
list



* merge
use autosize, clear
merge 1:1 make using autoexpense
drop if _merge!=3


* Many-to-one Merges
* ------------------

* creating data set 1 - individual data set
clear all
set obs 10
gen id = _n
gen hhid = 2
replace hhid = 1 if _n<3
replace hhid = 3 if _n>7
gen age = 20 + 20*runiform()
save individual, replace

* creating data set 2 - household data set
clear all
set obs 3
gen hhid = _n
gen income = 10000 + 10000*rnormal(10)
save household, replace

* merge
use individual, clear
merge m:1 hhid using household


* Time Series Data - please check out Lab Handout!



log close 
exit

