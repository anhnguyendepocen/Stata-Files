clear                                                                         
set more off 
capture log close 
cd "L:\EC227"
log using ".\EMLps3.log", replace 

* Question 1

bcuse lawsch85, clear
gen SAL=salary/1000
gen COS=cost/1000
reg SAL COS rank GPA LSAT
corr GPA LSAT
test (GPA=0) (LSAT=0)
reg SAL COS rank GPA
test COS=1

* Question 2

bcuse wage2, clear
gen exper2=exper^2
reg lwage educ exper exper2
reg lwage urban educ exper exper2
gen educU=educ*urban
reg lwage educ educU exper exper2
reg lwage urban educ educU exper exper2



log close 
exit

