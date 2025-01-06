/*One-way ANOVA*/

/*One-way ANOVA serves the same purpose as a two-sample t-test
when we have more than 2 groups/samples 
- detecting between-group variation implying differences 
 in the group means 
*/

libname orion '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';


proc freq data=orion.ameshousing3;
table heating_qc;
run;


proc glm data=orion.ameshousing3 order=data plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution ;
run; 





/*Confidence intervals for the parameter estimates*/
title 'Confidence intervals for the parameter estimates';
proc glm data=orion.ameshousing3 order=data plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution clparm;
ods select ParameterEstimates;
run;



/*Prediction Intervals for predicting an individual house's SalePrice*/
title '95% Confidence Limits for Individual Predicted Value';
proc glm data=orion.ameshousing3 order=data plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution cli;
run; 

/*Prediction Intervals for the Mean Predicted Value*/
title '95% Confidence Limits for Mean Predicted Value';
proc glm data=orion.ameshousing3 order=data plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution clm ;
run;  
/*https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.3/statug/statug_glm_syntax16.htm*/

/*Sidenote: All prediction intervals are confidence intervals but not all confidence intervals
are prediction intervals*/