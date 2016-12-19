/* Group Members:*/

/* Sandeep Singh - ssingh74 */
/* Mudit Gupta   - mgupta23 */
/* Akshat Sangal - asanga3  */
/* Murli Singh   - msingh40 */

/* Problem 1*/ 
libname orion '/folders/myfolders';

* Part 1; 
data work.admin work.stock work.purchasing;
	set orion.employee_organization;
	select;
		when (Department='Administration') output work.admin;
		when (Department='Stock & Shipping') output work.stock;
		when (Department='Purchasing') output work.purchasing;
		otherwise;
	end;	
run;

* Part 2; 
data work.sales(keep=Employee_ID Job_Title Manager_ID)
	 work.exec(keep=Employee_ID Job_Title);
	set orion.employee_organization;
	select;
		when (Department='Sales') output work.sales;
		when (Department='Executives') output work.exec;
		otherwise;
	end;	
run;

Proc print data=work.sales(obs=6);	
run;

Proc print data=work.exec (firstobs=2 obs=3);	
run;



/* Problem 2*/ 
title1 'Salary and Gender Values';
title2 'for Non-Sales Employees';
proc print data=orion.nonsales;
	var Employee_ID Job_Title Salary Gender;
run;

Proc format;
	value $GENDER 'F'   ='Female'
				  'M'   ='Male'
				  other ='Invalid code';
				  
	value SALRANGE 20000-<100000 ='Below $100,000'
				   100000-500000 ='$100,000 or more'
				   .='Missing salary'
				   other='Invalid salary';
run; 

proc print data=orion.nonsales;
	var Employee_ID Job_Title Salary Gender;
	format Salary salrange. Gender $gender.;
run;



/* Problem 3*/ 

* Part 1; 
* a) ;
proc sort data=orion.order_Fact out=orion.order_Fact1;
	by Order_Type;
run;

data work.typetotals;
	set orion.order_Fact1;* (obs=10);
	where year(Order_Date)=2009;
	by Order_Type;
	if Order_Type=1 then do;
		if first.order_type then do;
			TotalRetail=0;
			TotalCatalog=0;
			TotalInternet=0;
		end;
			TotalRetail+quantity;
		if last.order_type ;
	end; 
	else if Order_Type=2 then do;
		if first.order_type then do;
			TotalRetail=0;
			TotalCatalog=0;
			TotalInternet=0;
		end;
			TotalCatalog+quantity;
		if last.order_type ;
	end;
	else if Order_Type=3 then do;
		if first.order_type then do;
			TotalRetail=0;
			TotalCatalog=0;
			TotalInternet=0;
		end;
			TotalInternet+quantity;
		if last.order_type ;
	end; 
run; 

* b) ;
proc print data=work.typetotals;
	title 'Acumulating totals by order type';
run;


* Part 2;
 
data work.order_Fact_T;
	set orion.order_Fact;
	where year(Order_Date)=2011;
	month=month(Order_Date);
run;

data work.report;
	set order_Fact_T;
	by month;
	*extra=first.Order_Date;
	if first.month then 	MonthSales=0;	
		MonthSales+Total_retail_price;		
	if last.month;
run;

proc print data=work.report;
	title 'Accumulating Totals by Month in 2011';
run;


























