
libname orion '/folders/myfolders';
/* Problem 1*/

* part a;

data fsp;
	set orion.orders_midyear;
	keep Customer_ID Months_Ordered Total_Order_Amount;
	array month{*} month:;
	i=dim(month);
	
	if dim(month)<3 then do;
		putlog 'input data set is invalid';
		stop;
	end;
	do i=1 to dim(month) while(n(of month{*})>=(dim(month)/2) and dim(month)>=3);
	/*if dim(month)>=3 then do;
		array mon{*} month:;	*/
		*non_m=n(of mon{*});
		*if n(of mon{*})>=(dim(month)/2) then do;
			Months_Ordered=n(of month{*});*n(of mon{*});
			Total_Order_Amount=sum(of month{*});*sum(of mon{*});
		*end;
  		*if Months_Ordered NE . and Total_Order_Amount>=1000 then output; 
	end;
	if Months_Ordered NE . and Total_Order_Amount>=1000 then output; 
	/*else do;
		putlog 'input data set is invalid';
		stop;
	end;*/
run;

proc print data=fsp noobs;
	title 'Qualified Customers for the Frequent Shopper Program';
	format Total_Order_Amount dollar14.2;
run;



* part b;

data passed failed;
	set orion.test_answers;
	drop i;
	score=0;
	array Q{*} Q1-Q10;
	array ans{10} $ _temporary_ ('A','C','C','B','E','E','D','B','B','A');
	do i=1 to 10;
		if ans{i} EQ Q{i} then do;
			score+1;
		end;
	end;
	if score >=7 then output passed ;
	else output failed;
run;

proc print data=passed;
	title'List of passed employees';
run;





