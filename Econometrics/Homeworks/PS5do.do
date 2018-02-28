clear                                                                         
set more off 
capture log close 
cd "L:\EC227"

log using ".\Assignment5.log", replace 
use "L:\EC227\ps5q1", clear

* Part B
reg fare dist bmktshr passen

* Part D
sum fare dist bmktshr passen
reg fare bmktshr passen

* Part E
reg fare dist bmktshr passen
test (dist=0) (passen=0)

* Part F
reg fare
reg fare dist bmktshr passen
test (dist=0) (passen=0) (bmktshr=0)

* Part H(a)
reg fare dist bmktshr passen
test (dist=passen)

* Part H(d)
gen distpluspassen=dist+passen
reg fare dist bmktshr distpluspassen

log close 
exit

