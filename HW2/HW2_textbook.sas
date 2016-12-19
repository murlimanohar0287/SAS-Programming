
/*Problem 1.2*/
data subhgt;
   input @1  Subj         	$3.
         @4  height    		2.
         @6  wt_init       	3. 
         @9  wt_final       3.;
         
         BMI_INT= wt_init/(height*2.2*0.0254);
         BMI_FINAL=wt_final/(height*2.2*0.0254);
         BMI_DIFF=BMI_FINAL-BMI_INT;
   datalines;
00768155150
00272250240
00563240200
00170345298
;

/*Problem 1.10*/
data rain;
   input city:$8. rain_june:2. rain_july:2. rain_august:2.;
   average=round((rain_june +rain_july +rain_august )/3,.01);
   percent_june=round((rain_june*100)/average,.01);
   percent_july=round((rain_july*100)/average,.01);
   percent_august=round((rain_august*100)/average,.01);
   **sort by city ;
datalines;
Trenton  23 25 30
Newark   18 27 22
Albany   22 21 27
;

Proc sort data=rain out=rain; 
by city;
run;

proc means data=rain mean stddev clm; **alpha=0.05;
variables rain_june rain_july rain_august;
run;
  
  
/*Problem 2.2*/  
data clinic;
   input @1  ID     $3.
         @4  Gender $1.
         @5  race   $1. 
         @6  hr     3.
         @9  sbp    3.
         @12 dbp    3.
         @15 n_proc 2.;
         
         AVE_BP=dbp+(1/3)*(sbp-dbp);
   datalines;
001MW08013008010
002FW08811007205
003MB05018810002
004FB   10806801
005MW06812208204
006FB101   07404
007FW07810406603
008MW04811207006
009FB07719011009
010FB06616410610
;

proc means data=clinic n mean stddev clm median; **mean stddev clm; **alpha=0.05;
variables sbp dbp AVE_BP;
run;


/*Problem 12.2*/
Data Sample1;
   infile datalines delimiter=',';
   input dob:$10. visitdate: $9. gender: $1. lastname: $10.;
   format dob mmddyy10. visitdate date9.;
   datalines;
10/21/1950,03MAY2004,M,Schneider
11/12/1944,05DEC2004,F,Strawderman
01/01/1960,25APR2004,M,Smith
;

/*Problem 12.6*/

data Sample2;
   input @1  Name   $10.
         @12 Gender $1.
         @13 DOB    $10.;
   **format dob mmddyy10.;
   datalines;
Cody       M05/11/1981
McMaster   F11/11/1967
Bill Smith M12/25/1999
;






