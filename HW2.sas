/*1a*/
libname homework '/home/u63679711/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Assignments';
data work.conference;
    set homework.conference;
run;

proc contents data=work.conference;
run;  /*17 variables and 4333 observations


/*1b*/
data phone515;
   set work.conference;
   where AreaCode = '515'; 
run;

/*1c*/
data phone510;
   set work.conference;
   where AreaCode = '510'; 
run;

/*1d*/
proc means data=work.conference n nmiss sum mean median var p25 p75 maxdec=1;
    var Rate;
run;

/*1e*/
/*1 way*/
data conf;
  set work.conference;
  where upcase(Restrictions) contains "VEG";
  keep Firstname LastName Restrictions;
run;

/*Another way*/
data vegan_vegetarian;
  set work.conference;
  where Restrictions in ('Vegan','vegan', 'vegan only','I need a vegetarian meal','vegan meal','I eat vegetarian only','VEGAN only',
  'Vegetarian only','vegetarian','Vegetarian','Vegetarian meal','I need a Vegetarian meal');
  keep FirstName LastName Restrictions;
run;

/*1f*/
data vegan_convert;
  set work.conference;
  if Restrictions in (('Vegan','vegan', 'vegan only','I need a vegetarian meal','vegan meal','I eat vegetarian only','VEGAN only',
  'Vegetarian only','vegetarian','Vegetarian','Vegetarian meal','I need a Vegetarian meal')) then IfVeg=1;
  else IfVeg=0;
run;

/*Question 2*/
libname homework '/home/u63679711/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Assignments';
data work.crayons;
	set homework.crayons;
run;


/*Q 2a */
proc contents data=work.crayons;  /*Length=26, Label=Crayon Name */
run;


/* Q 2b*/

proc freq data=work.crayons;
  tables Issued;
run;


/* Q 2c-a */
proc sort data=work.crayons;
   by RGB;
run;

proc print data=work.crayons(obs=20);
var Color RGB;
run;


/* Question 3 */
data Color;
   input Region Eyes $ Hair $ Count @@;
   label Eyes  ='Eye Color'
         Hair  ='Hair Color'
         Region='Geographic Region';
   datalines;
1 blue  fair   23  1 blue  red     7  1 blue  medium 24
1 blue  dark   11  1 green fair   19  1 green red     7
1 green medium 18  1 green dark   14  1 brown fair   34
1 brown red     5  1 brown medium 41  1 brown dark   40
1 brown black   3  2 blue  fair   46  2 blue  red    21
2 blue  medium 44  2 blue  dark   40  2 blue  black   6
2 green fair   50  2 green red    31  2 green medium 37
2 green dark   23  2 brown fair   56  2 brown red    42
2 brown medium 53  2 brown dark   54  2 brown black  13
;

proc freq data=Color;
   tables Eyes Hair Eyes*Hair / out=FreqCount outexpect;
   weight Count;
   title 'Eye and Hair Color of European Children';
run;

/*Obtaining a table of the frequency counts including the expected counts*/
proc print data=FreqCount noobs;
   title2 'Output Data Set from PROC FREQ';
run;

/*Sort data by Region variable*/
proc sort data=Color;
   by Region;
run;

/*3b */
proc freq data=Color order=data;
   tables Hair / nocum chisq testp=(30 12 30 25 3) plots(only)=deviationplot;
   weight Count;
   by Region;
   title 'Hair Color of European Children';
run;

/*Region 1:Chi-Square: 7.760, DF=4, P=0.1008  */
/*Region 1:Since our p-value is greater than 0.001 and equal to 0.10, we can say that we have weak evidence,suggesting that the observed frequencies of eye and hair color combinations do not significantly differ from the expected frequencies. Therefore, we fail to reject the null hypothesis.  */

/*Region 2: Chi-square: 21.3824, DF=4, P=0.0003
Region 2: Since our p-value is less than 0.01 but greater than 0.001 we have strong evidence against our null hypostheses
This indicates strong evidence against the null hypothesis, meaning the observed frequencies of eye and hair color combinations differ significantly from the expected frequencies. Thus, we reject the null hypothesis for Region 2. */

/*3c*/
proc freq data=Color order=data;
   tables Hair / nocum chisq 
                 plots(only)=deviationplot;
   weight Count;
   by Region;
   title 'Hair Color of European Children';
run;
/*3b has something called a Test percentage, it has the testp=(30 12 30 25 3), those are test percentage,
3c does not, that is gone*/


/*Question 4*/
libname homework '/home/u63679711/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Assignments';
data work.sff;
	set homework.sff;
run;

proc contents data=work.sff;
run;

/*4b*/
proc freq data=work.sff;
   tables Continent;
run;

/*4c*/

proc freq data=work.sff;
    tables Continent;
    where Apr = .;  /* No cases reported in April */
run;


proc freq data=work.sff;
    tables Continent;
    where Apr >= 1;  /* No cases reported in April */
run;

proc freq data=work.sff;
    tables Continent;
    where Aug = .;  /* No cases reported in August (Continent) */
run;

proc freq data=work.sff;
    tables Continent;
    where Aug >=1;  /* At least one case in August */
run;

proc freq data=work.sff;
    tables Country;
    where Aug=.;  /* No case in August (Country) */
run;


/*4d*/
proc print data=work.sff;
    where FirstCase = . and FirstDeath ~= .;
    var Continent Country FirstCase Latest FirstDeath;
run;


/*4e*/

proc sort data=work.sff;
    by Continent;
run;
proc print data=work.sff;
    where FirstCase = . and FirstDeath ~= .;
    var Continent Country FirstCase Latest FirstDeath;
    format FirstCase FirstDeath date9.;  /* Display dates in readable format */
    by Continent;
run;
