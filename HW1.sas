/*B*/
data allCars;
    set sashelp.cars;
run;

proc print data=allcars; /*There were 428 observations */
run;

/*C*/
proc contents data=allcars;
run;

/*D*/
proc print data=allcars (firstobs=55 obs=60);
   var make type origin drivetrain msrp invoice;
run;

/*E*/

data suvs;         /*Create our Main Dataset for SUV */      
   set sashelp.cars;
   where Type = "SUV";
run;

/*F*/
data suvsAsia;  /*Create a new Dataset for all the SUV's from Asia*/
   set work.suvs;
   where Origin = "Asia";
run;


/*G*/
data suvMakes;
  set work.suvs;
  where make in('Hummer', 'BMW', 'Toyota');
run;

/*H*/
data suvPrices;
   set work.suvs;
   where msrp between 45000 and 55000;
run;

/*I*/
proc means data=work.suvs min max mean median;
   var msrp;
run;


/*J*/
proc sort data=work.suvsasia;
   by make;
run;

/*K*/
proc print data=work.allcars;  /*General */
   var type origin msrp invoice;
   sum msrp invoice;
   by make;
run;

proc print data=work.allcars;  /*For Nissan */
   var make type origin msrp invoice;
   sum msrp invoice;
   by make;
   where make = 'Nissan';
run;


/*Question 2*/

PROC CONTENTS DATA=WORK.TREES;
RUN;

proc print data=work.trees; 
run;

/* 2b */
proc sort data=WORK.TREES;
    by descending area descending cover_name;
run;

proc sort data=WORK.TREES;
    by area cover_name;
run;


data first_obs;
  set Work.trees(obs=1);
run;


/*2c*/
data last_obs;
    set work.trees end=last;
    if last;
run;


/*2e*/
proc sort data=WORK.TREES;
    by cover_name area;  /*Cover_name area */
run;

proc means data=work.trees;
    class area cover_name;  
run;


/*2f*/

proc sort data=work.trees out=DL NODUPKEY;
   by cover_name are;
run;