%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Funcion Move del metodo Electromagnetism Like
%Esta funcion, desplaza un punto i tomado en direccion de la fuerza por
%medio de una longitud de paso distribuida uniformemente


function x = moveO(F,x,m,n,ind,l,u)

%[F,m,n,u,l,x,ind]=calcF();
vmin = -5;
vmax = 5;

for i=1:m
    if i ~= ind
        for k=1:n
        %se obtiene aleatoriamente un numero lambda
        lambda = random('Unif',0,1);
        F(k,i) = F(k,i) / (abs(F(k,i)) + eps);
        % se hace el desplazamiento del punto i
        
            if F(k,i) > 0
                v1 = fix(lambda * F(k,i) * (u(k) - x(i,k)));
                % se verifica que los valores de velociddad esten dentro de los maximos y minimos extablecidos
                v1 = ( (v1 <= vmin) .* vmin ) + ( (v1 > vmin) .* v1 );
                v1 = ( (v1 >= vmax) .* vmax ) + ( (v1 < vmax) .* v1 );
                x(i,k) = x(i,k) + v1;
            else
                v1 = fix( lambda * F(k,i) * (x(i,k) - l(k)));
                % se verifica que los valores de velociddad esten dentro
                % de los maximos y minimos extablecidos
                v1 = ( (v1 <= vmin) .* vmin ) + ( (v1 > vmin) .* v1 );
                v1 = ( (v1 >= vmax) .* vmax ) + ( (v1 < vmax) .* v1 );
                x(i,k) = x(i,k) + v1;
            end
        end
    end
end

            for si=1:length(x)
                x(si,:)=sort(x(si,:)); 
            end




% x = ( (x <= l(1)).*l(1) ) + ( (x > l(1)).*x );
% x = ( (x >= u(1)).*u(1) ) + ( (x < u(1)).*x );
% for j = 1:m
%     for k = 1:n
% 
%             %grayscale image
%             if (k == 1) && (k ~= n)
%                 if x(j,k) < l(k)
%                     x(j,k) = l(k);
%                 elseif x(j,k) > x(j,k+1)
%                     x(j,k) = x(j,k+1);
%                 end
%             end
%             if ((k > 1) && (k < n))
%                 if x(j,k) < x(j,k - 1)
%                     x(j,k) = x(j,k - 1);
%                 elseif x(j,k) > x(j,k + 1)
%                     x(j,k) = x(j,k + 1);
%                 end
%             end
%             if (k == n)&&(k~=1)
%                 if x(j,k) < x(j,k-1)
%                     x(j,k) = x(j,k-1);
%                 elseif x(j,k) > u(k)
%                     x(j,k) = u(k);
%                 end
%             end
%             if (k == 1) && (k == n)
%                 if x(j,k) < l(k)
%                     x(j,k) = l(k);
%                 elseif x(j,k) > u(k)
%                     x(j,k) = u(k);
%                 end
%             end
%     end
%end
     
