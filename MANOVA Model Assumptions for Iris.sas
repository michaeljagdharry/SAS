
data iris; *Load Data;
  infile "/folders/myfolders/SAS Examples/9705 Final Project/iris.dat";
  input species SL SW PL PW;
  run;
*Species Labels:
1 = Setosa
2 = Versicolor
3 = Viriginica;

PROC GLM; *Collecting residual data;
  CLASS species;
  MODEL SL SW PL PW = species;
  OUTPUT OUT=resids r=rSL rSW rPL rPW;
  *MANOVA H=species/PRINTE PRINTH;
RUN;
proc print;
run;

*Assessing normality of residuals via histogram;
proc sgplot data=resids;
	histogram rSL; run;
proc sgplot data=resids;
	histogram rSW; run;
proc sgplot data=resids;
	histogram rPL; run;
proc sgplot data=resids;
	histogram rPW; run;

*Assessing normality of populations via QQPlots;
proc univariate data=resids;
   qqplot SL SW PL PW/ normal(MU=EST SIGMA=EST);
  run;

*Assessing independence of residuals;
proc sgscatter data=resids;
  title "Scatterplot Matrix for Iris Data";
  matrix rSL rSW rPL rPW;
run;

*Testing Homogeneity of Covariance Matrices;
*(See section titled "Test of Homogeneity of Within Covariance Matrices");
proc discrim data=iris pool=test;
class species;
var SL SW PL PW;
run;
