function out = MK2_min(problema, parametros)
%%%%%Algoritmo de Monkey King version V2
%%Template que recibe parametros y función objetivo para optimizar
%%a través del algoritmo Monkey King V2

%% Recibir parametros y problemas
    objetivo = problema.funcion;                %recibimos la funcion
    D = problema.dimensiones;                 %%Numero de dimensiones del problema
    nSize = [1 D];                              %%Declarar el tamaño del array
    MaxLimit = problema.max;
    MinLimit = problema.min;
%% Parametros
    pop = parametros.poblacion;                %%Numero de población 
    MaxIt = parametros.MaxIt;                   %%Numero de iteraciones
    C = parametros.c;                           %%Constante nivel de explotacion
    F = parametros.f;                           %%Constante F para actualización
    FC = parametros.fc;                         %%Constante de Fluctuación
    MostrarInfoIteracion = parametros.mostrar;
    
%% Inicializamos    
    small_monkey.posicion = [];
    small_monkey.evaluacion = [];
    small_monkey.local.posicion = [];
    small_monkey.local.evaluacion = [];
    
    monkey_king.posicion = [];
    monkey_king.evaluacion = [];
    monkey_king.global.posicion = [];
    monkey_king.global.evaluacion = [];
    
    vector_random.posicion = [];
    
    X = repmat(small_monkey, pop, 1);           %%Matriz de particulas
    Xmk = repmat(monkey_king, (C*D), 1);        %%Matriz de monkey kings
    Xr1 = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 1
    Xr2 = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 2
    Xfactor = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 2
    Xdiff = repmat(vector_random, (C*D), 1);      %%Matriz de small monkeys random 2
    
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
            if X(i).evaluacion < Xmk(1).evaluacion
                Xmk(1).posicion = X(i).posicion;
                Xmk(1).evaluacion = X(i).evaluacion;
            end    
        end
    end
    
    for i=1:(C*D)                           %%rellenar matriz de monkey kings
        Xmk(i).posicion = Xmk(1).posicion;
        Xmk(i).evaluacion = Xmk(1).evaluacion;
    end
    
    %Definicion de mejor global
    Xmk(1).global.posicion = Xmk(1).posicion;
    Xmk(1).global.evaluacion = Xmk(1).evaluacion;
    
    %Variable donde se guardara el vector de resulatados
    globales = [1 MaxIt];
%% Cálculos
    
    for h=1:MaxIt
        %Actualizar posiciones de Monkey King
        for j=1:pop
            X(j).position = X(j).local.posicion + ((F*unifrnd(0,1))*(Xmk(1).global.posicion - X(j).posicion));
        end
        
        %Proceso para asignar valores a matrices random
        for j=1:(C*D)                     
            random1 = randi([1,pop]);
            Xr1(j).posicion = X(random1).posicion;
        
            random2 = randi([1,pop]);
            Xr2(j).posicion = X(random2).posicion;
        end
    
        %Calcular X differetial
        for j=1:(C*D)
            Xdiff(j).position = Xr1(j).posicion-Xr2(j).posicion;
        end
        
        %Calcular nueva matriz de Monkey Kings
        for j=1:(C*D)    
            Xfactor(j).position = FC * Xdiff(j).position;
            Xmk(j).posicion = Xmk(j).posicion + Xfactor(j).position;
        end
        
    
        %%Actualizar locales
        for j=1:pop                                 
            
            %evaluar cada una en la función
            X(j).evaluacion = objetivo(X(j).posicion);
        
            %Agregar el optimo local
            if X(j).evaluacion < X(j).local.posicion   
                X(j).local.posicion = X(j).posicion;
                X(j).local.evaluacion = X(j).evaluacion;
            end    
        end
        
        %%Actualizar global
        for j=1:(C*D)
           
            %%evaluar en funcion
            Xmk(j).evaluacion = objetivo(Xmk(j).posicion);
            
            %%Comparar con global actual
            if Xmk(j).evaluacion < Xmk(1).global.evaluacion
                Xmk(1).global.posicion = Xmk(j).posicion;
                Xmk(1).global.evaluacion = Xmk(j).evaluacion;
            end    
        end
        
        %Alamacenar resultado en un vecto para graficar la salida
        globales(h) = Xmk(1).global.evaluacion;
        
        %mostrar paso a paso
        if MostrarInfoIteracion
            disp(globales(h))
        end
    end
    
    out.coordenadas = Xmk(1).global.posicion; 
    out.valor = globales;
    out.convergencia = Xmk(1).global.evaluacion; 
end

