/* Group Members:*/

/* Sandeep Singh - ssingh74 */
/* Mudit Gupta   - mgupta23 */
/* Akshat Sangal - asanga3  */
/* Murli Singh   - msingh40 */


libname mylib '/folders/myfolders';

/********** Problem 1 *************/
	/* (a) */
	data allemployees (keep=Employee_ID First_Name Last_Name Job_Title Salary);
	
		set mylib.sales mylib.nonsales (rename=(first=first_name last=last_name));
	run;

	/* (b) */
	proc print data=allemployees(obs=10);
	run;
	
	
/********** Problem 2 *************/
	/* (a) */
	data contacts;
		set mylib.charities mylib.us_suppliers;
	run;
	
	/* (b) */
	/*Explanation:
		The variables attributes assigned as per first input dataset i.e. charities.
		Even the size of the attributes assigned according to the first data set.
		For example, length of the contacttype is 7 as per first data set i.e. charities.
	*/
	proc contents data=contacts;
	run;
	
	/* (c) */
	data contacts2;
		set mylib.us_suppliers mylib.charities;
	run;
	/* (d) */
	/*Explanation:
		The variables attributes assigned as per first input dataset i.e. us_suppliers.
		Even the size of the attributes assigned according to the first data set.
		For example, length of the contacttype is 1 and company is 30 as per first data set i.e. us_suppliers.
	*/
	proc contents data=contacts2;
	run;

/********** Problem 3 *************/
	/* (a) */
	proc sort data=mylib.orders;
		by order_id;
	run;
	proc sort data=mylib.order_item;
		by order_id;
	run;
	
	data allorders;
		merge mylib.orders mylib.order_item;
		by order_id;
	run;
	
	/* (b) */
	/* 
	Explanations:
		We can clearly see that allorders contains 732 observations and 12 variables
	*/
	proc contents data=allorders;
	run;
	
	/* (c) */
	proc sort data=mylib.orders;
		by order_id;
	run;
	proc sort data=mylib.order_item;
		by order_id;
	run;
	data allorders;
		merge mylib.orders mylib.order_item;
		by order_id;
		keep Order_ID Order_Item_Num Order_Type Order_Date Quantity Total_Retail_Price;
	run;

/********** Problem 4 *************/
	/* (a) */
	proc sort data=mylib.product_list out=product_list;
		by product_level;
	run;
	/* (b) */
	data listlevel;
		merge mylib.product_level product_list;
		by product_level;
		keep Product_ID Product_Name Product_Level Product_Level_Name;
	run;
	
	/* (c) */
	TITLE "LIST OF PRODUCT WITH PRODUCT LEVEL 3";
	proc print data=listlevel;
		where product_level=3;
	run;
	
/********** Problem 5 *************/
	/* (a) */
	proc sort data=mylib.product_list out=product_list;
		by supplier_id;
	run;
	data prodsup;
		merge mylib.supplier product_list; 
		by supplier_id;
	run;
	
	/* (b) */
	/*
	Explanation:
		We can see by the below code that prodsup data set contains 556 observations with 10 variables
	*/
	proc contents data=prodsup;
	run;
	
	/* (c) */
	proc sort data=mylib.product_list;
		by supplier_id;
	run;
	data prodsup;
		merge mylib.supplier(in=supp)
			product_list(in=prod);
		by supplier_id;
		if prod and not supp;
	run;
	
	/* (d) */
	/*
	Explanation:
		We can see by the below code that prodsup data set contains 75 observations with 10 variables
	*/
	proc contents data=prodsup;
	run;
	
	/* (e) */
	proc print data=prodsup;
		title 'result of the merge between product_list and supplier having product_list but not supplier';
	run;




