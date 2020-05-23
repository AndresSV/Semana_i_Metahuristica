%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Funcion calcF del metodo Electromagnetism Like
%Esta funcion, calcula el vector total de fuerzas que se ejercen entre los
%puntos tomados en el vector X

function F=calcF(m,n,x,fx,xbest,fxbest)
%function [F,m,n,u,l,x,ind]=calcF()

%[m,n,u,l,x,fx,xbest,fxbest,ind]=local(5,0.1);

%calculo de la sumatoria de fx-fxbest
sumf=0;
for k=1:m
    if isnan(fx(k))
        fx(k) = eps;
    end
    sumf = sumf + (fx(k)-fxbest + eps);
end


%calculo de las cargas
q=0;
F=zeros(n,m);
for i=1:m

        q(i)=exp(-n * ((fx(i) - fxbest)/sumf));
        %F(i)=0;
end


%Calculo del vector de fuerzas

for i=1:m
    for j=1:m
        for k = 1:n
            % Calculo del vector de fuerzas solo para una dimension para dos
            % dimensiones cambiar el valor absoluto por la distancia euclidiana
            if fx(j) < fx(i)
               % F(i)=F(i) + (x(j)-x(i)) * ((q(i)*q(j))/(abs(x(j)-x(i))^2+eps));
               %F(i)=F(i) + (x(j)-x(i)) * ((q(i)*q(j))/(distec(x(j),x(i))^2+eps));
               F(k,i) = F(k,i) + (x(j,k) - x(i,k)) * ((q(i) * q(j)) / (distec(x(j,k),x(i,k)) ^ 2 + eps));
            else
               %F(i)=F(i) - (x(j)-x(i)) * ((q(i)*q(j))/(abs(x(j)-x(i))^2+eps));
               F(k,i) = F(k,i) - (x(j,k) - x(i,k)) * ((q(i) * q(j)) / (distec(x(j,k),x(i,k)) ^ 2 + eps)); 
            end
        end
    end
end

%F