data diamonds; *Load Data;
  infile "/folders/myfolders/SAS Examples/9705 Final Project/diamonds2dat.dat";
  input cut carat depth table price x y z;
run;
*Cut Labels:
1 = Fair
2 = Good
3 = Very Good
4 = Premium
5 = Ideal;
  
PROC GLM;
  CLASS cut;
  MODEL carat depth table price x y z = cut;
  MANOVA H=cut/PRINTE PRINTH mstat=exact;
RUN;

*Assessing normality of populations via QQPlots;
proc univariate data=diamonds;
   qqplot carat depth table price x y z/ normal(MU=EST SIGMA=EST);
run;

*Testing Homogeneity of Covariance Matrices;
*(See section titled "Test of Homogeneity of Within Covariance Matrices");
proc discrim data=diamonds pool=test;
class cut;
var carat depth table price x y z;
run;