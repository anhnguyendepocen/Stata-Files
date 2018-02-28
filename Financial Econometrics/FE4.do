clear                                                                         
set more off 
capture log close 
cd "L:\EC373"
log using ".\FE4.log", replace 

* Problem 3
bcuse nyse, clear
tsset t
gen return_12=return_1^2
reg return return_1 return_12
* From the results of the regression, it appears that the previous week's 
* have a positive effect and a negative squared effect on the current week's 
* returns, although without any statistical signifiance. 
test return_1 return_12
* From the t-test, we see that lagged returns do not have a statistically 
* significant impact on the current week's returns at the 10% level.
gen return_2=return_1[_n-1]
gen return_1i=return_1*return_2
reg return return_1 return_1i
test return_1 return_1i
* Once again, we see that when combined, the previous two weeks of returns do 
* not have a statistically significant impact on the current week's returns.
* From the results of these two tests, we can conclude that using lagged 
* weekly returns alone do not serve as strong predictors of future returns.

* Problem 11
bcuse okun, clear
tsset year
reg pcrgdp cunem
* For the constant, we got 3.34, and for the slope coefficient, we got -1.89. 
* Although these don't precisely match the theoretical results, their confidence
* intervals are fairly close to those for the theoretical values. This is 
* probably fine because Okun's law doesn't specify an appropriate gap to use 
* for the relationship.
test (cunem=-2)
* From the t-test, we see that we can't reject the null hypothesis that beta 
* equals -2 (the P-value equals 0.5521, which means this is fairly reasonable).
test (_cons=3)
* From the t-test, we see that we can reject the null hypothesis that the 
* constant equals 3 at the 5% level (the P-value equals 0.0399). 
test (cunem=-2) (_cons=3)
* From this test, we see that we can not reject the joint null hypothesis that
* the slope equals -2 and the constant equals 3 at the 10% level (the P-value
* equals 0.1017). This suggests that Okun's law has a good amount of validity,
* but it could still be improved by studying the slope parameter more closely.

* Problem 2
bcuse hseinv, clear
tsset year
dfuller linvpc, trend lags(2)
* From the ADF test, we see that the P-value equals 0.0004, so we can safely 
* reject the Unit Root null hypothesis at the 5% level.
dfuller lprice, trend lags(2)
* From the ADF test, we can see that the P-value equals 0.3749, so we can not 
* reject the null hypothesis that log price follows a unit root pattern.
* It doesn't make any sense to test for cointegration in this scenario because
* the invpc trend is I(0) but the price series is I(1), so we know that any 
* difference of the two will also follow the unit root pattern.

* Problem 5
bcuse intqrt, clear
gen obsn=_n
tsset obsn
regress hy6 L1.hy3 chy3 L1.chy3 L2.chy3
* From the coefficient of L1.hy3, we see that its t-value at 1 equals 
* (1.027-1)/0.015=1.8, so we can't reject the null hypothesis that beta is 1.
g hy6MLhy3=hy6-L1.hy3
regress chy6 L1.chy3 L1.hy6MLhy3 L2.chy3 L2.hy6MLhy3
test L2.chy3 L2.hy6MLhy3
* From this test, we see that the terms are neither significant nor jointly
* significant. Thus, this regression gives the same result as the original 
* model. 

* Problem 11
bcuse volat, clear
g lsp500=log(sp500)
g lip=log(ip)
dfuller lsp500, trend lags(4)
dfuller lip, trend lags(4)
dfuller lsp500, lags(4)
dfuller lip, lags(4)
* As we can see, both unit root tests fail to reject the null hypothesis,
* regardless of whether we include a time series trend or not,  so
* we can safely assume that both series follow a unit root pattern.
reg lsp500 lip
* As we can see from this regression, industrial production has a t-value of 
* 71.97, so it's incredibly significant to the SP index, and it has an 
* r-squared value of 0.9031, so it explains the majority of variance in the
* SP index.
predict resid, resid
dfuller resid, trend lags(2)
* From the ADF test, we see that the residuals in this regression follow a unit
* root pattern, so we can conclude that the two data series are not 
* cointegrated.
g trend=_n
tsset trend
reg lsp500 lip date trend
predict resid2, resid
dfuller resid2, trend lags(2)
* After adding a linear time trend, the ADF test still indicates that the 
* residuals follow a unit root pattern, so we can safely conclude that the two
* series of data are not cointegrated.
* Because the two series are not cointegrated, and each series follows a unit
* root pattern, it appears that the two series do not have an equilibrium 
* relationship at the linear relationship between the two was likely a result
* of a spurrious relationship and not a true trend.

* Problem 13
bcuse traffic2, clear
dfuller ltotacc
* From the standard ADF test, we see that the p-value equals 0.0144, so we can
* reject the Unit Root null hypothesis at the 2.5% level and conclude that the
* series is stationary.
dfuller ltotacc, lags(2)
* With the two lags, we can no longer reject the null hypothesis that the data
* series follows a unit root pattern.
dfuller ltotacc, trend lags(2)
* With two lags and a trend, we can once again reject the null hypothesis that
* the data series follows a unit root pattern at the 2.5% level and conclude 
* that the series is stationary.
* From the results from part 1-3, I would conclude that the time series is I(0)
* because including lags and a trend indicates that the series is stationary.
dfuller prcfat, lags(2)
dfuller prcfat, trend lags(2)
* From the results of the ADF tests, we can reject the unit root null hypothesis
* and conclude that prcfat is stationary. As we can see, the results from the
* are equivalent regardless of whether we include a trend or not.

log close 
exit
