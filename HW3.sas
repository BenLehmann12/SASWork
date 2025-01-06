data medical;
    infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/medical.txt' dlm=' ' missover;
    input Date :mmddyy10. FirstName $ Cholesterol $ SystolicBP $ DiastolicBP;
    format Date:mmddyy10.;
run;

proc print data=work.medical(firstobs=5 obs=10);
run;


data Newmedical;
    infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/medical.txt' dlm=' ' missover;
    input Date :mmddyy10. FirstName $ Cholesterol SystolicBP DiastolicBP;
    format Date mmddyy10.;
    if Cholesterol = 999 then Cholesterol = .;
    if SystolicBP = 999 then SystolicBP = .;
    if DiastolicBP = 999 then DiastolicBP = .;
run;

proc print data=work.Newmedical(firstobs=5 obs=10);
run;


proc means data=work.newmedical nmiss;
    var Cholesterol SystolicBP DiastolicBP;
run;




/*Question 4*/


DATA kids6;
    INFILE '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/kids6.dat' missover;
    INPUT Name $ Siblings BirthDate :MMDDYY10. Allowance :DOLLAR5. Hobby1 $ Hobby2 $ Hobby3 $;
    FORMAT BirthDate MMDDYY10. Allowance DOLLAR5.;
RUN;

PROC PRINT DATA=work.kids6; 




DATA dogs;
    INFILE '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/AKCbreeds.dat' DSD TRUNCOVER missover;
    INPUT Breed $ 1-35 Value1 $39-42 Value2 $45-48 Value3 $50-52 Value4 $54-57;
RUN;

PROC PRINT DATA=work.dogs;
RUN;


data days;
AgeInDays="01jan1960"d-"08aug2024"d;
put AgeInDays comma10.;
format AgeInDays comma10.;
proc print;
run;


data example;
  date = '24AUG2024'd;
  internal_value = date;
  format date date9.;
  put internal_value;
run;

