FILENAME REFFILE '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/housing-prices-ge19.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.prices;
	GETNAMES=YES;
RUN;



/*Get the Variable names*/
data housing;
set work.prices;
run;

proc contents data=work.housing noprint out=data_info(keep=name varnum);
run;

proc sort data=data_info;
	by varnum;
run;

proc print data=data_info noobs;
	var name;
run;


proc contents data=work.prices;
run;
/*
Price
Lot.Size
Waterfront
Age
Land.Value
New.Construct
Central.Air
Fuel.Type
Heat.Type
Sewer.Type
Living.Area
Pct.College
Bedrooms
Fireplaces
Bathrooms
Rooms
Test
*/

/********************************************************/
/***********************Question 1********(LEAVE IT)**************/
/********************************************************/

/********************************************************/
/***********************Question 2***********************/
/********************************************************/
proc sgscatter data=work.prices;
matrix _Numeric_;
run;
/********************************************************/
/***********************Question 3***********************/
/********************************************************/
proc corr data=work.prices pearson;
var _Numeric_;
with price;
run;

/********************************************************/
/***********************Question 4***********************/
/********************************************************/
proc glm data=work.prices plots=diagnostics;  /*Atempt 1 including the Class variables in the model*/
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n'Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms;
run;


proc glm data=work.prices plots=diagnostics;
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n; /*Attempt 2: I decided the remove the Class variables from the Model, see the difference*/
model Price = 'Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms;
run;

/********************************************************/
/***********************Question 5***********************/
/*
Test Statistic (F Value): 147.87
Degrees of Freedom (DF): 22 for the model and 1711 for the error
p-value: < 0.0001
Conclusion: Since the p-value is extremely small (< 0.0001), 
we reject the null hypothesis that all model coefficients are equal to zero. 
This means at least one of the predictors is significantly associated with the dependent variable (Price)
R^2: 0.655323
Adj R^2: 0.6509
Variables with p-values > 0.15: Pct.College, Fireplaces
Fuel.Type (p = 0.8668, second model)
Heat.Type (p = 0.6868, second model)
Sewer.Type (p = 0.9012, second model)

Choice, I look at the F-value and the p-value, they give me the idea of significance,
The higher the F-value the better the model
Lot.Size (F = 215.03, p < 0.0001)
Waterfront (F = 149.92, p < 0.0001)
*/

/********************************************************/
/***********************Question 6***********************/
/********************************************************/

proc glmselect data=work.prices plots=(coefficientpanel criterionpanel);
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n'Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 
'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms/selection=stepwise(select=SBC stop=SBC) details=summary stats=all;;
run;


proc glmselect data=work.prices plots=(coefficientpanel criterionpanel); /*Again, I tested with removing the Class variables from the model to see if there is a difference*/
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = Waterfront Age 'Land.Value'n 'New.Construct'n 
'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms/selection=stepwise(select=SBC stop=SBC) details=summary stats=all;;
run;

proc glmselect data=work.prices plots=(coefficientpanel criterionpanel);  /*It said SBC so in the first Model I included that in there with the select and stop*/
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n'Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 
'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms/selection=stepwise details=summary stats=all;
run;
/********************************************************/
/***********************Question 7***********************/
/*The Default is SBC*/


/********************************************************/
/***********************Question 8***********************/
/*
Living.Area, Land.Value, Bathrooms, Waterfront, New.Construct, Central.Air, Age,
Living.Area, Land.Value, Bathrooms, Waterfront, New.Construct, Central.Air, Age, Lot.Size (Default SBC) 
*/


/********************************************************/
/***********************Question 9***********************/
/*It is a representation of how the regression coefficients change as the model selection process progresses. 
It is useful for understanding the stability of the coefficients and identifying any potential multicollinearity issues
PLOTS=COEFFICIENTPANEL*/


/********************************************************/
/***********************Question 10***********************/
/********************************************************/

proc glmselect data=work.prices plots=(coefficientpanel criterionpanel);
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n'Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 
'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms/selection=stepwise(select=SL stop=SL) details=summary stats=all;;
run;

proc glmselect data=work.prices plots=(coefficientpanel criterionpanel);
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price ='Lot.Size'n Waterfront Age 'Land.Value'n 'New.Construct'n 
'Central.Air'n 'Living.Area'n 'Pct.College'n Bedrooms Fireplaces Bathrooms Rooms/selection=stepwise(select=SL stop=SL) details=summary stats=all;;
run;

/********************************************************/
/***********************Question 11***********************/
/********************************************************/

/*One of the models from Question 10 gave an extra variable, so I decided to create 2 models to fit, one without the extra and one with*/
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age 'Lot.Size'n / vif scorr2 partial vif;
run;


proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age / vif scorr2 partial vif;
run;



/********************************************************/
/***********************Question 12***********************/
/*
Based on the VIF for each variable, I don't have much concern for Multicollinearity, now if the VIF were much
higher (say VIF > 10 or even 6), I would have some concerns

After tesing my Regression Models, I would say if we remove Living.Area or Land.Value, it reduces our R^2,
we can also look at the p-value as well for significance

In terms of new construction, I would say it would be much for a predicted price than the predicted price of old construction,
I like to take in the factors and I think in real-world terms newer constructed homes tend to have higher prices
The price difference does make sence because usually older homes or construction have lower predicted prices because older homes
have older factors in terms of living area and age makes a big difference as well.
*/

proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n Age 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'Central.Air'n Age 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms 'New.Construct'n 'Central.Air'n Age 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n 'Land.Value'n Waterfront 'New.Construct'n 'Central.Air'n Age 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Living.Area'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age 'Lot.Size'n / vif scorr2;
proc reg data=work.prices;
model Price = 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age 'Lot.Size'n / vif scorr2;
run;


/********************************************************/
/***********************Question 13***********************/
/*I would say that I am concerned for the Outlier and Leverage plots,The RStudent vs Leverage plot shows a few observations with high leverage values,
There is one particularly extreme observation in the far right of the leverage axis, In the observation plot, I do have concern about one of the datpoints that is very high
In terms of homegeneity, I have a concern about the right tail of the dataset, It shows me there is a skewness to the data
so I would say I am concerned */


/********************************************************/
/***********************Question 14***********************/
/*I would say that I am pretty comfortable with my model because I got it to the highest R^2 and F stat,
all my variables have significance, the VIF score is pretty low for each variable, all the p-values of our variables show that
they are significant.*/


/********************************************************/
/***********************Question 15***********************/
/*I feel comfortable predicting the price with GLM and looking at the residual plots, it can give me an idea on 
the range of the predicted prices for homes
I also feel comfortable explaining the relationship betweent the price of proprty, I always start with Correlation matrix,
this gives me an idea on how price is impacted by different variables*/


proc glm data=work.prices plots=diagnostics;  /*Atempt 1 including the Class variables in the model*/
class 'Fuel.Type'n 'Heat.Type'n 'Sewer.Type'n;
model Price = 'Living.Area'n 'Land.Value'n Bathrooms Waterfront 'New.Construct'n 'Central.Air'n Age;
run;
/********************************************************/
/***********************Question 16***********************/
/*I think in terms of continuing my analysis, I would still focus on the VIF, the RMSE, the R^2 and the adjusted R^2
these results are impacted by the addition and removal of variables. Instead of GLMSelect, I would do a combination of variables to 
keep and ones to remove, play around with the data, maybe I should convert the the char data to numerical, maybe that would have an
impact. Our models depend on the F-value, the R^2, the adjusted R^2.

When I mean combinations of data variable
(X1,X2,X3,X4,Xn)
(X2,X3,X4,...,Xn-1)
(X3,X4,X5,...,Xn-2)
(X4,X5,X6,...,Xn-3)
.....

*/


/********************************************************/
/***********************Question 17***********************/
/*The first thing I learned is really focus on the residual plots, I always seem to go for the numerical analysis instead of the
visual analysis, but looking at graphs from GLM and reg can also give me a good idea on models as well.
The second thing I learned that just because one model is good doesn't mean that there is a model that can't be better, it just takes
time and effort to find that better model.*/
