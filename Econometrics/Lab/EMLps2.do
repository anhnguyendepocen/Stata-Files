clear                                                                         
set more off 
capture log close 
cd "L:\EC227"
log using ".\EMLps2.log", replace 

* Question 1

bcuse saving, clear
sum
display 3284.902^2
display 5583.998^2
display 5729.73^2
gen consav=con+sav
gen diff=inc-consav
browse inc consav
browse diff
corr sav cons, covariance
sum cons if black==1
sum cons if black==0
browse if cons<0
keep if cons>0
reg cons inc
reg sav inc
twoway (lfit cons inc if black==1) (lfit cons inc if black==0)

* Question 2

bcuse wage2, clear
gsort -KWW
browse KWW in 1/1
gsort KWW
browse KWW in 1/1
sum
sum wage, detail
sum KWW if wage>=1444
twoway (scatter wage KWW) (lfit wage KWW)
reg wage KWW
margins, at(KWW=40)
display 17.2736*10
gen logwage=log(wage)
browse lwage logwage
reg lwage KWW

* Question 3

bcuse wage2, clear
sum
tabstat feduc meduc brthord, s(count)
drop if missing(feduc)
drop if missing(meduc)
drop if missing(brthord)
sum
reg educ sibs meduc feduc
display 1/0.122
margins, at(sibs=0 meduc=10 feduc=10)
margins, at(sibs=1 meduc=7 feduc=8)

log close 
exit

