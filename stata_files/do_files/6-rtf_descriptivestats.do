********************************************************************************
*					6) Tables with descriptive statistics
********************************************************************************

		*** --- Table 1 --- ***

*-----statistics table: overall (matrix B_o)

tabstat $outcomes , stat(mean sem n) save

matrix A_o = r(StatTotal)

matrix list A_o

local i = 1

foreach j of numlist 1/6 {
	
local medA = A_o[1, `j'] 
local seA =  A_o[2, `j'] 
local NA =   A_o[3, `j']

		if `i' == 1 {  
		matrix B_o =((`medA'),(`seA'),(`NA'))
		matrix colnames B_o = mean se N
		}
	
		else { 
		matrix C_o =((`medA'),(`seA'),(`NA'))
		matrix B_o = B_o\C_o
		}
	
local i = `i' +1
}

matrix rownames B_o = $outcomes

matrix list B_o


*-----two-sample ttest (matrix M_o)

local i = 1

foreach var in $outcomes {

ttest  `var', by(treatment) unequal
	
local medA = r(mu_1) 
local medB = r(mu_2)
local seA = (r(sd_1)/sqrt(r(N_1))) 
local seB = (r(sd_2)/sqrt(r(N_2)))
local NA = r(N_1) 
local NB = r(N_2)

		if `i' == 1 {  
		matrix M_o =((`medA'),(`seA'),(`NA'),(`medB'),(`seB'),(`NB'))
		matrix rownames M_o = `var'
		matrix colnames M_o = meanA seA NA meanB seB NB
		}
	
		else { 
		matrix S_o =((`medA'),(`seA'),(`NA'),(`medB'),(`seB'),(`NB'))
		matrix rownames S_o = `var'
		matrix M_o = M_o\S_o
		}
	
local i = `i' +1
}
	
matrix list M_o


*-----statistics table: overall + by treatment (matrix final)

matrix Outcomes = B_o, M_o

matrix list Outcomes, format(%9.4f)

esttab matrix(Outcomes) using "Tables_descriptives.rtf", replace ///
	rtf label collabels("Mean" "Std. error" "N" "Mean" "Std. error" "N" "Mean" "Std. error" "N") ///
	title("Table 1: Descriptive statistics for the outcome variables")

				
		*** --- Table A1 --- ***
		*** --- Descriptive statistics and balancing table --- ***

*-----statistics table: overall (matrix B)

tabstat treatment $main, stat(mean sem n) save

matrix A = r(StatTotal)

matrix list A

* set matsize 11000 *

local i = 1

foreach j of numlist 1/10 {
	
local medA = A[1, `j'] 
local seA =  A[2, `j'] 
local NA =  A[3, `j']

		if `i' == 1 {  
		matrix B =((`medA'),(`seA'),(`NA'))
		matrix colnames B = mean se N
		}
	
		else { 
		matrix C =((`medA'),(`seA'),(`NA'))
		matrix B = B\C
		}
	
local i = `i' +1
}

matrix rownames B = treatment $main

matrix list B


*-----two-sample ttest (matrix M)

* set matsize 11000 *

local i = 1

foreach var in treatment $main {

ttest  `var', by(treatment) unequal
	
local medA = r(mu_1) 
local medB = r(mu_2)
local pvalAB  = r(p) //ttest
local seA = (r(sd_1)/sqrt(r(N_1))) 
local seB = (r(sd_2)/sqrt(r(N_2)))
local NA = r(N_1) 
local NB = r(N_2)

		if `i' == 1 {  
		matrix M =.,.,(`NA'),.,.,(`NB'),.
		matrix rownames M = `var'
		matrix colnames M = meanA seA NA meanB seB NB p-value_AB
		}
	
		else { 
		matrix S =((`medA'),(`seA'),(`NA'),(`medB'),(`seB'),(`NB'),(`pvalAB'))
		matrix rownames S = `var'
		matrix M = M\S
		}
	
local i = `i' +1
}
	
matrix list M


*-----statistics table: overall + by treatment (matrix final)

matrix Controls = B, M

matrix list Controls

esttab matrix(Controls) using "Tables_descriptives.rtf", append ///
	rtf label collabels("Mean" "Std. error" "N" "Mean" "Std. error" "N" "Mean" "Std. error" "N" "T-test p-value")  ///
	title("Table A1: Descriptive statistics and balancing table")
	
	
		*** --- Table A3 --- ***	
		*** --- Mean donations by sociodemografic characteristics --- ***

foreach var of varlist gender {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/2 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist age_cat { 

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/5 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist mem_before {
	
tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/4 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist mem_future { 

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/4 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist income_decreased {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/5 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist income_future_decrease {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/5 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist health_affected {
	
tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/3 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist health_faffected {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/3 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist health_risk {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/3 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

foreach var of varlist health_affected {

tabstat playerdonation, by(`var') stat(mean sd n) save

local i = 1

	foreach j of numlist 1/3 {

	matrix A_`var' = r(Stat`j')

	matrix list A_`var'
	
	local medA = A_`var'[1, 1] 
	local seA =  A_`var'[2, 1] 
	local NA =   A_`var'[3, 1]

		if `i' == 1 {  
		matrix B_`var' =((`medA'),(`seA'),(`NA'))
		matrix colnames B_`var' = mean se N
		}
	
		else { 
		matrix C_`var' =((`medA'),(`seA'),(`NA'))
		matrix B_`var' = B_`var'\C_`var'
		}

	local i = `i' +1
	}

	levelsof `var', local(levels)
	local vlname: value label `var'
	
		foreach L of local levels {
		local vl: label `vlname' `L'
		local varlab = strtoname("`vl'") 
		global rows $rows `varlab'
		}

matrix rownames B_`var' = $rows

matrix list B_`var'

esttab matrix(B_`var') using "Tables_descriptives.rtf", rtf label collabels("Mean" "Std. error" "N") mtitles("`: variable label `var''") title("Table A3: Mean donations by category") append 

macro drop rows
}

