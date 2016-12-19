libname census '/folders/myfolders';

proc contents data=census.dmefzip;

run;

proc means data=census.dmefzip nmiss n maxdec=0;
	title 'Summary statistics without cleaning';
run;

/*drop variables not quantitative*/

data prefactor;
	set census.dmefzip (drop= adicode branchcd countycd countynm dmacode filetype msa multzip nielcode poffname rectype stateabr statecd zipcode);
run;

proc means data=prefactor n nmiss;
run; 

/*count no of var with missing values per record*/

data temp;
	set prefactor;
	nummiss=nmiss(of DMAWLTHR--POPULAT);
run;

/* DATA WITH NO MISSING VALUES*/
data temp;
	set temp;
	IF NUMMISS EQ 0;
	DROP NUMMISS;
RUN;


/*NORMAL DISTRIBUTION*/
PROC STANDARD DATA=temp REPLACE OUT=TEMP;
RUN;


PROC STANDARD DATA=TEMP OUT=census.STANDARD MEAN=0 STD=1;
	VAR _NUMERIC_; *ONLY THOSE WHO ARE NUMERIC(NO STANDARIZATION FOR BINARY OR FLAG);
RUN;


/*FACTOR ANALYSIS*/

PROC CORR DATA=census.STANDARD;
	TITLE'CORRELATION';
RUN;

ODS TRACE ON/LISTING; /* ON THE TRACE TO SEE THE GRAPH AND STATISTICS*/


PROC FACTOR DATA=census.STANDARD ROTATE=VARIMAX SCREE; /*ASSUMES NO CORRELATION BETWENN FACTOER*/
	ODS OUTPUT ORTHOTFACTPAT=ROTATED;
	/*PRIORS SMC; */
RUN;

/*AFTER PRIORS*/
PROC FACTOR DATA=census.STANDARD ROTATE=VARIMAX SCREE; /*ASSUMES NO CORRELATION BETWENN FACTOER*/
	ODS OUTPUT ORTHOTFACTPAT=ROTATED;
	PRIORS SMC; 
RUN;

ODS TRACE OFF;
