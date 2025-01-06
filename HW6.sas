/*
If p-value < 0.05, reject the null hypothesis.
If p-value ≥ 0.05, fail to reject the null hypothesis.
*/


FILENAME REFFILE '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/eelworms.csv';
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;

proc ttest data=work.import;  /*Use Pairs, we have a final and inital variable*/
paired final * initial;
run;

proc ttest data=work.import alpha=0.10;  
paired final * initial;
run;

/*Question 2*/

data eeldiff;
set work.import;
diff = final-initial;
run;


data eelControl;
    set work.eeldiff;
    if fumigant = 'Con' then control = 1;
    else control = 0;  /* 1 for control, 0 for other treatments */
run;


data newEel;
    set work.eeldiff;
    if fumigant = 'Con' then treat = "N";
    else treat = "Y";  /* 1 for control, 0 for other treatments */
run;


proc ttest data=work.newEel;
    class treat;
    var diff;
run;


/*Question 3*/
data trees;
infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/TREES5.csv' dlm=',' dsd firstobs=2 truncover;
length cover_name $30 area $30;
input cover_name $ area $ elevation hdistfire;
run;


proc print data=work.trees(obs=20);
run;


/*Null Hypothesis (H₀): μ≤2600
Alternative Hypothesis (H₁): μ>2600*/



proc ttest data=work.trees h0=2600;
    var elevation;
run;


proc ttest data=work.trees h0=2600 side=u;
    var elevation;
run;

proc ttest data=work.trees h0=2600 side=l;
    var elevation;
run;

proc ttest data=work.trees h0=2600 sides=2;
    var elevation;
run;