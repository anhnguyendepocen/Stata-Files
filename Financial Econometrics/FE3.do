clear                                                                         
set more off 
capture log close 
cd "L:\EC373"
log using ".\FE3.log", replace 

* Problem 2
bcuse loanapp, clear
reg approve white
probit approve white
* Between the two models, the models provide slightly different numbers, but 
* being white strongly increases your chance at receiving a loan with a high
* amount of statistical significance. 
probit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
* After controlling for these other factors, being white still significantly
* improves your chances at receiving a loan. 
logit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
* Using the logit model instead of a probit model still reveals that being white
* has a positive and statistically significant impact on your probability of 
* receiving a housing loan.
margins, at(white=0 white=1)
disp 0.8963808-0.7955101
* The discrimination effect for logit equals 0.1008707.
probit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
margins, at(white=0 white=1)
disp .8965419-.7923174
* The discrimination effect for probit equals 0.1042245.

* Problem 3
bcuse fringe, clear
sum pension, detail
tab pension if pension==0
disp 172/616
* 27.92% of the people in this sample don't have a pension. People with pensions
* have values ranging from 7.92 to 2880.27. A tobit model is appropriate for 
* estimating pensions because a high percentage of observations stop at a 
* specific cutoff (i.e. 0).
tobit pension exper age tenure educ depends married white male, ll(0)
* Male has a positive and statistically significant impact of predicted values
* for pensions. White does not have a statistically significant relationship
* with pensions.
margins, at(age=35 married=0 depends=0 educ=16 exper=10 white=1 male=1)
margins, at(age=35 married=0 depends=0 educ=16 exper=10 white=0 male=0)
disp 860.1239-407.8879 
* We would expect a white man to have a pension 452.236 higher than a nonwhite
* female with these given characteristics.
tobit pension exper age tenure educ depends married white male union, ll(0)
* Union has a statistically significant and positive coefficient (439.046),
* which has a stronger impact than all of the other explanatory variables.
tobit peratio exper age tenure educ depends married white male union, ll(0)
* Neither gender nor race have a statistically significant impact on peratio.

* Problem 6
bcuse recid, clear
reg ldurat workprg priors tserved felon alcohol drugs black married educ age if cens==0
* Drugs, black, and age all went from being statistically significant to being
* insignificant. In addition, all of the remaining statistically significant
* variables had a lower impact on ldurat. 

* Problem 9
bcuse apple, clear
tab ecolbs if ecolbs==0
* 248 families demanded no ecofriendly apples.
tab ecolbs
* It looks like ecolbs has a reasonably continuous distribution at lower levels
* but incremental demands start to increase towards higher levels. 
tobit ecolbs ecoprc regprc faminc hhsize, ll(0)
* Ecoprc and regprc are statistically significant at the 1% level.
test faminc hhsize
* Almost - they are jointly significant at the 7.74% level.
* Yes - they make sense because people would want more ecoapples if regular 
* apples were more expensive and fewer if ecoapples were more expensive.
test ecoprc=-regprc
* This test has a p-value of 0.7787, so we can not reject the null hypothesis
* that ecoprc and regprc are opposites.
predict yhat
sum yhat, detail
* Smallest fitted value: -1.36
* Largest fitted value: 2.95
corr yhat ecolbs
disp 0.1971^2
* Squared correlation: 0.03884841
reg ecolbs ecoprc regprc faminc hhsize
* The OLS estimates are much smaller because this model includes all of the 
* people that demanded 0 ecoapples, so there is much less relative variation
* in the dependent variable. The tobit model is slightly better in terms of
* goodness-of-fit (0.0393 r-squared vs. 0.0388).
* This statement is probably false. Although the linear model did a better job
* of predicting overall variation, people who purschased zero ecoapples 
* probably did not factor prices into their decision, so the variation in that
* data does not necessarily have causal implications for the specific amount
* of ecoapples purchased in general.

* Problem 13
bcuse htv, clear
reg lwage educ abil exper nc west south urban
* For this model, each additional year of education corresponds to a 10.37% 
* increase in wage on average. The standard error for the education coefficient
* equals 0.0096.
reg lwage educ abil exper nc west south urban if educ<16
disp 1-(1064/1230)
* The size of the sample decreased by 13.49%. The new predicted estimate is that
* each additional year of education corresponds to a 11.81% increase in wage
* on average. 
reg lwage educ abil exper nc west south urban if wage<20
* This new model predicts that each additional year of education will correspond
* to a 5.79% increase in wage on average. 
truncreg lwage educ abil exper nc west south urban, ul(log(20)) nolog
* The new predicted value for educ equals 0.106, which is pretty close to the
* 0.1037 that we observed in part a. That being said, I think that the truncreg
* gives a pretty sound estimate for the population because the coefficients are
* 0.0023 units apart, and there still may be some variation in our population
* estimate because it is efficient, but it may not have a large enough sample
* to give the best possible prediction.

log close 
exit
