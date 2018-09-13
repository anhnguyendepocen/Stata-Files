clear all
set more off
capture log close
cd "U:\"
log using ".\E1.log", replace

* Problem 2

program define myreg, rclass
drop _all
set obs 25
gen x = runiform(1,4)
gen e = rnormal(0,x^2)
gen y = 0.5*(-2.5 + e)
reg y
return scalar b0=_b[_cons]
end

simulate b_0=r(b0), reps(100): myreg
sum

log close
exit
