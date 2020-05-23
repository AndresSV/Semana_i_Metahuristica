%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Funcion que realiza la busqueda de minimos locales en Electromagnetism Like
%realiza la busqueda en el subspacio inicializado por la funcion inicializa
%clear

function [bR,xR,fitR,xBestR,fxBestR] = local(I,Lmax,level,LSITER,delta,m,n,l,u,xR,fitR, probR)

%se calcula la diferencia entre los limites
restas = u - l;

%se obtiene la longitud del paso de busqueda
longitud = delta * max(restas);

vmin = -5;
vmax = 5;

%algortimo de busqueda local

    for i=1:m 
        for k=1:n
            cont=1;
            %se obtiene el primer valor aleatorio lambda
            lambda1 = rand;
            while cont < LSITER
                y = xR(i,:);
                %se obtiene el segundo valor aleatorio lambda
                lambda2 = rand;
                %se verifica en q sentido se va a realizar la busqueda
                %dependiendo de lambda1
                if lambda1 > 0.5
                    v1 = fix(lambda2 * longitud);
                    % se verifica que los valores de velociddad esten dentro de los maximos y minimos extablecidos
                    v1 = ( (v1 <= vmin) .* vmin ) + ( (v1 > vmin) .* v1 );
                    v1 = ( (v1 >= vmax) .* vmax ) + ( (v1 < vmax) .* v1 );
                    y(k) = y(k) + v1;
                else
                    v1 = fix(lambda2 * longitud);
                    % se verifica que los valores de velociddad esten dentro de los maximos y minimos extablecidos
                    v1 = ( (v1 <= vmin) .* vmin ) + ( (v1 > vmin) .* v1 );
                    v1 = ( (v1 >= vmax) .* vmax ) + ( (v1 < vmax) .* v1 );
                    y(k) = y(k) - v1;
                end
                %evalua el nuevo valor de y modificado en la funcion
                % Verifica que los valores esten dentro de los limites del
                % espacio de busqueda
                %if y(k) >= u(k), y(k) = u(k); end
                %if y(k) <= l(k), y(k) = l(k); end
                y = ( (y <= l(1)).*l(1) ) + ( (y > l(1)).*y );
                y = ( (y >= u(1)).*u(1) ) + ( (y < u(1)).*y );
                
                
                    y=sort(y); 
 

                
                % Evalua en la funcion objetivo
                %[fity, fitBesty] = fitnessIMG(I(:,:,1), 1, Lmax, level, y, probR);
                fity = Kapur(1,n,level,y,probR);

                %verifica si el punto y minimiza la funcion
                if fity > fitR(i) %|| isnan(fitR(i)) %Maximiza
                    %for j=1:n
                        xR(i,k) = y(k);
                        fitR(i) = fity;
                    %end
                    cont=LSITER-1;
                end
                cont=cont+1;
            end
        end


    end
%             for si=1:length(xR)
%                 xR(si,:)=sort(xR(si,:)); 
%             end 
%     [fitR, fitBestR] = fitnessIMG(I, m, Lmax, level, xR, probR);
    
    %se obtiene el valor optimo del fitness
    [aR, bR] = max(fitR); %maximiza
    %se asigna a la variable xbest
    xBestR = xR(bR, :);
    fxBestR = fitR(bR);