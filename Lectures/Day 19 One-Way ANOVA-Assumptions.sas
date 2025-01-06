libname orion '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';

/*Checking Assumptions*/

proc glm data=orion.garlic plots=diagnostics;
class fertilizer; /*class variable does not have to be character*/
model bulbwt = fertilizer / solution ;
means fertilizer / hovtest=levene;   /*Only work for one-way ANOVA*/
run;  /*Use rule of thumb when we have a two-way or k-way ANOVA*/

/*This gives us an R-squared value*/



proc glm data=orion.garlic plots(unpack)=diagnostics;
class fertilizer; /*class variable does not have to be character*/
model bulbwt = fertilizer / solution ;
means fertilizer / hovtest=levene;   /*Only work for one-way ANOVA*/
run;  /*For Normality, look for QQ plot */


/*Look for Levene's Test for Homogenity Table*/
/*Null:Variance1 = Variance2 = Variance 3 = Variance 4 */
/*Alternative: At least one of the Variance is different from the rest*/
/*Hoping for a Large P-value --> Lack sufficent evidence that at least one variance is different
--> Assume assumption is fulfilled */

/*Rule of Thumb: S(max)^2/S(min)^2 <= 2*/