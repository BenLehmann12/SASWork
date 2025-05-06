/*Go back to the Ames housing dataset*/
/*response: Sale price*/
/*Build a multiple linear regression model
- predicting SalePrice
- Focusing on the associations/relationships the predictor variables have on SalrPrice
- propose your "BEST" model that you can come up with*/
libname data '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';

data ames;
	set data.ameshousing3;
run;

proc contents data=work.ames noprint out=data_info(keep=name varnum);
run;

proc sort data=data_info;
	by varnum;
run;

proc print data=data_info noobs;
	var name;
run;

proc corr data=work.ames pearson;
	var _Numeric_;
run;


proc glmselect data=work.ames plots=all;
	class House_Style Heating_QC Central_Air;
	model SalePrice=Lot_Area House_Style Overall_Qual Overall_Cond Year_Built 
		Heating_QC Central_Air Gr_Liv_Area Bedroom_AbvGr Fireplaces Garage_Area 
		Mo_Sold Yr_Sold / selection=stepwise(select=AIC choose=validate) stats=all;
run;

proc glmselect data=work.ames;
	class House_Style Heating_QC Central_Air Garage_Type_2 Foundation_2 
		House_Style2 Lot_Shape_2 Masonry_Veneer;
	model SalePrice=Lot_Area Gr_Liv_Area / selection=stepwise;
run;


/*Scatterplot Matrix:
-SalePrice
-Overall_Qual
-Overall_Cond
-Overall_Qual2
-Overall_Cond2
Check R^2 Adjusted R^2
*/

/*Explore the Correlation*/
proc sgscatter data=work.ames;
matrix SalePrice Overall_Qual Overall_Cond Overall_Qual2 Overall_Cond2;
run;

proc reg data=work.ames;
model SalePrice = Overall_Qual Overall_Cond Overall_Qual2 Overall_Cond2 / partial vif;
run;

proc reg data=work.ames;
model SalePrice = Overall_Qual Overall_Cond / partial vif;  /*R^2 decreases but not by too much*/
run;


/*Compare the Regression Models, VIF and R^2 betweent the 2 models,
The VIF decreases when we remove the Overall_Qual2 and Overall_Cond2, but the R^2 doesn't change that much
*/
proc reg data=work.ames;
	model SalePrice=Overall_Qual Basement_Area Year_Built Gr_Liv_Area Overall_Cond 
	Garage_Area Fireplaces Lot_Area Full_Bathroom Deck_Porch_Area Overall_Qual2 Overall_Cond2 / partial vif;
run;

proc reg data=work.ames;
	model SalePrice=Overall_Qual Basement_Area Year_Built Gr_Liv_Area Overall_Cond 
	Garage_Area Fireplaces Lot_Area Full_Bathroom Deck_Porch_Area / partial vif;
run;


proc glmselect data=work.ames plots=(coefficientpanel criterionpanel);
	class House_Style Heating_QC Central_Air Garage_Type_2 Foundation_2 
		House_Style2 Lot_Shape_2 Masonry_Veneer;
	model SalePrice=Overall_Qual2 Overall_Cond2 Lot_Area Overall_Qual Overall_Cond Year_Built Gr_Liv_Area 
		Fireplaces Garage_Area Mo_Sold Yr_Sold Basement_Area Full_Bathroom 
		Half_Bathroom Total_Bathroom Deck_Porch_Area Age_Sold Season_Sold / 
		selection=stepwise(select=AIC) stats=all details=summary;
run;

proc glmselect data=work.ames plots=(coefficientpanel criterionpanel);
	class House_Style Heating_QC Central_Air Garage_Type_2 Foundation_2 
		House_Style2 Lot_Shape_2 Masonry_Veneer;
	model SalePrice=Overall_Qual Basement_Area Year_Built Gr_Liv_Area Overall_Cond 
		Garage_Area Fireplaces Lot_Area Full_Bathroom 
		Deck_Porch_Area/selection=stepwise(select=AIC) stats=all details=summary;
run;
/*Higher the F-val, the better the model*/
/*High R^2 the better*/

/*I would say it doesn't really matter since both R^2 in the Model are really high*/
proc reg data=work.ames;
	model SalePrice=Overall_Qual Basement_Area Year_Built Gr_Liv_Area Overall_Cond 
		Garage_Area Fireplaces Lot_Area Full_Bathroom Deck_Porch_Area / vif;
run;

proc reg data=work.ames;
	model SalePrice=Overall_Qual Basement_Area Year_Built Gr_Liv_Area Overall_Cond 
	Garage_Area Fireplaces Lot_Area Full_Bathroom Deck_Porch_Area Overall_Qual2 Overall_Cond2 / partial vif;
run;
