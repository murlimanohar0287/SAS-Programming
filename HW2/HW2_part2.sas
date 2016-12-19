/*Reading from male.txt*/

filename maletxt '/folders/myfolders/customers_male.txt';

data male;
	infile maletxt dlm='09'x;
	**length cust_ID 6 county $2 Firstname $15 Lastname $20 birthdate $9 customer_type $40;
	input cust_ID:5. County :$2. FirstName :$15. LastName :$20. BirthDate :mmddyy10. Customer_Type :$40.;
	format birthdate mmddyy10.;
run;

proc print data=male noobs;
run;

proc means data=male sum missing;
class customer_type;
output out=male_S;
run;

proc freq data=male;
table  
run;

/*Reading from female.csv*/
filename fmaletxt '/folders/myfolders/customers_female.csv';

data female;
	infile fmaletxt dlm=',';
	**input cust_ID  county $  Firstname $ Lastname $  birthdate mmddyy10. customer_type $;
	input cust_ID:5. County :$2. FirstName :$15. LastName :$20. BirthDate :mmddyy10. Customer_Type :$40.;
	format birthdate mmddyy10.;
run;

proc means data=female sum missing;
class customer_type;
output out=female_S;
run;


