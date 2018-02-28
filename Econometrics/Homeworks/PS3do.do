clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment3.log", replace 
use "L:\EC227\NAES08PS3.DTA", clear

* Question 1

* Part (iv)
reg HrsTV Children Age Inc

* Part (vi)
reg HrsTV Children Age Inc AgeSq

* Part (viii)
gen lnInc = ln(Inc)
reg HrsTV Children Age AgeSq lnInc

clear
bcuse smoke.dta

* Question 2

* Part B
reg cigs lincome
reg cigs lincome educ
reg educ lincome 
dis 1.345805*(-0.3454854)

* Part F
generate dayseduc=150*educ
reg cigs lincome dayseduc
reg dayseduc lincome





log close 
exit

