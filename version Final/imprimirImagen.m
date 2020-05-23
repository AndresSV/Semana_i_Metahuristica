function [] = imprimirImagen(xBestR, I,probR,n)
    gBestR = sort(xBestR);
    Iout = imageGRAY(I,gBestR);
    intensity = gBestR(1:n-1) %best threshold
    figure
    imshow(Iout)
    figure
    imshow(I)
    
    %plot the thresholds over the histogram
    figure 
    plot(probR)
    hold on
    vmax = max(probR);
    for i = 1:n-1
        line([intensity(i), intensity(i)],[0 vmax],[1 1],'Color','r','Marker','.','LineStyle','-')

        hold on
    end
    hold off
end