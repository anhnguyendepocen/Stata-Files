clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\FE1.log", replace 

* #2
bcuse airfare

* #3
describe
* Observations: 4,596
* Variables: 16
* There are two string variables.

* #4
* The data are organized alphabetically by origin and then by destination.

* #5
count if origin=="BOSTON, MA"
* 188 observations originated in Boston, MA.
count if destin=="BOSTON, MA"
* 20 flights terminated in Boston, MA.

* #6
egen mindist=min(dist)
display mindist
* The shortest flight was 95 miles.
list if dist==mindist
* The shortest flight recorded flew from Cleveland, OH, to Detroit, MI.
egen maxdist=max(dist)
display maxdist
* The longest flight was 2,724 miles.
list if dist==maxdist
* The longest flight recorded flew from Miama, FL, to Seattle, WA.

* #7
* Bmktshr represents the market share of the biggest carrier for a flight.
sum bmktshr concen
reg bmktshr concen
* bmktshr and concen are the same variable.

* #8
egen monopoly=(bmktshr==1)
list if monopoly==1
* Atlantic City, NJ to Myrtle Beach, SC was a monopoly in 1997 and 1999.
* Atlantic City, NJ to Cleveland, OH was a monopoly in 2000.
* Kansas City, MO to Tulsa, OK was a monopoly in 1997 and 2000.

* #9
corr concen dist
corr concen ldist
* Concentration has a -0.5283 correlation with distance.
* Concentration has a -0.5319 correlation with log distance.

* #10
sum fare if year==1997
sum fare if year==1998
sum fare if year==1999
sum fare if year==2000
* Average Fares:
* 1997: 173.752
* 1998: 175.4413
* 1999: 177.9704
* 2000: 188.0235

* #11
g rfare=1 if year==1997
replace rfare=(164/161.5) if year==1998
replace rfare=(168.3/161.5) if year==1999
replace rfare=(174.1/161.5) if year==2000
display 177.9704/173.752, 168.3/161.5
* Real fare prices declined from 1997 to 1999.
display 188.0235/173.752, 174.1/161.5
* Real fare prices increased from 1997 to 2000.

* #12
g cpm = (fare)/(rfare*dist)
summarize cpm, detail
* 25th percentile: 0.134
* 50th percentile: 0.177
* 75th percentile: 0.262

* #13
corr cpm concen
* There is a 0.4071 correlation between cpm and concentration.
* This means that, in general, flights with more market power charge more.
* This doesn't conflict with out earlier observation that, in general, distance
* of a flight is negatively correlated with market concentration.

* #14
sort cpm
list if cpm in 1/1
* The cheapest flight was Los Angeles, CA to Providence, RI in 1999, which had
* a CPM value of 0.065.
gsort -cpm
list if cpm in 1/1
* The most expensive flight was from Cleveland, OH to Detroit, MI in 2000, which
* had a CPM value of 1.982.

* #15
list if passen>7500
* Los Angeles, CA to NY, NY had over 7500 passengers/day in 1997 and 1998.
* Ft. Lauderdale, FL to NY, NY had over 7500 passengers/day in 2000.

* 16
reg lpassen y98 y99 y00
disp (0.083)/3
* The average rate of growth in air travel over the four years was 2.76%.
* The growth was statistically significant between 1997 and 2000 but not between
* 1997 and any other year (at the 5% level of signifiance).

* 17
reg cpm passen dist concen
* Each of these explanatory variables are significant (well beyond 5%). 
* Passen and dist each have negative signs, which fits with the intuition that
* larger and lengthier flights are most cost efficient than short and fast ones.
* Concen has a positive sign, which agrees with the intuition that companies can
* charge higher fares if they have a larger market share. Market share raises 
* the price of fares, ceteris paribus.

* 18
reg cpm passen concen c.dist##c.dist
* The distance squared term is significant well beyong the 5% level. Because 
* distance has a negative sign and distance squared has a positive sign, this 
* means that the effect of distance on cpm is initially positive but eventually
* becomes negative with larger distances. This improves the models fit because
* the old one had an r-squared value of 0.31 while this one has a r-squared 
* value of 0.44, which means that it roughly explains 13% more of the variation
* in the data. This means that the previous model's estimates are likely biased.

* 19
margins, dydx(passen dist concen)

* 20
reg cpm c.passen##c.concen c.dist##c.dist
margins, dydx(passen dist concen)
* The interaction between passen and concen is significant. Regarding the
* marginal effects, passen became slightly more negative, concen decreased, 
* and dist stayed the same.


log close 
exit
