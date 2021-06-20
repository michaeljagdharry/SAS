
data iris; *Load Data;
  infile "/folders/myfolders/SAS Examples/iris.dat";
  input species SepalLength SepalWidth PetalLength PetalWidth;
  run;
*Species Labels:
1 = Setosa
2 = Versicolor
3 = Viriginica;

proc print data=iris; *View Data;
	var species SepalLength SepalWidth PetalLength PetalWidth;
run;
PROC GLM; *MANOVA Analysis;
  CLASS species;
  MODEL SepalLength SepalWidth PetalLength PetalWidth = species;
  MANOVA H=species/PRINTE PRINTH;
RUN;
