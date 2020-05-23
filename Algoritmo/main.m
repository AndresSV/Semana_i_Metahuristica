%Intructions:
% I -> Original Image, could be RGB or Gray Scale
% level -> Number of threshold to find
% This version works with KAPUR as fitness function.

close all
clear all
clc

%Paso 1 cargar imagen
% Se carga la imagen RGB o escala de grises
Ir = imread('test3.jpg');
% Se asigna el nivel de segmentacion 
level = 3;
I = Ir;
I = rgb2gray(Ir);

%Paso 2 Convertir a escala de grises
% Se obtienen los histogramas si la imagen es RGB uno por cada canal si es
% en escala de grises solamente un historgrama.
if size(I,3) == 1 %grayscale image
    [n_countR, x_valueR] = imhist(I(:,:,1));
elseif size(I,3) == 3 %RGB image
    %histograma para cada canal RGB
    [n_countR, x_valueR] = imhist(I(:,:,1));
    [n_countG, x_valueG] = imhist(I(:,:,2));
    [n_countB, x_valueB] = imhist(I(:,:,3));
end
Nt = size(I,1) * size(I,2); %Cantidad total de pixeles en la imagen RENG X COL
%Lmax niveles de color a segmentar 0 - 256
Lmax = 256;   %256 different maximum levels are considered in an image (i.e., 0 to 255)

%Calcular el Histograma
% Distribucion de probabilidades de cada nivel de intensidad del histograma 0 - 256 
for i = 1:Lmax
    if size(I,3) == 1 
        %grayscale image
        probR(i) = n_countR(i) / Nt;
    elseif size(I,3) == 3 
        %RGB image    
        probR(i) = n_countR(i) / Nt;
        probG(i) = n_countG(i) / Nt;
        probB(i) = n_countB(i) / Nt;
    end
end


%Implementacion del algoritmo
%function fitR = Kapur(m,n,level,xR,PI)
% m = 1, n = dimensions, level = level.
%xR = probR, PI = .
problem.benchmarkfunction = @ (x) Kapur (x);
problem.dimensions = level;                     %No de dimensiones 
problem.populationSize = 100;                   %Tamaño de la poblacion
param.constant = 3;                             %Constante Empirica
param.limits = [0, 256];                        %Limites
param.F = 0.05;                                 %Fluctuaciones de los Reyes Monos
param.FC = 5;                                   %Fluctuaciones de los Monos
param.iterations = 1000;                        %No de iteraciones
param.level = level;                                %Thresholdings
param.probR = probR;                            %Distribucion del histograma


%Ejecucion del algoritmo
answer = MKE_optimizer(problem, param);
answer

figure
imshow(Ir)
imprimirImagen(answer, I, probR,level)