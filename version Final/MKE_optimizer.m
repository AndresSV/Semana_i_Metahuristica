function out = MKE_optimizer( problem, params )
%MKE_ALGORITHMV2 Una variación del algoritmo Monkey King Evolution
%   Funciona igual que el MKE Original, solo que busca los valores máximos
%   en valores discretos.

  %Tomar parámetros de inicialización
  
  %benchmarkfunction = problem.benchmarkfunction;
  %Kapur se utiliza como benchmark function predeterminada con los siguientes parámetros:
  % m = 1                   : Ya que se evalúa un solo vector
  % n = dimensions          : Número de thresholds
  % level = params.level    : Cantidad de clases 
  % xr = vector monkey      : Vector a evaluar
  % probR = params.probR    : Probabilidad para el histograma (constante)
  % m =1 , no dimensiones threshold = level no clases, xr poblacion, probR histograma normalizado
  m = 1;
  
  %Parámetros para el algoritmo MKE
  dimensions = problem.dimensions;
  populationSize = problem.populationSize;
  constant = params.constant;
  
  %Parámetros para la función
  level = params.level;
  probR = params.probR;
  limits = params.limits;
  iterations = params.iterations;
  FC = params.FC;                   %Fluctuación para los Kings
  F = params.F;                     %Fluctuación para los Smalls
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %Inicializar espacio de búsqueda (Población inicial)
  %Los vectores deben de tener valores ordenados
  population = zeros(populationSize, dimensions);
  for i = 1:populationSize
      population(i,:) = sort(unidrnd(limits(2), 1, dimensions));
  end
  
  %Inicializar mejores posiciones locales
  bestlocal = population;
  
  %Ronda de Inicialización:
  %Inicializar matriz X_mk,G (Máximo global)
  %Xmk -> Small monkey  en la población
  XmkG = population(1,:);
  maxTightness = Kapur(m, dimensions, level, population(1,:), probR);
  for i = 2:populationSize
    tightness = Kapur(m, dimensions, level, population(i,:), probR);
    if  tightness > maxTightness
      maxTightness = tightness;
      XmkG = population(i,:);
    end
  end

  %Matrix X_mk,G
  %En la primera iteración, todos los Kings son iguales
  cd = constant * dimensions;
  XmkG_matrix = repmat(XmkG, cd, 1);
  
  %Inicializar R1 y R2
  r1 = zeros(cd, dimensions);
  r2 = zeros(cd, dimensions);
 
  for i = 1:cd
    j = randi([1, populationSize]);
    r1(i,:) = population(j, :);
    j = randi([1, populationSize]); 
    r2(i,:) = population(j, :);
  end
  
  %Calcular  X_diff
  xdiff = abs(r1 - r2);
  
  %Calcular nueva matriz X_mk,G
  XmkG_matrix = XmkG_matrix + FC * xdiff;
  
  %Ordenar vectores en la matriz de Kings
  for i = 1:cd
    XmkG_matrix(i,:) = sort(XmkG_matrix(i,:));
  end
  for j = 1:cd
        %Comprobar que la nueva posicion este dentro del arreglo
        for k = 1:dimensions
            if XmkG_matrix(j, k) < limits(1)
                XmkG_matrix(j,k) = limits(1);
            end
            if XmkG_matrix(j, k) > limits(2)
                XmkG_matrix(j,k) = limits(2);
            end
        end
   end
  
  %Actualizaciónn de X_mk,G (Máximo global)
  for j = 1:cd
    tightness = Kapur(m, dimensions, level, XmkG_matrix(j,:), probR);
    if  tightness > maxTightness
      maxTightness = tightness;
      XmkG = XmkG_matrix(j,:);
    end
  end

  %Iteraciones (Moviendo monos)
  bestt = zeros(iterations);
  for i = 1:iterations
    bestt(i) = maxTightness;
    %Mover monos
    for j = 1:populationSize
      %speed = unidrnd( limits(2));
      newPosition = bestlocal(j,:) + F * rand() * (XmkG - population(j,:));
      %Comprobar que la nueva posicion este dentro del arreglo
      for k = 1:dimensions
          if newPosition(k) < limits(1)
              newPosition(k) = limits(1);
          end
          if newPosition(k) > limits(2)
              newPosition(k) = limits(2);
          end
      end
      %Ordenar el vector
      newPosition = sort(fix(newPosition));
      %Calcular error de nueva posión
      newtightness = Kapur(m, dimensions, level, newPosition, probR);
      %Calcular error de máximo local
      lbtightness = Kapur(m, dimensions, level, bestlocal(j,:), probR);
      %Actualizar posición en poblaciÃ³n
      population(j,:) = newPosition;
      
      %Actualizar máximo local si es mayor el nuevo tightness
      if newtightness > lbtightness
        bestlocal(j,:) = newPosition;
      end
    end
    
    %Actualizar R1 y R2
    for j = 1:cd
      k = randi([1, populationSize]);
      r1(j,:) = population(k, :);
      k = randi([1, populationSize]); 
      r2(j,:) = population(k, :);
    end

    %Calcular  X_diff
    xdiff = r1 - r2;
    
    %Calcular nueva matriz X_mk,G
    XmkG_matrix = XmkG_matrix + FC * xdiff;
    
    %"Normalizar" vectores
    for j = 1:cd
        %Comprobar que la nueva posicion este dentro del arreglo
        for k = 1:dimensions
            if XmkG_matrix(j, k) < limits(1)
                XmkG_matrix(j,k) = limits(1);
            end
            if XmkG_matrix(j, k) > limits(2)
                XmkG_matrix(j,k) = limits(2);
            end
        end
    end
    
    %Ordenar vectores en la matriz de Kings
    for j = 1:cd
      XmkG_matrix(j,:) = sort(XmkG_matrix(j,:));
    end
    
    %Actualización de X_mk,G (Máximo global)
    for j = 1:cd
      tightness = Kapur(m, dimensions, level, XmkG_matrix(j,:), probR);
      if  tightness > maxTightness
        maxTightness = tightness;
        XmkG = XmkG_matrix(j,:);
      end
    end
        
  end
  
  figure;
  semilogy(bestt, 'LineWidth', 2);
  xlabel('Iteration');
  ylabel('BestTreeCost');
  grid on;
  
  out = XmkG;

end
    
 
