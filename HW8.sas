data birth_data;
    infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/birthweight_reduced.csv' dsd firstobs=2;
    input id headcircumference length birthweight gestation 
          smoker : $1. motherage mnocig mheight mppwt 
          fage fedyrs fnocig fheight lowbwt : $1. 
          mage35 : $1. LowBirthWeight : $8.;
run;

PROC CONTENTS DATA=WORK.birth_data; RUN;


PROC SGSCATTER DATA=work.birth_data;
    PLOT birthweight * (length mnocig fnocig headcircumference gestation mheight) / JITTER;
RUN;


PROC CORR DATA=work.birth_data;
    VAR birthweight length mnocig fnocig headcircumference gestation mheight;
RUN;

proc corr data=birthweight;  /*We can do it this way to*/
var length headcircumference gestation mheight;
with birthweight;


PROC CORR DATA=work.birth_data;
    VAR birthweight length;
    PARTIAL headcircumference gestation;
RUN;

proc reg data=work.birth_data;
    model birthweight = length mnocig fnocig headcircumference gestation mheight;
run;


proc reg data=work.birth_data;
    model birthweight = length headcircumference gestation mheight;
run;



data smallsim;
	array x{5} x1-x5;

	do n=1 to 20;

		do i=1 to 5;
			x(i)=normal(-1);
		end;
		y=normal(-1);
		output;
	end;
run;

proc print data=smallsim;
run;

/*part a)*/
data sim;
	array x{75} x1-x75;

	do n=1 to 100;

		do i=1 to 75;
			x(i)=normal(-1);
		end;
		y=normal(-1);
		output;
	end;
run;

/*part b)*/
ods trace on;

proc reg data=sim;
	model y=x1-x75 / selection=backward;
	run;
	ods trace off;

	/*
	Use this code to generate only the relevant output to upload
	in CANVAS.
	You will have to check if Step 60 is indeed the last step
	for your data and update if necessary*/
	ods pdf file='/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/Assignment8_Backward.pdf' 
		style=HTMLBlue startpage=no;

proc reg data=sim;
	model y=x1-x75 / selection=backward;
	ods select Reg.MODEL1.SelectionMethod.y.Step60.ANOVA 
		Reg.MODEL1.SelectionMethod.y.Step60.SelParmEst SelectionSummary 
		DiagnosticsPanel;
	run;
	ods pdf close;

	/*part c)*/
	ods trace on;

proc reg data=work.sim;
	model y=x1-x75 / selection=forward;
	run;
	ods trace off;

	/*
	Use this code to generate only the relevant output to upload
	in CANVAS.
	You will have to check if Step 44 is indeed the last step
	for your data and update if necessary*/
	ods pdf file='/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/Assignment8_Forward.pdf' 
		style=HTMLBlue startpage=no;

proc reg data=work.sim;
	model y=x1-x75 / selection=forward;
	ods select Reg.MODEL1.SelectionMethod.y.Step44.ANOVA 
		Reg.MODEL1.SelectionMethod.y.Step44.SelParmEst SelectionSummary 
		DiagnosticsPanel;
	run;
	ods pdf close;

	/*part d)*/
	ods trace on;

proc reg data=sim;
	model y=x1-x75 / selection=stepwise;
	run;
	ods trace off;

	/*
	Use this code to generate only the relevant output to upload
	in CANVAS.
	You will have to check if Step 11 is indeed the last step
	for your data and update if necessary*/
	ods pdf file='/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/Assignment8_Stepwise.pdf' 
		style=HTMLBlue startpage=no;

proc reg data=sim;
	model y=x1-x75 / selection=stepwise;
	ods select Reg.MODEL1.SelectionMethod.y.Step11.ANOVA 
		Reg.MODEL1.SelectionMethod.y.Step11.SelParmEst SelectionSummary 
		DiagnosticsPanel;
	run;
	ods pdf close;
	