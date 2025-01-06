data birthweight;
	infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/birthweight_reduced.csv' 
		dsd missover dlm="," firstobs=2;
	input id headcircumference length birthweight gestation smoker $ mage mnocig 
		mheight mppwt fage fedyrs fnocig fheight lowbwt $ mage35 $;
run;

/* Question 4b)*/
proc glmselect data=birthweight plots=(coefficientpanel criterionpanel);
	class mage35 smoker;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight mage35 smoker /selection=stepwise details=summary 
		stats=(CP AIC BIC);
run;

proc glmselect data=birthweight plots=(coefficientpanel criterionpanel);
	class mage35 smoker;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight mage35 smoker /selection=forward details=summary 
		stats=(CP AIC BIC);
run;

proc glmselect data=birthweight plots=(coefficientpanel criterionpanel);
	class mage35 smoker;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight mage35 smoker /selection=backward details=summary 
		stats=(CP AIC BIC);
run;

/* variables selected: headcircumference gestation smoker */


/* Question 4c)*/
title 'Model Stepwise';

proc glm data=birthweight plots=diagnostics;   /*Reg with the Stepwise Variables Selected*/
	class smoker;
	model birthweight=headcircumference gestation smoker;
run;

/*When we remove smoker variable, we get the same values*/

	/* Question 4d)*/
data birthweight1;
	set birthweight;
	Nsmoker=input(smoker, 1.);
	Nmage35=input(mage35, 1.);
run;

/*Compare with Smoker and Without*/
proc reg data=birthweight1 plots=diagnostics outest=brthwghtout;
	model birthweight=headcircumference gestation nsmoker / vif scorr2 aic cp sbc;  
RUN;

proc reg data=birthweight1 plots=diagnostics outest=brthwghtout;
	model birthweight=headcircumference gestation / vif scorr2 aic cp sbc;  
RUN;

proc glm data=birthweight plots=diagnostics;
	class smoker;
	model birthweight=headcircumference gestation smoker;
run;

	/* print statistics like SCORR2, AIC, CP, and SBC */
proc print data=brthwghtout;
RUN;

/* Question 4f)*/
proc glmselect data=work.birthweight plots=all;
	class mage35 smoker;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight mage35 smoker /selection=lasso(choose=CP stop=none) 
		details=summary stats=(SBC AIC BIC);
run;/* headcircumference length gestation mppwt fheight mage35_0 smoker_0, the optimal stops at fheight*/


proc glmselect data=birthweight plots=all;
	class mage35 smoker;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight mage35 smoker /selection=lasso(choose=SBC 
		stop=none) details=summary stats=(SBC AIC BIC);
run;/* headcircumference length gestation smoker*/

proc glmselect data=work.birthweight1 plots=all;
	model birthweight=headcircumference length gestation mage mnocig mheight mppwt 
		fage fedyrs fnocig fheight Nmage35 Nsmoker /selection=lasso(choose=SBC stop=none) 
		details=summary stats=(SBC AIC BIC);
run;

/*LASSO with CP: headcircumference length, gestation, mppwt, fheight, mage35, smoker
  LASSO with SBC: headcircumference, length, gestation, smoker*/

/*part i) and j)*/
/*Note that you can fit multiple models in the same proc reg step*/

proc glm data=birthweight;
class mage35 smoker;
model birthweight = headcircumference length gestation smoker;
run;

proc glm data=birthweight;
class mage35 smoker;
model birthweight = headcircumference length gestation mppwt fheight;
run;

data birthweight2;
	set birthweight;
	lbirthweight=log(birthweight);
	Nsmoker=input(smoker, 1.);
	Nmage35=input(mage35, 1.);
run;

proc reg data=birthweight2 plots=diagnostics;
	model birthweight=headcircumference length gestation mppwt fheight nmage35 nsmoker / vif scorr2 cp aic sbc;
	model birthweight=headcircumference length gestation nsmoker / vif scorr2 cp 
		aic sbc;
	model birthweight=headcircumference gestation / vif scorr2 cp aic sbc;
	model birthweight=headcircumference gestation nsmoker / vif scorr2 cp aic sbc;
run;

proc print data=brthwghtout;
run;


proc reg data=birthweight2 plots=diagnostics outest=brthwghtout;
	model lbirthweight=headcircumference gestation nsmoker / vif scorr2 cp aic sbc;
	model birthweight=headcircumference gestation nsmoker / vif scorr2 cp aic sbc;
run;

proc print data=brthwghtout;
run;