libname orion "/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/Orion Data";



proc sort data=orion.nonsales;
by Employee_ID Gender;
run;

proc sort data=orion.nonsales2;
by Employee_ID Gender;
run;


data nonsales_all;
merge orion.nonsales (in=NS1)
      orion.nonsales2 (in=NS2);
by Employee_ID Gender;
if NS1=1 and NS2=1;
run;