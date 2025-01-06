data empscn;
	input First $ Gender $ Country $;
	datalines;
Chang   M   China
Li      M   China
Ming    F   China
;
run;

data empsjp;
	input First $ Gender $ Region $;
	datalines;
Cho     F   Japan
Tomi    M   Japan
;
run;

/*Like-Structured Data Sets*/
data empsall;
	set empsfr empscn empsdk;

proc print;
run;

/**Unlike-Structured Data sets**/
data empsall2;
	set empsall empsjp;

proc print;
run;

/*rename region variable*/
data empsall2;
	set empsall empsjp (rename=(region=country));

	/*rename region as country*/
proc print;
run;

data empsall;
	set empsfr (rename=(country=region)) empscn (rename=(country=region)) empsdk 
(rename=(country=region)) empsjp;

proc print;
run;





FILENAME REFILE '/home/ulrike1/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Data Sets/sales.csv';

PROC IMPORT DATAFILE=REFILE DBMS=CSV REPLACE OUT=WORK.Sales;
	GETNAMES=NO;
RUN;

PROC CONTENTS DATA=WORK.Sales;
RUN;

proc datasets library=work nodetails nolist;
	modify Sales;
	rename Var1=Employee_ID Var2=First Var3=Last Var4=gender Var5=Salary 
		Var6=Job_Title Var7=country Var8=DOB Var9=hiring_date;
quit;

/*tells SAS we are done modifying the data set; */


/*Independently of any datasets in your SAS library we can define customized formats for character and numerical
variables that we can use ACCROSS multiple*/

proc format;
value $ctryfmt 'AU' = 'Australia'
               'US' = 'United States'
               other = 'Misspelled';
run;

proc means data=sales n nmiss min max median;
class country;
var salary;
format salary dollar12. country $ctryfmt.;
run;


/*Formats for numerical variables*/
proc format;
value Tiers low - < 50000 = 'Tier 1'
            5000 - 100000 = 'Tier 2'
            100000 - high = 'Tier 3'
            ;
run;

proc freq data=sales;
table salary;
format salary Tiers.; /*Put variable name first followed by the name of the format*/
run;




proc contents data=sashelp.heart;
run;

proc format;
   value $death1 'Unknown' = ''