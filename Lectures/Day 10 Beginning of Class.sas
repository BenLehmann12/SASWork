data empsdk;
	input First $ Gender $ Country $;
	datalines;
Lars    M   Denmark
Kari    F   Denmark
Jonas   M   Denmark
;
run;

data empsfr;
	input First $ Gender $ Country $;
	datalines;
Pierre  M   France
Sophie  F   France
;
run;

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
set empsdk empsfr empscn;
proc print;
run;


/*Unlike-Structured Data Sets*/
data empsall2;
set empsall emspjp;
proc print;
run;

/*rename region variable*/
data empsall2;
set empsall emspjp (rename=(region=country));
proc print;
run;


data empsall;
set empsdk (rename=(country=region)) empsfr (rename=(country=region)) empscn (rename=(country=region))
empsjp (rename=(country=region));
proc print;
run;




%let path=/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets ;

data work.nonsales2;
	infile "&path/nonsales.csv" dlm=',';
	input Employee_ID First $ Last $;
run;

proc print data=work.nonsales2;
run;
