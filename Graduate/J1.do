clear all
set more off
capture log close
cd "U:\"
log using ".\J1.log", replace
use "U:\Economics 705 Spring 2018 NJS Data.dta"

* Part 1
generate treat=0
replace treat=1 if ra_stat==1

* Part 2
drop if mi(esum18i)

* Part 3
sum if treat==1
sum if treat==0
* There do not appear to be many large differences in the baseline variables
* unrelated to the experiment. In particular, race, age, and sex are all very
* close, and the treatment has slightly higher earnings before the program.

* Part 4
ttest age, by(treat)
ttest sex, by(treat)
ttest bfeduca, by(treat)
ttest bfyrearn, by(treat)
* We can not reject the null hypothesis of group mean equality in any of these
* tests, so it appears that the baseline variables are fairly similar.

* Part 5
sum bfeduca if treat==1
sum bfeduca if treat==0
display (11.31795-11.21016)/((2.157825^2+2.343289^2)/2)^0.5
* The baseline difference is only 0.047, which is far smalller than the 
* proposed cutoff. This indicates that the baseline level of schooling
* between the groups is fairly similar.

* Part 6
ttest esum18i, by(treat)
* According to the t-test, the treatment group's earnings exceeded the control
* groups earnings by 351.55. The t-value for this test is 2.04, so the results
* are statistically significant.

* Part 7
reg esum18i treat
* As in the previous problem, the regression predicts that individuals in the
*treatment group will earn 351.55 more on average. Furthermore, the t-score
* is ~2.05, so this finding is statistically significant. Because a regression
* with one variable is equivalent to a t-test, it makes sense that the findings
* are equivalent.

* Part 8
reg esum18i treat sex race age totch18 child_miss bfeduca ed_miss bfyrearn earn_miss site_num
* This time, the regression predicts that the treated group earns 370.02 more on
* average, and this estimate is still statistically significant. The standard
* error for this parameter is lower this time around because we can account for
* more variation by using the other baseline variables. This estimate is likely
* biased because the race variable is coded to one variable, which means that 
* the regression forces the impact of changing between races to be equal.

* Part 9
sum enroll if treat==1
* 64.94% of the treatment group is enrolled in the program. 
ivregress 2sls esum18i sex race age totch18 child_miss bfeduca ed_miss bfyrearn earn_miss site_num (enroll = treat)
* The IV regression estimates that the enrolled individuals will earn 596.14
* more on average. The t-score for enroll is 2.34, so this is statistically
* significant. In the common effect world, we would assume that every enrolled
* individual earned 596.14 more. In the heterogeneous treatment world, we would
* assume that treated individuals earned 596.14 more on average. For this model,
* we assume that enroll and treat are correlated and that esum18i and treat are
* uncorrelated.

* Part 10
reg esum18i treat sex race age totch18 child_miss bfeduca ed_miss bfyrearn earn_miss site_num if sex==0
reg esum18i treat sex race age totch18 child_miss bfeduca ed_miss bfyrearn earn_miss site_num if sex==1
* From the separate regressions, we see that the treatment effect equals 467.1
* for women and 247.41 for men. The t-score for women equals 2.67, so the 
* treatment is statistically significant for women, but the t-score for men
* is 0.88, so the treatment is not statistically significant for men.
gen treatSex = treat*sex
reg esum18i treat sex treatSex race age totch18 child_miss bfeduca ed_miss bfyrearn earn_miss site_num
* This method generates a treatment coefficient for 461.23 for women. The 
* t-score is 2.19, so this is statistically significant. The treatment 
* interaction term has a coefficient of -209.18, so men are estimated to earn
* 252.05 more on average. However, the interaction term has a t-score of
* 0.66, so this is not statistically significant.
* The first method is likely preferable because it allows the baseline
* covariates to have different impacts for the two sexes.

* Part 11
sum esum18i if treat==1
sum esum18i if treat==0
* The standard deviation is slightly higher in the treatment group. 
sdtest esum18i, by(treat)
* Because the F-statistic is close to 1, we can not reject the null hypothesis
* that esum18i has equal variances for the treatment and control group. This
* implies that there is a homogeneous treatment effect because the treatment
* effect did not impact the group variance for the group that received it.

* Part 12
generate employ=0
replace employ=1 if esum18i>0

* Part 13
tab employ treat, cell
* From the table, we can compute that the Frechet-Hoffding bounds for the (0,0)
* entry is 0<=p(0,0)<=17.45. 

log close
exit
