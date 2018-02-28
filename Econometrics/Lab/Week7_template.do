/*************************************************************************************************/
/***************                                                        **************************/
/***************               	 Week 7: Multiple Regression            **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
                                                                     
set more off 

capture log close 


* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week7_template.log", replace 

* Load data
bcuse hprice2, clear

* Question: Can crime rates help predict housing prices?

* Have a look at the data
describe 
sum

* Look at crime rates - drop observations with very high crime rate
graph box crime
drop if crime>30


* THIS CLASS: MULTIPLE REGRESSION
* -------------------------------

* fitting a straight line through the data to see linear relationship more easily
twoway (scatter price crime) (lfit price crime)

* underlying assumption: error term is not correlated with explanatory variables
* sometimes unrealistic: stratio, rooms, etc. probably correlated with crime rate

* running and interpreting a multiple regression
reg price crime stratio
* intercept - there isn't really a valid interpretation for this since a ratio=0
* beta_1 - one more crime predicts beta_1 increase (decrease) of median housing prices holding all else constant
* beta_2 - one more student per teacher predicts beta_2 increase (decrease) of median housing prices holding all else constant

* predicting housing prices
* if student-teacher ratio = 20, crime rate per capita = 1
margins, at(stratio=20 crime=1)
* if student-teacher ratio = 20, average crime rate per capita
margins, at(stratio=20)


* Problem of perfect collinearity
* -------------------------------

* create indicator variable for above average crime areas
egen avgcrime=mean(crime)
gen highcrime=(crime>=avgcrime)
replace highcrime. if missing(crime)

* create indicator for below average crime areas
gen lowcrime=(highcrime==0)

* run regression with both dummies and intercept
reg price highcrime lowcrime
* highcrime and lowcrime are perfectly correlated, so one is omitted
ff

* Saving regressions
* ------------------
reg price crime stratio
eststo REG1
reg price crime stratio rooms
eststo REG2

* presenting regression results
estout REG1 REG2

* or:
esttab REG1 REG2


log close 
exit

