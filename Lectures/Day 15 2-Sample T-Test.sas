libname Orion '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';


/*Two-Sample T-Test
- Two independent samples
- Assumption: Equal Variances
- either data that are sufficiently close to being  Normally distributed or sample sizes large enough 
for the CLT to kick in*/

title "Test whether the true average sale price differs between houses with and without Masonry_Veneer";

proc univariate data=Orion.ameshousing3;
class masonry_veneer;
var saleprice;
run;


proc ttest data=ORION.ameshousing3 plots=box;
class masonry_veneer;
var saleprice;
run;
