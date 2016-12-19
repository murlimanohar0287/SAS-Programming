
/* Question 1.4 */

/* 1.4.a */
Data iq_and_test_Scores;
	input id 	  1-3
		  iq	  4-6
		  math	  7-9
		  science 10-12;
	overall=sum(iq,math,science)/500;
	if iq<=100 then 
		group=1;
	else if 100<iq<=140 then
		group=2;
	else
		group=3;
datalines;
001128550590
002102490501
003140670690
004115510510
;

/* 1.4.b */
proc sort data=iq_and_test_scores;
	by iq;
run;


/* 1.4.c */

proc freq data=iq_and_test_scores;
	tables group/ out=group_freq;
run;


/* Question 1.8 */
data employeeD;
	infile datalines dlm=' ';
	input empid salary jclass;
	**length new_Salary 10;
	if jclass=1 then do;
		bonus=salary*0.10;
		new_Salary=sum(bonus,salary);
	end;
	else if jclass=2 then do;
		bonus=salary*0.15;
		new_Salary=sum(bonus,salary);
	end;
	else do;
		bonus=salary*0.20;
		new_Salary=sum(bonus,salary);
	end;
datalines;
137  28000  1 
214  98000    3
199 150000 3
355   57000    2
;

proc contents data=employeed;
run;


/* Question 12.8 */

data prob12_8;
	infile datalines firstobs=2 missover;	
	input ID $ GENDER $ DOB mmddyy10. SCORE1 SCORE2;
	format dob date9.;
datalines;
***Header line: ID GENDER DOB SCORE1 SCORE2
001 M 10/10/1976 100 99
002 F 01/01/1960 89
003 M 05/07/2001 90 98
;


/* Question 12.16 */

data prob12_16;
	infile datalines dlm=',';	
	input ID $ GENDER $ DOB mmddyy10.;
	input HEIGHT WEIGHT;
	format dob date9.;
datalines;
001,M,06/14/1944
68,155
002,F,12/25/1967
52,99
003,M,07/04/1983s
72,128
;

/* Question 12.16 Another way*/
data prob12_16_2;
	infile datalines dlm=',';	
	input ID $ GENDER $ DOB mmddyy10. / HEIGHT WEIGHT;
	format dob date9.;
datalines;
001,M,06/14/1944
68,155
002,F,12/25/1967
52,99
003,M,07/04/1983s
72,128
;




