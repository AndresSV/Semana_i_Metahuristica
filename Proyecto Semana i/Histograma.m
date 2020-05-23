%%Procesamiento
%%image data base
%https://homepages.cae.wisc.edu/~ece533/images/
%Basic Processing

clear all
close all

rgbImage=imread('tigre.jpg');
grayImage=rgb2gray(rgbImage);   %%cambia la imagen a escala de grises

[rows, columns] = size(grayImage); %%definimos dimensión de columnas y filas

H1=zeros(2,256); %%creamos una matriz de 2*256 para almacenar lainformación de la escala de grises
H1(1,:)=0:1:255; %%le damos valor a la fila uno con valores desde 0 a 255


for x=1:rows
    for y=1:columns
        ii=grayImage(x,y);    %%en la variable ii almacenamos el valor de escala de gris que tiene la imagen en la 
                              %%posición (x,y) dada por los for para el
                              %%barrido de la imagen
        H1(2,ii+1)=H1(2,ii+1)+1;    %%en la fila de repeticiones de la matriz H1, en la posición ii+1 incrementa el valor
                                    %%en uno para hacer el conteo
    end
end
%%la siguiente parte del código es sólo para graficar el histograma
 figure;
 bar(H1(1,:),H1(2,:));
 xlabel('Niveles de Gris');
 ylabel('Número de Pixeles');
 title('Mi Histograma');
 xlim([0,255]);

