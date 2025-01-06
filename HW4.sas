filename Busdata ' /home/u63679711/my_shared_file_links/ulrike1/Stat 4840-
5840-F24/Assignments/Bus.dat';
data Bus;
infile Busdata;
input BusType $ OnTimeOrLate $ @@;
run;


/*Question 1*/

proc freq data=work.bus;
tables BusType OnTimeOrLate;
exact chisq;
run;

proc freq data=work.bus;
tables BusType*OnTimeOrLate / chisq expected;
run;

/*H0: Independent: Arrival Time does not depend of bus type*/
/*HA: Not Independent: Arrival Time depends on bus type
(Regular Busses are more delayed OR Express busses are more often delayed)  two-sided
P-value shoould be small*/


/*Chi-Square = 7.23, Prob=0.0071*/

/*Question 2*/
/*a*/
FILENAME REFFILE '/home/u63679711/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Assignments/Australian Tourism.jmp';
PROC IMPORT DATAFILE=REFFILE
	DBMS=JMP REPLACE
	OUT=WORK.IMPORT;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


/*2b*/

proc means data=work.import;
var _Numeric_;
run;

/*2c  proc means data=work.import;
var Guest arrivals ('000) Room occupancy rate (%);
run;*/



/*2e*/
FILENAME REFFILE '/home/u63679711/my_shared_file_links/ulrike1/Stat 4840-5840-F24/Assignments/Australian Tourism.jmp';
option validvarname=V7;
PROC IMPORT DATAFILE=REFFILE
	DBMS=JMP REPLACE
	OUT=WORK.IMPORT;
RUN;
PROC CONTENTS DATA=WORK.IMPORT; RUN;


/*2f*/
libname stat484 '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';
data stat484.newHotel ; 
    set work.import; 
run;
PROC CONTENTS DATA=stat484.newHotel; RUN;


/*2g*/
ods trace on;
proc contents data=stat484.newHotel;
ods select Variables;
run;
ods trace off;

ods select Variables;
proc contents data=stat484.newHotel;
run;

/*2i*/
data stat484.hotel;  
set stat484.newHotel;
rename VAR6=GuestArrivals VAR7=GuestNights VAR8=RoomNightsOccupied VAR9=Revenue VAR10=RoomOccupancyRate VAR11=BedOccupancyRate;
run;

proc means data=stat484.hotel;
run;

/*2j*/
data stat484.updateHotel; /*we could do stat484.updateHotel*/
   set stat484.hotel;
   if BedOccupancyRate > 41.0629630 then OccupancyStatus = 'Above Average';
   else OccupancyStatus = 'Below Average';
run;

/*2k*/
data stat484.hotelConvert;
   set stat484.updatehotel;
   QuarterChar = put(Quarter, 8.);
   /*drop Quarter*/
run;

proc print data=stat484.hotelconvert(obs=5);
var Quarter QuarterChar;
run;

/*2L*/
data stat484.filterData;
   set stat484.hotelconvert;
   if QuarterChar = 4 and Quarter = 4 then delete;
run;

proc freq data=stat484.filterData;
   tables Quarter QuarterChar;
run;

/*2M*/
data stat484.finalData;
   set stat484.filterdata;
   drop Date Year;
run;


/*Question 3*/
   

data weight_club;
	input IdNumber 1-4 Name $ 6-24 Team $ Endweight StartWeight;
	datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220   .
1095 Susan Stewart      blue   135 127
1157 Rosa Gomez         green  155 141
1331 Jason Schock       blue   187 172
1067 Kanoko Nagasaka    green  135 122
1251 Richard Rose       blue   181 166
1333 Li-Hwa Lee         green  141 129
1192 Charlene Armstrong yellow 152 139
1352 Bette Long         green  156 137
1262 Yao Chen           blue   196 180
1087 Kim Sikorski       red    148 135
1124 Adrienne Fink      green  156 142
1197 Lynne Overby       red    138 125
1133 John VanMeter      blue   180 167
1036 Becky Redding      green  135 123
1057 Margie Vanhoy      yellow 146 132
1328 Hisashi Ito        red    155 142
1243 Deanna Hicks       blue   134 122
1177 Holly Choate       red    141 130
1259 Raoul Sanchez      green  189 172
1017 Jennifer Brooks    blue   138 127
1099 Asha Garg          yellow 148 132
1329 Larry Goss         yellow 188 174
;
run;
   

/*3a*/

proc contents data=work.weight_club;
run;




/*3b*/
data weight_club;
	input IdNumber 1-4 Name $ 6-24 Team $ Endweight StartWeight;
	Gain = EndWeight-StartWeight;  
	datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220   .
1095 Susan Stewart      blue   135 127
1157 Rosa Gomez         green  155 141
1331 Jason Schock       blue   187 172
1067 Kanoko Nagasaka    green  135 122
1251 Richard Rose       blue   181 166
1333 Li-Hwa Lee         green  141 129
1192 Charlene Armstrong yellow 152 139
1352 Bette Long         green  156 137
1262 Yao Chen           blue   196 180
1087 Kim Sikorski       red    148 135
1124 Adrienne Fink      green  156 142
1197 Lynne Overby       red    138 125
1133 John VanMeter      blue   180 167
1036 Becky Redding      green  135 123
1057 Margie Vanhoy      yellow 146 132
1328 Hisashi Ito        red    155 142
1243 Deanna Hicks       blue   134 122
1177 Holly Choate       red    141 130
1259 Raoul Sanchez      green  189 172
1017 Jennifer Brooks    blue   138 127
1099 Asha Garg          yellow 148 132
1329 Larry Goss         yellow 188 174
;
run;


/*3d*/

data weight_club_new;
    set work.weight_club;
    if Team in ('yellow', 'red') then NewTeam = 'orange';
    else if Team in ('blue', 'green') then NewTeam = 'blue-green';
run;


/*3e*/

data weight_club_updated;
    set work.weight_club_new;
    drop Team;
run;



/*Question 4*/

libname stat4840 '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets';

data wine;
infile datalines dsd missover dlm=" ";
input company $1-12 type $13-22 score 23-24 note $26-34;
datalines;
Helmes      Pinot     56 fruity
Helmes      Riesling  38 fruity
Vacca       Merlot    91 chocolate
            Pinot     65 
Sterling    Prosecco  72 
;
run;



/*4c*/
data newWine;
infile datalines dsd missover dlm=" ";
input company $ type $ score note $9.;
datalines;
Helmes Pinot 56 fruity
Helmes Riesling 38 fruity
Vacca Merlot 91 chocolate
 Pinot 65  
Sterling Prosecco 72  
;
run;



/*Question 5*/

data hme;
    infile '/home/u63679711/SAS Programs/Stat 4840 Fall 2024/Data Sets/hmeqb.dat' dlm=',' dsd missover firstobs=2;
    input LOAN REASON $ ID BAD;
run;

proc freq data=work.hme nlevels;
    tables REASON;
run;
