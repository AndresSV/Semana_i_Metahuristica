%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Funcion Incialize del metodo Electromagnetism Like
%Esta funcion, inicializa aleatoriamente m puntos de un
%dominio factible en un espacio n dimensional

function x = incializa(m,n,u,l,x)


%inicializacion mejorada
for i = 1:n
    lambda = rand(m,1);
    x(:,i) = fix(l(i) + lambda * (u(i) - l(i)));
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
% end







