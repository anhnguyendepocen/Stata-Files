clear                                                                         
set more off 
capture log close 
cd "L:\EC373"

log using ".\BYRON.log", replace 

insheet using Political_ad_instances.csv, clear

*** Question 1 *** 

* Part A  
* WP_identifier = 740
* Archive ID = PolAd_TedCruz_nz65k
* This was an anti-Ted Cruz add that criticized him for flip-flopping on policy
* positions to gain more voters.
* Sponsor: Conservative Solutions PAC (affiliated with Marco Rubio)
* Message: Con
* Subject: Immigration and Trade
* Length: 30 seconds

* Part B
browse if wp_identifier==740
* Market Count: 4
tabulate network if wp_identifier==740
* Network Count: 16
table program if wp_identifier==740
* Total Programs: 104
tab location if wp_identifier==740
* Total Locations: 4
* Total Instances: 444

* Part C
generate hasTed = strpos(candidate, "Ted Cruz") > 0
tab hasTed
* Add Instances: 18,305
tab program if hasTed==1, nofreq
display r(r)
* Programs: 1,107
tab location if hasTed==1, nofreq
display r(r)
* Locations: 23
tab network if hasTed==1, nofreq
display r(r)
* Networks: 110

* Part D
* (code is repeated from part C)

* Hillary Clinton
* Add Instances: 38,405
* Programs: 1,548
* Locations: 23
* Networks: 117

* John Kasich
* Add Instances: 5,896
* Programs: 638
* Locations: 22
* Networks: 82

* Marco Rubio
* Add Instances: 34,640
* Programs: 1,422
* Locations: 23
* Networks: 119

* Bernie Sanders
* Add Instances: 32,856
* Programs: 1,261
* Locations: 23
* Networks: 105

* Donald Trump
* Add Instances: 26,843
* Programs: 1,476
* Locations: 23
* Networks: 115

*** Question 2 ***

* Part A
insheet using Political_ad_descriptions.csv, clear
generate hasTed = strpos(candidate, "Ted Cruz") > 0
sum air_count if hasTed==1
display r(sum)
* Total Instances: 18,305
tab market_count if hasTed==1
* Total Markets: 4

* Part B
browse if wp_identifier==740
* All good in the hood

* Part C
insheet using Political_ad_descriptions.csv, clear
save DESCRIPTIONS.dta, replace
insheet using Political_ad_instances.csv, clear
save INSTANCES.dta, replace
merge m:1 wp_identifier using DESCRIPTIONS.dta
save MASTER.dta, replace

* Part D
tab sponsor if message=="con" & candidate=="Donald Trump"
display r(r)
* 29 different organizations funded adds against Donald Trump.
tab sponsor if message=="pro" & candidate=="Donald Trump"
* From this command, it looks like Donald J. Trump For President
* funded over 7400 of the roughly 7800 adds which are pro Donald,
* so it appears that he did self fund.
* Note: this is for adds where Donald Trump was the main focus.

* Part E

* Swing States
generate inSwing = strpos(location,"NH")>0|strpos(location,"IA")>0|strpos(location,"VA")>0|strpos(location,"OH")>0|strpos(location,"CO")>0|strpos(location,"NV")>0|strpos(location,"FL")>0
tabulate message if inSwing==1
* In swing states, 66% of the messages were pro-candidate, 10% were con, and 13% were missed.
tabulate message if inSwing==1 & (candidate=="Bernie Sanders"|candidate=="Hillary Clinton")
* Among Democrats, 99% of the messages were pro-candidate.
tabulate message if inSwing==1 & (candidate=="John Kasich"|candidate=="Ted Cruz"|candidate=="Marco Rubio"|candidate=="Donald Trump")
* Among Republicans, 53% of the messages were pro, and 39% were con.
disp 25237/(25237+14752)
* 63% of the commercials in swing states were about Democrats.

* Democratic States
generate isDemocrat = strpos(location,"MA")>0|strpos(location,"NY")>0|strpos(location,"PA")>0|strpos(location,"CA")>0|strpos(location,"CA")>0|strpos(location,"MD")>0|strpos(location,"DC")>0
tabulate message if isDemocrat==1
* In Democratic States, 66% of the messages were pro, 13% were con and 14% were mixed.
tabulate message if isDemocrat==1 & (candidate=="Bernie Sanders"|candidate=="Hillary Clinton")
* Among Democrats, 95% of the messages were pro-candidate.
tabulate message if isDemocrat==1 & (candidate=="John Kasich"|candidate=="Ted Cruz"|candidate=="Marco Rubio"|candidate=="Donald Trump")
* Among Republicans, 60% of the ads were pro-candidate and 35% were con.
disp 14806/(10993+14806)
* 57% of the ads in Democratic states were about Democrats.

* Republican States
generate isRepublican = strpos(location,"NC")>0|strpos(location,"SC")>0
tabulate message if isRepublican==1
* In Republican states, 53% of the adds were pro, 17% were con and 19% were mixed.
tabulate message if isRepublican==1 & (candidate=="Bernie Sanders"|candidate=="Hillary Clinton")
* 99% of the ads about Democrats were positive in Republican States.
tabulate message if isRepublican==1 & (candidate=="John Kasich"|candidate=="Ted Cruz"|candidate=="Marco Rubio"|candidate=="Donald Trump")
* In Republican states, ads about Republicans were 60% pro, 32% con and 5% mixed.

* Ads were generally much more pro in Democratic and swing states as opposed to 
* Republican states. Democratic ads were generally much more positive. 
* Republican adds were generaly much more mixed, especially in Republican 
* States. For my R/D/S classifications, I just went based off of the identity
* of the state.

* Part F
tab message if candidate=="John Kasich"
tab message if candidate=="Hillary Clinton"
tab message if candidate=="Ted Cruz"
tab message if candidate=="Marco Rubio"
tab message if candidate=="Donald Trump"
tab message if candidate=="Bernie Sanders"
* Bernie Sanders received the most pro messages.
* Donald Trump received the most con messages.
* Note: this is among adds where each candidate was the main focus.

*** Question 3 ***

* Part A

generate MA = strpos(location,"MA")>0
generate maLAST = strpos(start_time,"2016-02-29")>0|strpos(start_time,"2016-02-28")>0|strpos(start_time,"2016-02-27")>0|strpos(start_time,"2016-02-26")>0|strpos(start_time,"2016-02-25")>0|strpos(start_time,"2016-02-24")>0|strpos(start_time,"2016-02-23")>0
generate maPEN = strpos(start_time,"2016-02-26")>0|strpos(start_time,"2016-02-17")>0|strpos(start_time,"2016-02-18")>0|strpos(start_time,"2016-02-19")>0|strpos(start_time,"2016-02-20")>0|strpos(start_time,"2016-02-21")>0|strpos(start_time,"2016-02-22")>0


table message, by(candidate)


log close 
exit
