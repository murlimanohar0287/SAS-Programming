/*Question 1*/
proc import 
	out=psales
	datafile="/folders/myfolders/HW1/Sales - All Categs_Pharm.csv" 
	dbms= csv replace;
	getnames=yes;
	datarow=2;
run;

/*Question2*/
data psales1;
	set work.psales;
	adjSales=round(1.25*sales + 10 * rand("UNIFORM"),.2);
	
run;  

/*Question 3*/
libname newSales '/folders/myfolders';

proc sort data=psales1 out=newSales.newSales; 
by category; 
run;

/*Question 4*/
proc means data=newSales.newSales NOPRINT  nway; 
	class category;
	var adjsales; 
	output out=aveSales mean=Meansale;
run;

proc print data=aveSales  ; 
	title "Means of aveSales"; 
run;

/*Question 5*/
proc freq data=newSales.newSales;
	tables category / out=countSal nocum nopercent;
run;

proc print data=countSal; 
	title "Counts by category"; 
run;

/*Question 6*/
data acid_Set;
	set newsales.newsales; 
	**adjsales=round(adjsales,.1);
	if category="Acidity" then output; 
	/*selected "acidity category and will display its records" */
run;

/*Question 7*/
proc print data=acid_set(obs=5);
	title "Acidity";
run;

