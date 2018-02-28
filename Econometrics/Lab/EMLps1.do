* Rufus Petrie
* Econometrics Lab
* Assignment #1
* 3/4/2016

clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\EMLps1.log", replace 

* Question 1
bcuse gpa3, clear
browse
sum cumgpa
sum sat, detail
corr trmgpa hssize sat
corr trmgpa hssize if female==1
corr trmgpa hssize if female==0
sum trmgpa if football==1 & season==1
sum trmgpa if football==1 & season==0
sum trmgpa if female==1 & term==1
sum trmgpa if female==1 & term==2
tab football
graph pie, over(footbal) plabel(_all percent)
graph export football.pdf, replace

* Question 2
bcuse inven, clear
rename gdp gdp_y
generate gdp_x=gdp_y[_n-1]
generate g=log(gdp_y)-log(gdp_x)
sort g
list g year in 1/1
gsort -g
list g year in 1/1
egen med_gdp=median(g)
gen gdp_high = (g>=med_gdp)
gen gdp_low = (g<med_gdp)
replace gdp_high=gdp_high+1
replace gdp_low=gdp_low+1
keep if gdp_high==2

* Question 3
clear
bcuse murder
egen state_id=group(id)
drop if year!=90
sort mrdrte
keep if mrdrte in 1/20
save murder_merge, replace
clear
bcuse prison
drop if year!=90
rename state state_id
save prison, replace
merge 1:1 _n using murder_merge
drop if _merge!=3
corr mrdrte criv crip
twoway (scatter mrdrte criv) (lfit mrdrte criv)
drop _all

log close 
exit

