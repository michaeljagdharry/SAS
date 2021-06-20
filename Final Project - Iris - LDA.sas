data iris; *Load Data;
  infile "/folders/myfolders/SAS Examples/9705 Final Project/iris_train.dat";
  input species SepalLength SepalWidth PetalLength PetalWidth;
run;
*Species Labels:
1 = Setosa
2 = Versicolor
3 = Virginica;
data test;
 infile "/folders/myfolders/SAS Examples/9705 Final Project/iris_test.dat";
 input species SepalLength SepalWidth PetalLength PetalWidth;
run;

proc discrim data=iris pool=test crossvalidate testdata=test;
*pool=no : means we are assuming different covariance matrices per group and therefore are using QDA;
*pool=yes: means we are assuming equal     covariance matrices per group and therefore are using LDA; 
*pool=test: means we are using Bartlett's test to check for equal covariance matrices, then performing QDA or LDA based on the result. 

*METHOD=NORMAL | NPAR
determines the method to use in deriving the classification criterion. 
When you specify METHOD=NORMAL, a parametric method based on a multivariate normal distribution within each class is used to derive a linear or quadratic discriminant function. 
The default is METHOD=NORMAL. When you specify METHOD=NPAR, a nonparametric method is used and you must also specify either the K= or R= option.;

class species;
var SepalLength SepalWidth PetalLength PetalWidth;
title 'Discriminant Analysis of Iris Data';
run;

proc discrim data=iris method=npar k=5 crossvalidate noclassify testdata=test;
*k=5, 10, or 15 all yield the same cross validation and test error rates;
class species;
var SepalLength SepalWidth PetalLength PetalWidth;
title 'Discriminant Analysis of Iris Data';
run;

proc discrim data=iris method=npar k=10 crossvalidate noclassify testdata=test;
class species;
var SepalLength SepalWidth PetalLength PetalWidth;
title 'Discriminant Analysis of Iris Data';
run;

proc discrim data=iris method=npar k=15 crossvalidate noclassify testdata=test;
class species;
var SepalLength SepalWidth PetalLength PetalWidth;
title 'Discriminant Analysis of Iris Data';
run;

proc candisc data=iris out=iris_cand; class species; run;
proc print data=iris_cand; run;