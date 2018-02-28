/*************************************************************************************************/
/***************                                                        **************************/
/***************         	 Week 3: Introduction to Graphics           **************************/ 
/***************                                                        **************************/
/*************************************************************************************************/

clear    
set more off 
capture log close 

* Change directory
cd "L:\EC227"

* Open log file
log using ".\Week3_template.log", replace 

* Load data
bcuse wage2, clear


*** One-dimensional summary statistics from last handout

* Descriptive statistics: mean, median, etc.
sum wage, detail

* Tabulating data: absolute frequancies, relative frequencies, cumulative frequencies
tab educ


*** Two-dimensional summary statistics from last handout

tab south black

* Education as possible third factor why black individuals have lower average earnings?

* higher education => higher wage?

* tab educ wage - returns error message b/c continuous vs. discrete data
sum wage if educ<12
sum wage if educ>=12 & educ<16
sum wage if educ>=16




* black individuals => lower average education?
tab educ black




* different way of looking at relationship between two variables: correlation
corr educ black
corr educ wage


* Getting help in Stata
help corr



* THIS CLASS: GRAPHS

*** one-dimensional graphs

* box plots

graph box wage
* middle box = interquartile range
* blue dots = outliers
* help graph - command for help
* the graphics tab is also helpful for making graphs
graph box wage, by(married)




* histogram

histogram wage
* histogram gives density by default, numbers are more desireable
histogram wage, percent
* this gives percentages instead of density
histogram wage if married==1 & black==0, percent





* bar chart

graph bar (p50) wage, over(married)
* gives bar of 50% percentile for married & nonmarried
graph bar (mean) wage, over(married)



*** two-dimensional graphs

* scatter plots

scatter wage educ
twoway scatter wage educ

twoway (scatter wage educ) (lfit wage educ)

scatter wage educ if south==1








*** save graphs

* Stata format

graph save mygraph, replace


* png format
graph export mygraph.pdf, replace



* pdf format
graph export mygraph.png, replace



log close 
exit

