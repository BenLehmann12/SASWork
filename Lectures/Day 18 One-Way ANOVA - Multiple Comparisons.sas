libname orion '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';


proc glm data=orion.ameshousing3 plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution;
lsmeans heating_qc / adjust=bon;
run;


proc glm data=orion.ameshousing3 plots=diagnostics;
class heating_qc;
model SalePrice = heating_qc / solution;
means heating_qc / hovtest = Levene;
lsmeans  heating_qc / adjust=bon;
ods select ParameterEstimates HOVFTest Means LSMeans Diff DiffPlot;
run;


/*Exercise*/

proc glm data=orion.garlic;
class fertilizer; /*class variable does not have to be character*/
model bulbwt = fertilizer / solution ;
run;

proc glm data=orion.garlic;
class fertilizer;
model bulbwt = fertilizer / solution;
lsmeans fertilizer / pdiff=control('1') adjust=dunnett;
run;


ods trace on;
proc glm data=orion.garlic;
class fertilizer;
model bulbwt = fertilizer / solution;
lsmeans fertilizer / pdiff=control('1') adjust=dunnett;
lsmeans fertilizer / adjust=tukey;
lsmeans fertilizer / adjust=T; /*No Adjustments*/
ods select Diff;
run;




