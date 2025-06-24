clear


*****************************************************************
*****************************************************************
*****************************************************************
******** CODES USED TO GENERATE THE FIGURES OF THE PAPER ********
*** "Latent class models with persistence in regime changes" ****
*************** " A distributed lag analysis " ******************
*************** JOURNAL OF PRODUCTIVITY ANALYSIS ****************
*****************************************************************
********************** May 22, 2025 *****************************
*************** Authors: Luis Orea and Hervé Dapko **************
*****************************************************************
*****************************************************************
*****************************************************************

*****************************************************************
******** READING saved results from the estimated models  *******
*****************************************************************
use "C:\Users\luiso\Dropbox\research\DistributedLag_LCM\Replication_files\Data_figures.dta",  clear
sort cod t

***********************
**** Relative time ****
***********************
gen mismocod=0
replace mismocod=1 if cod==cod[_n-1]
gen tini=.
replace tini=t if mismocod!=1
bys cod: egen tini2=mean(tini)
drop tini
ren tini2 tini
gen tr=t-tini+1

******************************************************************
******************************************************************
******** Figure 1. Distributions of farm size and lambda. ********
******************************************************************
******************************************************************

frame copy default initial_sample
frame change initial_sample
*** graphs ***
twoway (kdensity lsau), subtitle ( Farm size ) ytitle("Density") xtitle("Land") graphregion(color(white)) saving(land)
twoway (kdensity lambda_het), xtitle(Coefficient) ytitle(Density) subtitle(Lambda) graphregion(color(white)) saving(lambda)
** combine & erase **
graph combine land.gph lambda.gph, graphregion(color(white))
erase land.gph 
erase lambda.gph
frame change default
frame drop initial_sample

*************************************************************************
*************************************************************************
**** Figure 2. Volatility of the RP ratios and degree of persistence ****
*************************************************************************
*************************************************************************

frame copy default initial_sample
frame change initial_sample
** tr>= 4 **
collapse (mean) lsau lambda_het (sd) lnrp_lcm lnrp_hom lnrp_het if tr>=4, by(cod)
sort lambda_het
** outliers *
drop if cod==219
drop if cod==266
gen lnRPcon2=lnrp_het
*winsor* 
winsor lnRPcon2, gen(wlnRPcon2) p(0.025)
winsor lambda_het, gen(wlambda_het) p(0.025)
*pctile*
egen p1=pctile(lnRPcon2), p(2.5)
egen p2=pctile(lnRPcon2), p(97.5)
gen plnRPcon2=lnRPcon2 if (lnRPcon2>=p1 & lnRPcon2<=p2)
drop p1 p2
egen p1=pctile(lambda_het), p(2.5)
egen p2=pctile(lambda_het), p(97.5)
gen plambda_het=lambda_het if (lambda_het>=p1 & lambda_het<=p2)
drop p1 p2
** graph pctile **
twoway (scatter plnRPcon2 plambda_het, mlabel(cod) mlabposition(12))(lfit plnRPcon2 plambda_het), ytitle(lnRP volatility) xtitle(Lambda) legend(off) graphregion(color(white))
frame change default
frame drop initial_sample


******************************************************
**** Estimated parameters of Heterogeneous DL-LCM ****
******************************************************

*** parameter estimates ****
/*
UNOS            -0.2446        0.2228   -1.098   0.2723      0.0000
LPIEVAC          7.3785        0.9196    8.024   0.0000      0.0000
LVACSAU         -0.1264        0.3239   -0.390   0.6963      0.0000
LAMBDA0          0.4046        0.2552    1.585   0.1129      0.0000
LAM_SAU         -0.8339        0.3534   -2.360   0.0183      0.0000
LAM_0           -3.6315        1.3452   -2.700   0.0069      0.0000
*/

gen UNOS=-0.2446
gen LPIEVAC=7.3785
gen LVACSAU=-0.1264
gen LAMBDA0=0.4046
gen LAM_SAU=-0.8339 
gen LAM_0=-3.6315

*** Alternative lnRP with persistence (het) ***
gen lnRPcon=lnrp_het
gen lambda=lambda_het


********************************************
******* reproducing estimated lnRP  ********
********************************************
sort cod t
gen t1=0
replace t1=1 if cod!=cod[_n-1]		// first observation //
gen lnRPcon2=lnRPcon*t1

local j = 2
while `j' < 11 {
gen t`j'=0
replace t`j'=1 if t==`j' 
gen lnRPanterior=lnRPcon2[_n-1]
replace lnRPanterior=0 if lnRPanterior==.
gen lnRPcon2new=lnRPcon2+t`j'*((1-lambda)*(UNOS+LPIEVAC*lpievac+LVACSAU*lvacsau)+lambda*lnRPanterior)*mismocod
drop lnRPcon2 lnRPanterior
ren lnRPcon2new lnRPcon2
drop t`j'
local j = `j' + 1
}
sum  lnRPcon lnRPcon2
corr lnRPcon lnRPcon2			// tienen que salir iguales, si no es que algo es incorrecto  //

*** rounding numbers ***
gen lambda_lcm3=round(lnRPcon*100)/100
drop lnRPcon
ren lambda_lcm3 lnRPcon
gen lambda_lcm3=round(lnRPcon2*100)/100
drop lnRPcon2
ren lambda_lcm3 lnRPcon2

*** simulación de lnRP sin inercia (usando q) ***
gen lnRPsin2=UNOS+LPIEVAC*lpievac+LVACSAU*lvacsau
sum  lnRPsin2 lnRPcon2
corr lnRPsin2 lnRPcon2

*** rounding numbers ***
gen lnRPsin3=round(lnRPsin2*100)/100
drop lnRPsin2
ren lnRPsin3 lnRPsin2

*******************************************************************************
* Selection of a balanced panel dataset of farms to issue Appendices' figures * 
*******************************************************************************
keep if stiv==10
gen cod_anterior=cod
drop cod
egen cod=group(cod_anterior)

stop


***************************************************************************
***************************************************************************
*** Appendix 2. Temporal evolution of estimated and simulated RP ratios ***
***************************************************************************
***************************************************************************

*********************************
*** Issuing individual graphs ***
*********************************

local j = 1
while `j' < 108 {
twoway (line lnRPsin2 year if (cod==`j' & year>=2005), lpattern(dash)) (line lnRPcon2 year if (cod==`j' & year>=2005)), title (Farm `j') graphregion(color(white)) xlabel(2005(2)2014) saving(cod`j') legend( label(1 Sim.) label(2 Est.))
local j = `j' + 1
}

*** Combining figures ***
graph combine cod1.gph cod2.gph cod3.gph cod4.gph cod5.gph cod6.gph cod7.gph cod8.gph cod9.gph cod10.gph cod11.gph cod12.gph cod13.gph cod14.gph cod15.gph cod16.gph cod17.gph cod18.gph cod19.gph cod20.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod21.gph cod22.gph cod23.gph cod24.gph cod25.gph cod26.gph cod27.gph cod28.gph cod29.gph cod30.gph cod31.gph cod32.gph cod33.gph cod34.gph cod35.gph cod36.gph cod37.gph cod38.gph cod39.gph cod40.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod41.gph cod42.gph cod43.gph cod44.gph cod45.gph cod46.gph cod47.gph cod48.gph cod49.gph cod50.gph cod51.gph cod52.gph cod53.gph cod54.gph cod55.gph cod56.gph cod57.gph cod58.gph cod59.gph cod60.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod61.gph cod62.gph cod63.gph cod64.gph cod65.gph cod66.gph cod67.gph cod68.gph cod69.gph cod70.gph cod71.gph cod72.gph cod73.gph cod74.gph cod75.gph cod76.gph cod77.gph cod78.gph cod79.gph cod80.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod81.gph cod82.gph cod83.gph cod84.gph cod85.gph cod86.gph cod87.gph cod88.gph cod89.gph cod90.gph cod91.gph cod92.gph cod93.gph cod94.gph cod95.gph cod96.gph cod97.gph cod98.gph cod99.gph cod100.gph, saving(All) graphregion(color(white))
erase All.gph

local j = 1
while `j' < 108 {
erase cod`j'.gph 
local j = `j' + 1
}
*erase All.gph


***************************************************************************
***************************************************************************
****** Appendix 3. Temporal evolution of estimated RP ratios       ******** 
******             using standard and DL specifications of our LCM ********
***************************************************************************
***************************************************************************

*********************************
*** Issuing individual graphs ***
*********************************

local j = 1
while `j' < 108 {
twoway (line lnrp_lcm year if (cod==`j' & year>=2005), lpattern(dash)) (line lnRPcon2 year if (cod==`j' & year>=2005)), title (Farm `j') graphregion(color(white)) xlabel(2005(2)2014) saving(cod`j') legend( label(1 LC) label(2 DL-LC))
local j = `j' + 1
}

*** Combining figures ***
graph combine cod1.gph cod2.gph cod3.gph cod4.gph cod5.gph cod6.gph cod7.gph cod8.gph cod9.gph cod10.gph cod11.gph cod12.gph cod13.gph cod14.gph cod15.gph cod16.gph cod17.gph cod18.gph cod19.gph cod20.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod21.gph cod22.gph cod23.gph cod24.gph cod25.gph cod26.gph cod27.gph cod28.gph cod29.gph cod30.gph cod31.gph cod32.gph cod33.gph cod34.gph cod35.gph cod36.gph cod37.gph cod38.gph cod39.gph cod40.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod41.gph cod42.gph cod43.gph cod44.gph cod45.gph cod46.gph cod47.gph cod48.gph cod49.gph cod50.gph cod51.gph cod52.gph cod53.gph cod54.gph cod55.gph cod56.gph cod57.gph cod58.gph cod59.gph cod60.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod61.gph cod62.gph cod63.gph cod64.gph cod65.gph cod66.gph cod67.gph cod68.gph cod69.gph cod70.gph cod71.gph cod72.gph cod73.gph cod74.gph cod75.gph cod76.gph cod77.gph cod78.gph cod79.gph cod80.gph, saving(All) graphregion(color(white))
erase All.gph

graph combine cod81.gph cod82.gph cod83.gph cod84.gph cod85.gph cod86.gph cod87.gph cod88.gph cod89.gph cod90.gph cod91.gph cod92.gph cod93.gph cod94.gph cod95.gph cod96.gph cod97.gph cod98.gph cod99.gph cod100.gph, saving(All) graphregion(color(white))
erase All.gph

local j = 1
while `j' < 108 {
erase cod`j'.gph 
local j = `j' + 1
}
*erase All.gph


*******************************************
*******************************************
****** END of the replication file ******** 
*******************************************
*******************************************
