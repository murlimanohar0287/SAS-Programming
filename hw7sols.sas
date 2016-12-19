
/* Problem 10.2 */

DATA PRINCIPAL;
   DO SUBJ = 1 TO 200;
      X1 = ROUND(RANNOR(123)*50 + 500);
      X2 = ROUND(RANNOR(123)*50 + 100 + .8*X1);
      X3 = ROUND(RANNOR(123)*50 + 100 + X1 - .5*X2);
      X4 = ROUND(RANNOR(123)*50 + .3*X1 + .3*X2 + .3*X3);
      OUTPUT;
   END;
RUN;
 
 
ODS TRACE ON/LISTING; /* ON THE TRACE TO SEE THE GRAPH AND STATISTICS*/


PROC FACTOR DATA=principal scree; /*ASSUMES NO CORRELATION BETWENN FACTOER*/
	ODS OUTPUT temporary;
RUN;

/* I would like to add threee factors those have higher Eigenvalue */

PROC FACTOR DATA=principal nfactors=3 ROTATE=VARIMAX SCREE;
	ODS OUTPUT;* ORTHOTFACTPAT=ROTATED;
	/*PRIORS SMC; */
RUN;



/* Problem 10.4 */

PROC FACTOR DATA=principal nfactors=3 ROTATE=promax outstat=factout score;
	ODS OUTPUT ORTHOTFACTPAT=ROTATED;
RUN;


proc score data=principal score=factout out=scoring_data_set_name;
	 
run; 


PROC PRINT DATA=scoring_data_set_name;*(obs=10);
	title 'Data Set from PROC SCORE oblique rotation';
run;


/*Simple method of taking the mean*/

PROC FACTOR DATA=principal; 
	ODS OUTPUT temporary;
RUN;









