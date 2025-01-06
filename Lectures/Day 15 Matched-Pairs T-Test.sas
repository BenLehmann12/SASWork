/*Match Pairs T-Test*/

/*
-2 samples but they are NOT Independent: "pre-" and "post-" measurement
on the same group of individuals
-Measure same individuals twice by at different points in time (there is some sort of intervention in between)
-To test if there is a difference between pre and post measurement
    - Calculate pairwise differences (SAS will do it)
    - One-Sample t-test of the pairwise differences
*/

proc ttest data=ORION.market;
paired pre*post;
run;

proc ttest data=ORION.market;
paired post*pre;
run;