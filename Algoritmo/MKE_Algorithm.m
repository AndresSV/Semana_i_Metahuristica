%Algoritmo Monkey King Evolution
function out = MKE_Algorithm(problem, params)
  %Tomar parámetros de inicialización
  benchmarkfunction = problem.benchmarkfunction;
  dimensions = problem.dimensions;
  populationSize = problem.populationSize;
  
  constant = params.constant;
  limits = params.limits;
  fluctuation = params.fluctuation;
  iterations = params.iterations;
  F = params.F;
  
  %Inicializar espacio de búsqueda (Población inicial)
  population = unifrnd(limits(1), limits(2), populationSize, dimensions);
  %Inicializar mejores posiciones locales
  bestlocal = population;
  
  %Ronda de Inicialización:
  %Inicializar matriz X_mk,G (Máximo global)
  %Xmk -> Small monkey  en la población
  XmkG = population(1,:);
  minTightness = benchmarkfunction(population(1,:));
  for i = 2:populationSize
    tightness = benchmarkfunction(population(i,:));
    if  tightness < minTightness
      minTightness = tightness;
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
  xdiff = r1 - r2;
  
  %Calcular nueva matriz X_mk,G
  XmkG_matrix = XmkG_matrix + fluctuation * xdiff
  
  
  %Actualización de X_mk,G (Máximo global)
  for j = 1:cd
    tightness = benchmarkfunction(XmkG_matrix(j,:));
    if  tightness < minTightness
      minTightness = tightness;
      XmkG = XmkG_matrix(j,:);
    end
  end

  %Iteraciones (Moviendo monos)
  bestt = zeros(iterations);
  for i = 1:iterations
    bestt(i) = minTightness;
    %Mover monos
    for j = 1:populationSize
      %speed = unifrnd(limits(1), limits(2));
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
      %Calcular error de nueva posición
      newtightness = benchmarkfunction(newPosition);
      %Calcular error de mínimo local
      lbtightness = benchmarkfunction(bestlocal(j,:));
      %Actualizar posición en población
      population(j,:) = newPosition;
      
      %Actualizar mínimo local si tiene menor error
      if newtightness < lbtightness
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
    XmkG_matrix = XmkG_matrix + fluctuation * xdiff;
    for(
        %Comprobar que la nueva posicion este dentro del arreglo
        for k = 1:dimensions
            if newPosition(k) < limits(1)
                newPosition(k) = limits(1);
            end
            if newPosition(k) > limits(2)
                newPosition(k) = limits(2);
            end
        end

    
    %Actualización de X_mk,G (Mínimo global)
    for j = 1:cd
      tightness = benchmarkfunction(XmkG_matrix(j,:));
      if  tightness < minTightness
        minTightness = tightness;
        XmkG = XmkG_matrix(j,:);
      end
    end
        
  end
  
  %{
  figure;
  semilogy(bestt, 'LineWidth', 2);
  xlabel('Iteration');
  ylabel('BestTreeCost');
  grid on;
  %}
  
  out = XmkG;
end  
  