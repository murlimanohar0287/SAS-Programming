/***************************************************   Lecture 4  */

libname mylib '/folders/myfolders';

data work.fast work.slow work.veryslow;
	set mylib.allorders;
	where Order_Type in (2,3);
	ShipDays=delivery_date-order_date;
	if  ShipDays<3 then output work.fast;
	else if 5<=ShipDays<=7 then output work.slow;
	else if 7<ShipDays then output work.veryslow;
	drop Employee_ID;
run;


data work.fast1 work.slow1 work.veryslow1 other1;
	set mylib.allorders;
	where Order_Type in (2,3);
	ShipDays=delivery_date-order_date;
	select(ShipDays);
		when (ShipDays<3) do;
			output work.fast1;
		end;
		when (5<=ShipDays<=7) do;
			output work.slow1;
		end;
		when (7<ShipDays) do;
			output work.veryslow1;
		end;
		otherwise do;
			output other1;
		end;
	end;
	drop Employee_ID;
run;

data work.fast1 work.slow1 work.veryslow1 other1;
	set mylib.allorders;
	where Order_Type in (2,3);
	ShipDays=delivery_date-order_date;
	select;
		when (ShipDays<3) output work.fast1;
		when (5<=ShipDays<=7) output work.slow1;
		when (7<ShipDays) output work.veryslow1;
		otherwise output other1;
	end;
	drop Employee_ID;
run;


/******problem 2*******/

/* a */
data work.instore(keep=Order_ID Customer_ID Order_Date) 
	 work.delivery(keep=Order_ID Customer_ID Order_Date ShipDays);
	set mylib.allorders (obs=30);
	where Order_Type=1;
	ShipDays=delivery_date-order_date;
	if ShipDays=0 then output work.instore;
	else if ShipDays>0 then output work.delivery;
run;

/* b */



/*********************************************************************   Lecture 5  ***********/
libname mlib '/folders/myfolders';

/***************************************************************** Part 1 ***********/
/* a */
data employee_payroll;
	set mlib.employee_payroll; 
	format Salary  dollar8. Birth_Date mmddyy10. Employee_Hire_Date date9.;
run;


/* b */
data Q1Birthdays;
   set mlib.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;


proc format ;
	value $GENDER 'F'='Female'
                   'M'='Male';

	value mname 1='January'
                2='February'
				3='March';
run;


proc print data=Q1Birthdays;
	var Employee_Gender BirthMonth;
	format Employee_Gender $GENDER. BirthMonth mname.;
	title 'Employees with Birthdays in Q1';
run;

title;

/***************************************************************** Part 2 ***********/

/* Part 1 */
	/* a */
	proc print data=mlib.customer_dim;
		
	run;

	
/* Part 2 */
	/* a */

	proc sort data=mlib.employee_payroll out=sort_salary2;
		by Employee_Gender descending Salary; 	
	run;
	
	/* b */
	proc print data=sort_salary2;
		 by Employee_Gender;
	run;

	/* c */
	proc print data=sort_salary2 noobs;
		 sum salary;
		 where Employee_Term_Date=. and salary>65000;		 
		 by Employee_Gender;
		 var Employee_ID Salary Marital_Status Employee_Term_Date;
	run;



	/*********************************************************************   Lecture 6  ***********/
	/*********** part 1 *********************/
libname mlib6 '/folders/myfolders';

data work.mid_q4_1;
  		set mlib6.order_fact;
  		where '01nov2008'd <= Order_Date <= '14dec2008'd;
		Sales2Dte+Total_Retail_Price;
		Num_Orders+Quantity;
run;


proc print data=mid_q4_1;
	format Sales2Dte DOLLAR10.2 ;
	var Order_ID Order_Date Total_Retail_Price Sales2Dte Num_Orders;
run;


/*********** part 2 *********************/

proc sort data=mlib6.order_qtrsum out=order_qtrsum;
	by customer_id Order_Qtr; 
run; 

data work.qtrcustomers ;
	set order_qtrsum;
	by customer_id Order_Qtr;
	if FIRST.order_qtr then Total_Sales=0;
	Total_Sales+sale_amt;
	if last.order_qtr;
run;


