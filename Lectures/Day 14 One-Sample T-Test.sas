
libname stat4840 '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';


proc univariate data=stat4840.ameshousing3;
var lot_area;
run;

title "Distribution of Lot Area";
proc sgplot data=stat4840.ameshousing3;
histogram lot_area;
run;


/*default: H0 is mu is equal to 0 versus Ha: mu is not equal to 0*/
proc ttest data=stat4840.ameshousing3;
var lot_area;
run;


proc ttest data=stat4840.ameshousing3 h0=7000;
var lot_area;
run;

/*Interpretation: With 95% confidence, a 95% CI for mu, the true average of lot area ranges from 7,916.5 to 8.617.8 square feet*/


/*One-sided t-test*/
proc ttest data=stat4840.ameshousing3 h0=7000 sides=u;  /*Upper Sided t-test*/
var lot_area;
run;


proc ttest data=stat4840.ameshousing3 h0=7000 sides=l;  /*Lower Sided t-test*/
var lot_area;
run;