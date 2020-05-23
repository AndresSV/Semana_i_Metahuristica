clc;
clear;
close all;

%% Definicion del problema

problema.funcion = @(x) sphere(x);  % Cost Function
problema.dimensiones = 3;       % Number of Unknown (Decision) Variables
problema.min =  -5.12;  % Lower Bound of Decision Variables
problema.max =  5.12;   % Upper Bound of Decision Variables

%% Parametros para MK_V2

parametros.MaxIt = 50;        % Maximum Number of Iterations
parametros.poblacion = 20;           % Population Size (Swarm Size)
parametros.c = 3;               % Intertia Coefficient
parametros.f = 5;        % Damping Ratio of Inertia Coefficient
parametros.fc = 0.5;              % Personal Acceleration Coefficient

parametros.mostrar = true; % Flag for Showing Iteration Informatin

%% Llamar MK_V2

out = MK2_min(problema, parametros);

BestSol_1 = out.convergencia;
BestCosts_1 = out.valor;
%% Results

figure('Name','Monkey King Algorythm','NumberTitle','off')
plot(BestCosts_1);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
