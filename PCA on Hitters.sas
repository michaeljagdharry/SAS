
data hitters; *Load Data;
  infile "/folders/myfolders/SAS Examples/hitters.dat";
  input AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun CRuns CRBI CWalks League Division PutOuts Assists Errors Salary NewLeague;
  run;

proc princomp data=hitters;
	var AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun CRuns CRBI CWalks PutOuts Assists Errors; 
	*categorical variables league, division, and new league were removed ;
	*response variables salary was removed;
run;