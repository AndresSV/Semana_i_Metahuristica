%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization
%Universidad Complutense de Madrid / Universidad de Guadalajara

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The algorithm was published as:
%Diego Oliva, Erik Cuevas, Gonzalo Pajares, Daniel Zaldivar, Valentín Osuna. 
%A Multilevel Thresholding algorithm using electromagnetism optimization, 
%Journal of Neurocomputing, 139, (2014), 357-381.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%Funciones para Generar Imagenes de Salida%%%%%%
%Escala de grises
function imgOut=imageGRAY(img,Rvec)
% imgOut=img;
limites=[0 Rvec 255];
tamanho=size(img);
imgOut(:,:)=img*0;
cores=[ 0   0   0;
        255 0   0;
        0   255 0;
        0   0   255;
        255 255 0;
        0   255 255;
        255 0   255;
        255 255 255];
        

k=1;
    for i= 1:tamanho(1,1)
        for j=1:tamanho(1,2)
            while(k<size(limites,2))
                if(img(i,j)>=limites(1,k) && img(i,j)<=limites(1,k+1))
                    imgOut(i,j,1)=limites(1,k);

                end
                k=k+1;
            end
            k=1;
        end
    end