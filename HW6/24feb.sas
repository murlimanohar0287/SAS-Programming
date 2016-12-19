libname orion 'C:\Users\msingh40\Desktop\lect7';


/* problem 1 */
data future_expenses;
   drop start stop; 
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   start=year(today())+1;
   stop=start+10;
  /* insert a DO loop here */
   do year=start to stop;   		
	   	wages = wages * 1.06;
		retire=retire*1.014;
		medical=medical*1.095;		
   		Total_Cost=sum(wages,retire,medical);
   		output;
   end;
run;

proc print data=future_expenses;
   format wages retire medical total_cost comma14.2;
   var year wages retire medical total_cost;
run;


/* prob 2 */
data future_expenses_1;
   drop start stop; 
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   income=50000000;
   start=year(today())+1;
   stop=start+100;
  /* insert a DO loop here */
   do year=start to stop until (Total_Cost>income);   		
	   	wages = wages * 1.06;
		retire=retire*1.014;
		medical=medical*1.095;		
   		Total_Cost=sum(wages,retire,medical);
		income=income*1.01;
   		output;
   end;
run;


/* prob 3 */

data work.expenses;
   drop start stop; 
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   income=50000000;
   expense=38750000;
   start=year(today())+1;
   stop=start+100;
  /* insert a DO loop here */
   do year=start to stop while (expense<income);   		
	   	wages = wages * 1.06;
		retire=retire*1.014;
		medical=medical*1.095;		
   		Total_Cost=sum(wages,retire,medical);
		income=income*1.01;
		expense=expense*1.02;
		if (expense<income) then output;
   end;
run;

proc print data=expenses;
   format Income Expense dollar14.2;
   var Income Expense ;
run;


/* prob 4 */
data discount_sales;
	set orion.orders_midyear;
	array mon{*} month1-month6;
	drop i;
	do i=1 to dim(mon);
		mon{i}=mon{i}*0.95;
	end;
run;


data special_offer;
	set orion.orders_midyear;
	array mon{*} month1-month6;
	*array mon1{*} month1-month6;              
	drop i;
	do i=1 to dim(mon);
		if(i<=3) then Projected_Sales+mon{i}*0.90;
		else Projected_Sales+mon{i};

		Total_Sales+mon{i};
	end;
	Difference=Total_Sales-Projected_Sales ;
run;


/* prob 5 */
data preferred_cust;
   set orion.orders_midyear;
   array Mon{6} Month1-Month6;
   keep Customer_ID Over1-Over6 Total_Over;
   array Target{6} _temporary_ (200, 400, 300, 100, 100, 200);
   array Over{6}               ;
	do i=1 TO 6;
	if mon{i}> target{i} then over{i}=mon{i}-target{i};
	end;
	total_over=sum(of over{*});
	if total_over >500 ; 

run;
proc print data=preferred_cust noobs;
run;
