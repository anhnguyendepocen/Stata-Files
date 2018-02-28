/*************************************************************************************************/
/***************                                                        **************************/
/***************               	 Week 4: Data Manipulation              **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
                                                                     
set more off 

capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week4_template.log", replace 

* Load data
bcuse bwght, clear

* Have a look at the data
describe 
sum

* one more thing: correlation matrix - multiple pairwise correlations
corr bwght cigs male
* this gives a three-way correlation table


* THIS CLASS: MANIPULATING DATA - all commands in Lab Handout

* generating variables
* --------------------
gen bwghtinlbs = 0.0625 * bwght
gen cgssq=cigs^2
* after generating a variable, you can type (browse var var) to see it
gen logincome=log(faminc)

* generating indicator/binary/dummy variables
gen highbwght = (bwght>130) 
browse bwght highbwght
* this makes (bwght>130=1), (bwght<=130=0)


* egen command - always helpful!!
* -------------------------------
* variables containing mean
egen avgbwght = mean(bwght)

* variables containing mean by gender
egen avgbwghtbygender=mean(bwght),by(male)
browse avgbwghtbygender male 

* demeaning variables
gen bwghtdemean = bwght-avgbwght
browse bwghtdemean avgbwght

* checking - mean now equal to zero?
sum bwghtdemean 
* it is not exactly zero, but very close


* replacing values of exisiting variables
replace highbwght=(bwght>150)


* generating female variable
gen female=male+1
replace female=0 if female==2
browse male female

* renaming variables
rename highbwght above150bwght


* sorting by one variable
* -----------------------
* ascending order
sort bwght
browse bwght

* descending order
gsort- bwght



* listing certain variables
list bwght in 1/10
* this lists the ten highest birth weights


* picking on certain observations
* _n - variable running from 1 (first observation) to _N (last observation = total number of observations)
* list if observation is last observation in the data set
list if _n==_N
list if _n==1


* sort also important for by command



* or use:



* dropping and keeping variables and observations
* -----------------------------------------------

* variables - columns



* observations - rows




* saving data and reopening saved data
* ------------------------------------





log close 
exit

