FILENAME REFFILE '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/eelworms.csv';
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.eelworms;
	GETNAMES=YES;
RUN;

proc freq data=work.eelworms;
    tables fumigant;
run;

proc freq data=work.eelworms;
    tables trt*fumigant / nocol norow nopercent;
run;



data eelworms_corrected;
set work.eelworms;
if fumigant = 'Car'  and dose = 0 then trt='Con0';
else trt=trt;
if fumigant = 'Car'  and dose = 0 then fumigant='Con';
else fumigant=fumigant;
run;

/*1b*/
PROC FREQ DATA=work.eelworms_corrected nlevels;
    TABLES fumigant;
RUN;


PROC FREQ DATA=work.eelworms_corrected;
    TABLES fumigant / NOCUM NOPERCENT;
RUN;

/*1c*/
DATA eelworms;
    SET work.eelworms_corrected;
    change = final - initial;
RUN;


proc glm data=work.eelworms plots=diagnostics;
    class fumigant;
    model change = fumigant;
run;

proc glm data=work.eelworms plots=diagnostics;
    class fumigant;
    model change = fumigant/solution;
run;



PROC GLM DATA=work.eelworms;
    CLASS fumigant;
    MODEL change = fumigant/solution;
    lsmeans fumigant / adjust=tukey;
RUN;


/*1f*/
PROC GLM DATA=work.eelworms;
    CLASS fumigant;
    MODEL change = fumigant/solution;
    MEANS fumigant / HOVTEST=levene;
RUN;

PROC GLM DATA=work.eelworms PLOTS(UNPACK)=ALL;
    CLASS fumigant;
    MODEL change = fumigant;
    MEANS fumigant / HOVTEST=levene;
RUN;

/**Question 7**/

/*7a*/
proc glm data=work.eelworms plots=diagnostics;
    class fumigant;
    model change = fumigant/solution clparm;
run;


proc glm data=work.eelworms_corrected plots=diagnostics;
    class fumigant;
    model change = fumigant/solution clparm;
run;

/*7c*/
proc glm data=work.eelworms plots=diagnostics;
    class fumigant(ref="Con");
    model change = fumigant/solution;
run;

/*7e*/
proc glm data=work.eelworms;
    class fumigant(ref="Con");
    model change = fumigant / solution;
    lsmeans fumigant / adjust=dunnett;
run;

/*7g*/

proc glm data=work.eelworms plots(unpack)=all;
    class fumigant(ref="Con");
    model change = fumigant / solution;
    lsmeans fumigant / adjust=tukey;

proc glm data=work.eelworms plots(unpack)=all;
    class fumigant(ref="Con");
    model change = fumigant / solution;
    lsmeans fumigant / adjust=bon;
run;



proc glm data=work.eelworms plots(unpack)=all;
    class fumigant(ref="Con");
    model change = fumigant / solution;
    lsmeans fumigant / adjust=bon;
    ods select LSMeans DiffMeans DiffPlot;
run;

proc glm data=work.eelworms plots(unpack)=all;
    class fumigant(ref="Con");
    model change = fumigant / solution;
    lsmeans fumigant / adjust=tukey;
    ods select LSMeans DiffMeans DiffPlot;
run;