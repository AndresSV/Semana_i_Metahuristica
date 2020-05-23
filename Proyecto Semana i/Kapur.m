%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function fitR = Kapur(m,n,level,xR,PI)


%Metodo de Entropia de Kapur
fitR = zeros(1,m);
for j = 1: m
    PI0 = PI(1:xR(j,1)); % probabilidad de la primer clase
    ind = PI0 == 0;
    ind = ind .* eps;
    PI0 = PI0 + ind;
    clear ind
    w0 =  sum(PI0); %w0 de la primer clase
    H0 = -sum((PI0/w0).*(log2(PI0/w0)));
    fitR(j) = fitR(j) + H0;
    
    for jl = 2: level
        PI0 = PI(xR(j,jl-1)+1:xR(j,jl)); % probabilidad de la primer clase
        ind = PI0 == 0;
        ind = ind .* eps;
        PI0 = PI0 + ind;
        clear ind
        w0 =  sum(PI0); %w0 de la primer clase
        H0 = -sum((PI0/w0).*(log2(PI0/w0)));
        fitR(j) = fitR(j) + H0;
    end  
end








