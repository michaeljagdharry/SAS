/* EXAMPLE 5.16*/

DATA hitters;
  INFILE '/folders/myfolders/SAS Examples/9705 Final Project/john_hitters.dat';
  INPUT League $ Hits HmRun Runs Walks; run;

/* Code to separate data into Al and NL groups 
DATA AL;
   SET hitters;
   IF League = "N" THEN DELETE;
   RUN;
DATA NL;
   SET hitters;
   IF League = "A" THEN DELETE;
   RUN;  
PROC PRINT DATA = AL; PROC PRINT DATA = NL; RUN;

*Checking normality of the 4 variables per AL and NL groups;
title "QQPlots of AL variables";
proc univariate data=AL;
   qqplot Hits HmRun Runs Walks/ normal(MU=EST SIGMA=EST);
  run;
title "QQPlots of NL variables";
proc univariate data=NL;
   qqplot Hits HmRun Runs Walks /normal(MU=EST SIGMA=EST);
  run;

*/

*Testing Normality of the Variables;
title "QQPlots";
proc univariate data=hitters;
   qqplot Hits HmRun Runs Walks /normal(MU=EST SIGMA=EST);
  run;
  
*Testing Homogeneity of Covariance Matrices;
*(See section titled "Test of Homogeneity of Within Covariance Matrices");
proc discrim data=hitters pool=test;
class League;
var Hits HmRun Runs Walks;
run;

TITLE 'Hotelling T2 Test on Hitters';
PROC IML;
  USE hitters;
  READ ALL VAR {Hits HmRun Runs Walks} INTO X;
  X1 = X[1:175,];
  X2 = X[176:322,];
  RESET PRINT;
  N1 = NROW(X1);
  N2 = NROW(X2);
  X1BAR = 1/N1*X1`*J(N1,1);
  X2BAR = 1/N2*X2`*J(N2,1);
  S1 = 1/(N1-1)*X1`*(I(N1)-1/N1*J(N1))*X1; 
  S2 = 1/(N2-1)*X2`*(I(N2)-1/N2*J(N2))*X2;    
  Spl = 1/(N1+N2-2)*((N1-1)*S1+(N2-1)*S2);     
  T2 = N1*N2/(N1+N2)*(X1BAR-X2BAR)`*INV(Spl)*(X1BAR-X2BAR);
RUN;