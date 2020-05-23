function out = MK2_max(problema, parametros)
%%%%%Algoritmo de Monkey King version V2
%%Template que recibe parametros y función objetivo para optimizar
%%a través del algoritmo Monkey King V2

%% Recibir parametros y problemas
    objetivo = problema.function;     %recibimos la funcion
    
    D = problema.dimension;            %%Numero de dimensiones del problema
    nSize = [1 D];                     %%Declarar el tamaño del array
    
    pop = problema.population;        %%Numero de población 
    MaxLimit = problema.max;
    MinLimit = problema.min;
%% Parametros
    MaxIt = parametros.maxit;
    C = parametros.c;                       %%Constante nivel de explotacion
    F = parametros.f;                       %%Constante F para actualización
    FC = parametros.fc;                     %%Constante de Fluctuación
    
%% Inicializamos    
    small_monkey.posicion = [];
    small_monkey.evaluacion = [];
    small_monkey.local.posicion = [];
    small_monkey.local.evaluacion = [];
    
    monkey_king.posicion = [];
    monkey_king.evaluacion = [];
    monkey_king.global.posicion = [];
    monkey_king.global.evaluacion = [];
    
    vector_random = [];
    
    X = repmat(small_monkey, pop, 1);           %%Matriz de particulas
    Xmk = repmat(monkey_king, (C*D), 1);        %%Matriz de monkey kings
    Xr1 = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 1
    Xr2 = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 2
    
    for i=1:pop                                 %%Asignar valores random a X
        
        %asignar valores aleatorios de posicion
        X(i).posicion=unifrnd(MinLimit, MaxLimit, nSize);
        
        %evaluar cada una en la función
        X(i).evaluacion = objetivo(X(i).posicion);
   
        %Agregar el optimo local
        X(i).local.posicion = X(i).posicion;
        X(i).local.evaluacion = X(i).evaluacion;
        
        %Asignar el primer monkey king
        if i == 1
            Xmk(1).position = X(1).posicion;
            Xmk(1).evaluacion = X(1).evaluacion;
        else
            if X(i).evaluacion > Xmk(1).evaluacion
                Xmk(1).posicion = X(i).posicion;
                Xmk(1).evaluacion = X(i).evaluacion;
            end    
        end
    end
    
    for i=1:(C*D)                           %%rellenar matriz de monkey kings
        Xmk(i).posicion = Xmk(1).posicion;
        Xmk(i).evaluacion = Xmk(1).evaluacion;
    end
    Xmk(1).global.posicion = Xmk(1).posicion;
    Xmk(1).global.evaluacion = Xmk(1).evaluacion;
%% Cálculos
    
    for i=1:MaxIt
        %Actualizar posiciones de Monkey King
        for j=1:pop
            X(j).position = X(j).local.position + ((F*unifrnd(0,1))*(Xmk(1).global.posicion - X(j).posicion));
        end
        
        %Proceso para asignar valores a matrices random
        for j=1:(C*D)                     
            random1 = randi([1,pop]);
            Xr1(j,:) = X(random1).posicion;
        
            random2 = randi([1,pop]);
            Xr2(j,:) = X(random2).posicion;
        end
    
        %Calcular X differetial
        Xdiff = Xr1-Xr2;
    
        %Calcular nueva matriz de Monkey Kings
        Xmk.posicion = Xmk.posicion + (FC .* Xdiff);
    
        %%Actualizar locales
        for j=1:pop                                 
            
            %evaluar cada una en la función
            X(j).evaluacion = objetivo(X(j).posicion);
        
            %Agregar el optimo local
            if X(j).evaluacion > X(j).local.posicion   
                X(j).local.posicion = X(j).posicion;
                X(j).local.evaluacion = X(j).evaluacion;
            end    
        end
        
        %%Actualizar global
        for j=1:(C*D)
           
            %%evaluar en funcion
            Xmk(j).evaluacion = objetivo(Xmk(j).posicion);
            
            %%Comparar con global actual
            if Xmk(j).evaluacion > Xmk(1).global.evaluacion
                Xmk(1).global.posicion = Xmk(j).posicion;
                Xmk(1).global.evaluacion = Xmk(j).evaluacion;
            end    
        end
        
        %mostrar paso a paso
        disp("Iteracion");
        disp(i);
        disp(Xmk(1).global.evaluacion);
    end
    
    out.coordenadas = Xmk(1).global.posicion;
    out.valor = Xmk(1).global.evaluacion; 
end

