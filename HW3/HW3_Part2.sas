
/* Reading raw data file rates */

filename rates '/folders/myfolders/rates.dat';

data air_rate1;
	infile rates;
	input origination $ destination $ range_of_flight $ cargo_rate passenger_fare Category_of_flight $;
	new_cargo_rates=cargo_rate+ 0.50;
	if range_of_flight='SHORT' then
		new_pass_fare=passenger_fare*1.08;
	else if range_of_flight='MEDIUM' then
		new_pass_fare=passenger_fare*1.10;
	else
		new_pass_fare=passenger_fare*1.12;
run;


/* Part 1 */
data air_part1;
	set air_rate1;
	drop new_pass_fare;
	title 'A listing of all the flights with the new cargo rate';
run;


/* Part 2 */
proc means data=air_rate1 mean noobs;
	class Category_of_flight; 
	variables new_pass_fare passenger_fare;
	title '	A comparison between the average current passenger fare and the average new passenger ';
run;

/* Part 3 */
proc freq data=air_rate1;
	tables Category_of_flight/ out= air_part3 nocum;
	title 'A breakdown of the frequency and percentage of domestic flights and international flights';
run;








