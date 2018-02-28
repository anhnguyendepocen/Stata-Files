clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment7.log", replace 


* Question 1

. use "L:\EC227\PS6_q1 (1).dta", clear
keep if agea3>=7 & agea3<=18
reg enroll03 hdedyN3 lnpciN3 yreduc03 agea3 race female urban KZ
margins, at()
dprobit enroll03 hdedyN3 lnpciN3 yreduc03 agea3 race female urban KZ
margins, at()
tab foster03
reg foster03 female
dprobit enroll03 hdedyN3 lnpciN3 yreduc03 agea3 race female urban KZ foster03
reg enroll03 i.foster03##c.fostfem03
testparm i.foster03 i.foster03#c.(fostfem03)
reg enroll03 i.fostclose03##c.fostdist03
testparm i.fostclose03 i.fostclose03#c.(fostdist03)

* Question 2



log close 
exit
