clear                                                                         
set more off 
capture log close 
cd "L:\EC373"
log using ".\FE2.log", replace 

* #1
bcuse fertil1, clear
reg kids educ age agesq black east northcen west farm othrural town smcity y74 y76 y78 y80 y82 y84
test east northcen west 
* All of the variables are jointly significant at the 2.93% level, which implies
* that living environment has a significant effect on number of children.
test farm othrural town smcity
* The p-value for this F-test is 0.3275, which implies that these variables are
* not jointly significant, so region likely has no effect on fertility.
predict resid, resid
g residsq = resid^2
reg residsq y74 y76 y78 y80 y82 y84
test y74 y76 y78 y80 y82 y84
* The year variables are jointly significant at the 0.82% level, which implies
* that the squared residuals vary over time.
reg kids educ age agesq black east northcen west farm othrural town smcity y74 y76 y78 y80 y82 y84 y74educ y76educ y78educ y80educ y82educ y84educ
test y74educ y76educ y78educ y80educ y82educ y84educ
* Each of these terms represents the change in the effect of education of 
* fertility across different years. They are not jointly significant.

* #2
bcuse cps78_85, clear
reg lwage y85 educ y85educ exper expersq union female y85fem
* In this regression, y85 represents the ceteris paribus predicted increase in
* log wage that corresponds to living in the year 1985 for men who have no 
* education.
disp .0184605*12+.1178062
* We would expect a man who has 12 years of education to have a 33.93% increase
* in wages on average if y85=1, ceteris paribus.
g y85educ12=(y85*(educ-12))
reg lwage y85 educ y85educ12 exper expersq union female y85fem
* From this new regression, we see that y85 (which now has a value of 0.3393)
* has a 95% confidence interval of [0.272,0.406]. Thus, we can be certain that
* living in 1985 has a positive effect on wages at 12 years of education.
g wage=2.71828^lwage
g rwage=wage if y85==0
replace rwage=(wage/1.65) if y85==1
gen lrwage=ln(rwage)
reg lrwage y85 educ y85educ exper expersq union female y85fem
* The only coefficient that changed was y85, which is now significantly 
* negative and statistically significant.
* The r-squared value decreased because the total explained residuals decreased.
* This happened because by producing real log wage values, we decreased the 
* variation in log wages.
sum union if y85==0
sum union if y85==1
* Union participation slightly decreased between 1978 and 1985.
reg lwage y85 educ y85educ12 exper expersq union female y85fem y85union
* y85union has a t-score of -0.01, so the union wage differential did not appear
* to change over time.
* The results from part V and VI don't necessarily conflict because even though
* participation decreased, this doesn't necessarily mean that the benefits 
* from being in a union changed over time.

* #4
bcuse injury, clear
reg ldurat afchnge highearn afhigh male married head neck upextr trunk lowback lowextr occdis manuf construc
* The coefficient of afchnge*highearn increased when we added these extra 
* explanatory variables, and the term remained statistically significant.
* A low r-squared value only means that the model does not explain much of the
* variation in the ldurat variable. However, the equation is still useful 
* because it uncovered a statistically significant relationship between 
* afchnge, highearn, and ldurat.
reg ldurat afchnge highearn afhigh if mi==1
reg ldurat afchnge highearn afhigh if ky==1
* afchnge*highearn has a slightly higher coefficient in Michigan, but it isn't
* statistically significant. afchnge*highearn has a slightly lower coefficient
* in Kentucky, but it's statistically significant. This probably implies that
* Michigan and Kentucky have different laws when it comes to the
* disabilities benefits that employers provide.

* #5
bcuse rental, clear
reg lrent i.y90##c.(lpop lavginc pctstu)
* From the coefficient of y90, it appears that rent increased by about 131%
* from 1980 to 1990, which is a fairly sizable increase. Pctstu equalling 
* 0.004 and being significant indicates that a 1% increase in student population
* increases housing prices by about 0.4%.
hettest
* It appears that this regression suffers from heteroskedasticity. This means 
* that the standard errors from this model are probably not valid.
tsset city y90
reg D.lrent D.lpop D.lavginc D.pctstu
* This time, pctstu has a coefficient of 0.011 and is significant, which seems
* to indicate that percentage students has a positive effect on housing prices.
reg D.lrent D.lpop D.lavginc D.pctstu, robust
* After using robust standard errors, the pctstu variable becomes more 
* significant. 

* #7
bcuse gpa3, clear
reg trmgpa spring sat hsperc female black white frstsem tothrs crsgpa season
reg trmgpa i.spring##c.(sat hsperc female black white frstsem tothrs crsgpa season)
* Season has a value of -0.11, which implies that ceteris paribus, we would 
* expect athletes in their sport's season to have a 0.11 lower GPA on average.
* The season variable is not statistically significant.
tsset id spring
reg D.trmgpa D.spring D.sat D.hsperc D.female D.black D.white D.frstsem D.tothrs D.crsgpa D.season
* The variables spring, sat, hsperc, female, black, and white are omitted (they
* either change or are the same as another variable).
* Season now has a value of -0.064 and is not significant.
* Some omitted variables of note could be variables that change when an athlete
* is in a sports season and are correlated to GPA. For instance, class 
* attendance and average sleep per night would be good to include. 

log close 
exit
