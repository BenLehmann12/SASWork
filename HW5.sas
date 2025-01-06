
libname stat4840 '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/Orion Data';


proc sort data=stat4840.staff out=SortInc;   
by Salary;
run;

proc sort data=stat4840.staff out=SortDec;  
by descending Salary;  
run;
 
proc print data=work.SortInc(obs=5 keep=Salary); 
run;
proc print data=work.SortDec(obs=5 keep=Salary); 
run;


ods trace on; 
proc print data=work.SortInc(obs=3);
id Employee_ID Job_Title;
var Salary;
run;
proc print data=work.SortDec(obs=3); 
id Employee_ID Job_Title;
var Salary;
run;
ods trace off;

/*--Histogram--*/

proc contents data=stat4840.employee_payroll;
run;

proc sgplot data=stat4840.employee_payroll;
  histogram Salary;
  density Salary / lineattrs=(pattern=solid);
  density Salary / type=kernel lineattrs=(pattern=solid);
  keylegend / location=inside position=topright across=1;
  yaxis offsetmin=0 grid;
run;

proc univariate data=stat4840.employee_payroll NExtrObs=5;
   var Salary;
run;

proc ttest data=stat4840.employee_payroll h0=40000 sided=l;
var Salary;
run;