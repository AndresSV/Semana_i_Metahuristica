%Espacio de inicialización
problem.benchmarkfunction = @ (x) Kapur (x);
problem.dimensions = 2;
problem.populationSize = 100;
param.constant = 3;
param.limits = [-100, 100];
param.fluctuation = 0.5;
param.FC = 5;
param.iterations = 5000;
param.level = 2;


%Ejecución algoritmo
result = MKE_optimizer(problem, param);
result