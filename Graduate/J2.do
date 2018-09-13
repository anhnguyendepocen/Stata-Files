clear all
set more off
capture log close
cd "U:\"
log using ".\J2.log", replace
use "U:\Economics 705 Spring 2018 CPS MORG 2003 Data.dta"

* Problem 1
summarize earnwke, detail
* Earnings per week percentiles:
* 5th: 180
* 25th: 384
* 50th: 635
* 75th: 926.5
* 95th: 1794

* Problem 2
summarize earnwke if sex==1, detail
* Male earnings per week percentiles:
* 5th: 253
* 25th: 489
* 50th: 700
* 75th: 1057
* 95th: 2000
summarize earnwke if sex==0, detail
* Female earnings per week percentiles:
* 5th: 143
* 25th: 210
* 50th: 520
* 75th: 792
* 95th: 1442
* For any given percentile, the corresponding male percentile is higher than
* the female percentile. This may be due to factors like amount of work per
* week (single mothers may have part time jobs, etc.) or choice of industry.

* Problem 3
gen age2=age^2
generate _8l=0
replace _8l=1 if ihigrdc<=8
generate _910=0
replace _910=1 if ihigrdc==9 | ihigrdc==10
generate _11=0
replace _11=1 if ihigrdc==11
generate _12=0
replace _12=1 if ihigrdc==12
generate _1315=0
replace _1315=1 if 13<=ihigrdc<=15
generate _16g=0
replace _16g=1 if ihigrdc>=16
reg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g
hettest

* Problem 4
qreg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g
* The sex variable implies that the median observed observation in a sample
* will be 211.93 units higher on average than the median female observation.

* Problem 5
* All of the variables that are statistically significant at the 95% level
* in one regression are significant in the other as well.
* The regular regression has a higher estimate for the sex and 16 or greater
* variable, but the quantile regression has higher estimates for age.
* The estimates from OLS and quantile regression should coincide when
* we have heteroskedastic data.
* It isn't likely that we have heteroskedastic data because we observed
* significant deviations in the male and female quatniles. The hettest
* from problem 3 confirms this. Furthermore, the quantile regression
* reduces and increases certain estimators compared to the OLS regression.

* Problem 6
reg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g
predict resid, resid
gen resid2=resid^2
reg resid2 sex age age2 _8l _910 _11 _12 _1315 _16g
* From the regression, we see that sex and the dummy for 16 years of education
* or greater are both statistically significant and have large signs. This
* implies that these variables cause the regressions to be homoskedastic.
* This implies that quantile regressions may give better estimates for 
* the impact of the explanatory variables because it deals with 
* homoskedasticity better.

* Problem 7
set seed 123456789
bsqreg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g, reps(100)
* For sex, age, and age squared, the boostrapping procedure generated lower
* standard errors that the ones in the quantile regression. However, the
* boostrapping procedure generated a higher standard error for the 16 years
* or greater education varaible.

* Problem 8
set seed 123456789
sqreg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g, quantile(.25,.5,.75)

* Problem 9
test [q25]sex=[q50]sex=[q75]sex
* Because we observe a p-value of approximately 0.17, we can not reject the
* null hypothesis that the sex variable has distinct impacts on the
* estimated 25th, 50th, and 75th percentiles of the data.

* Problem 10
generate earncen=800
replace earncen=earnwke if earnwke<800
reg earncen sex age age2 _8l _910 _11 _12 _1315 _16g
reg earnwke sex age age2 _8l _910 _11 _12 _1315 _16g if earnwke<800
tobit earncen sex age age2 _8l _910 _11 _12 _1315 _16g
qreg earncen sex age age2 _8l _910 _11 _12 _1315 _16g
* Once again, most of the explanatory variables from before(sex, age, 
* age squared, over 16 years) are statistically significant in all of 
* these regressions. However, all of these regressions give significantly
* lower coefficient estimates for the variables of interest. Because of this,
* I believe either the tobit or median regression will give the best estimates.
* In particular, I believe the median regression may give better estimates
* because it utilizes variation above the censoring cutoff. This makes
* the tobit and median regression give similar estimates for sex, but the
* median regression gives a slightly higher estimate for education over
* 16, which makes sense beacuse it's a "Sheepskin level".

* Problem 11
generate college=1
replace college=0 if ihigrdc<16
drop if ihigrdc<=12

* Problem 12
ttest earnwke, by(college)
* Because the t-score equals -6.31, we can reject the null hypothesis that
* college makes no difference on mean earnings and conclude that going
* to college has some level of impact (325.44 on average) on earnings.

* Problem 13
summarize earnwke if college==1, detail
summarize earnwke if college==0, detail
* From inspection, it appears that the tenth percentile of college graduates
* earn 77 more (227 as opposed to 150).

* Problem 14
set seed 123456789
sqreg earnwke college, quantile(.1,.2,.3,.4,.5,.6,.7,.8,.9)
* From the multiple quantile regression, we see that college has a positive
* and statistically significant impact at all deciles listed. 

* Problem 16
test [q10]college=[q20]college=[q30]college=[q40]college=[q50]college=[q60]college=[q70]college=[q80]college=[q90]college
* Because we observe a p-value of approximately 0, we can reject the null 
* hypothesis that that attending college has homogeneous quantile treatment
* effects. From the results of the quantile regression, we can then conclude
* that attending college has a higher impact on high percentile earners
* than it does for lower percentile earners.

log close
exit
