* Week 2 Do-File
* Date: 2/1/2016
* by: Rufus Petrie

* opening commands
clear all
set more off
capture log close

* change directory
cd "L:\EC227"

* open log file
log using ".\Week2M2pm.log", replace

**** exploring the Data ****

* open a data set from the web
webuse states3, clear

* basic info on data set
describe
des

* have a look at the data
* browse
* edit

* clear Stata
clear all

* open a BC data set
bsuse wage2, clear

* summary statistics for all variables
summarize
sum

* summary statistics for one variable
sum wage

* median, quantiles
sum wage, detailw

* summary statistics for subset of the data - all black individuals
sum wage if black==1

* summary statistics for subset of the data - all non-black individuals
sum wage if black==0


* region?

* tabulate data
tab black
tab black south

* compare wages in South vs. North
sum wage if south==1
sum wage if south!=1


* closing commands
log close
exit
