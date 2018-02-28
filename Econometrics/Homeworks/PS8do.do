clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment8.log", replace 


* Question 1

use "L:\EC227\PS6_q1 (1).dta", clear
reg yreduc03 KZ urban agea3 agesqa3 hdedyN3 lnpciN3 if female==1 & race==1 & agea3>=7 & agea3<=18
hettest
reg yreduc03 KZ urban agea3 agesqa3 hdedyN3 lnpciN3 if female==1 & race==1 & agea3>=7 & agea3<=18, robust
dis ln(100)
margins, at(agea3=10 urban=0 hdedyN3=5 lnpciN3=4.605)
predict resid, resid
gen resid2=resid^2
reg resid2 KZ urban agea3 agesqa3 hdedyN3 lnpciN3 if female==1 & race==1 & agea3>=7 & agea3<=18
margins, at(agea3=10 urban=0 hdedyN3=5 lnpciN3=4.605)
gen invage=1/agea3
reg yreduc03 KZ urban agea3 agesqa3 hdedyN3 lnpciN3 if female==1 & race==1 & agea3>=7 & agea3<=18 [aw=invage]
reg enroll03 race agea3 agesqa3 lnpciN3 hdedyN3 urban if agea3>=7 & agea3<=18 & female==1
margins, at(agea3=10 urban=0 hdedyN3=5 lnpciN3=4.605)
drop resid
drop resid2
predict resid, resid
gen resid2=resid^2
reg resid2 race agea3 agesqa3 lnpciN3 hdedyN3 urban if agea3>=7 & agea3<=18 & female==1
margins, at(agea3=10 urban=0 hdedyN3=5 lnpciN3=4.605)
reg enroll03 race agea3 agesqa3 lnpciN3 hdedyN3 urban if agea3>=7 & agea3<=18 & female==1, robust

* Question 2

use "L:\EC227\PS7_NAES08.dta", clear
gen logincomesq=logincome^2
reg pet logincome logincomesq age agesq female democrat
hettest
reg pet logincome logincomesq age agesq female democrat, robust
test logincome=logincomesq=0
reg logincome age agesq female democrat dog
hettest
reg logincome age agesq female democrat dog, robust

log close 
exit
