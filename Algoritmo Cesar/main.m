%Espacio de inicialización
problem.benchmarkfunction = @ (x) bohal (x);
problem.dimensions = 2;
problem.populationSize = 100;
param.constant = 3;
param.limits = [-100, 100];
param.fluctuation = 0.5;
param.F = 5;
param.iterations = 5000;

%Ejecución algoritmo
result = MKE_Algorithm(problem, param);
result
