* Problem Set #2
* Date: 2/10/2016
* by: Rufus Petrie

clear all
set more off
capture log close
cd "L:\EC227"

* Problem 1 commands

* Part A
use "L:\EC227\housingforps2.dta", clear
sum, detail
median price: 2120 (in hundreds)
median crime rate: .2565
* Part B
tab rooms
* Part C
reg price crimes
* Part D
reg lprice crimes



* Problem 2 commands

* Part A
use "L:\EC227\PS2_ZCMpt1.dta", clear
reg y x
* Part C
predict yhat
scatter y x || line yhat x
* Part D
gen lny=log(y)
regress lny x
* Part F
scatter lny x || line lnyhat x



* Problem 3 commands

* Part A
* Note: for trueu, I manually entered values into the data editor
scatter trueu attend
* Part D
regress score attend
* Part F
* Note: for scoreHat, I manually entered values into the data editor
scatter score attend || line scoreHat attend
* Part G
predict resid, resid
scatter resid attend


* closing commands
log close
exit
