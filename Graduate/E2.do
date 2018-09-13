clear all
set more off
capture log close
cd "U:\"
log using ".\E2.log", replace

* Problem 2
quietly reg lnviol llnswornpc lag_llnswornpc unemprate lnsta_welf lnsta_educ a15_24 citybla cityfemh yy* cc* cs* rr* if year>=73
estimates table, keep (llnswornpc lag_llnswornpc) b p se
quietly reg dlnviol dllnswornpc lag_dllnswornpc dunemprate dlnsta_welf dlnsta_educ da15_24 dcitybla cityfemh yy* cc* cs* rr* if year>=72
estimates table, keep(dllnswornpc lag_dllnswornpc) b p se

quietly reg dlnviol dllnswornpc lag_dllnswornpc dunemprate dlnsta_welf dlnsta_educ da15_24 dcitybla cityfemh yy* cc* cs* rr* if year>=72, robust
estimates table, keep(dllnswornpc lag_dllnswornpc) b p se

quietly ivregress 2sls dlnviol dunemprate dlnsta_welf dlnsta_educ da15_24 dcitybla cityfemh yy* cc* cs* rr* (dllnswornpc lag_dllnswornpc = elecyear governor lagelecyear laggovernor) if year>=72, robust
estimates table, keep(dllnswornpc lag_dllnswornpc) b p se

predict resid if e(sample), r
bysort crimenum: egen holdstd=sd(resid)
quietly ivregress 2sls dlnviol dunemprate dlnsta_welf dlnsta_educ da15_24 dcitybla cityfemh yy* cc* cs* rr* (dllnswornpc lag_dllnswornpc = elecyear governor lagelecyear laggovernor) if year>=72 [w=holdstd], robust
estimates table, keep(dllnswornpc lag_dllnswornpc) b p se
quietly ivregress 2sls dlnviol dunemprate dlnsta_welf dlnsta_educ da15_24 dcitybla cityfemh yy* cc* cs* rr* (dllnswornpc lag_dllnswornpc = elecyear governor lagelecyear laggovernor) if year>=72 [w=1/holdstd^2], robust
estimates table, keep(dllnswornpc lag_dllnswornpc) b p se

log close
exit
