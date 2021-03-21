%% Calculo de la Respuesta al impulso de la habitación (RIR) 

% Este script calculará las RIR usando las combinaciones de tamaño de
% habitacion, RT60 y distancia Usuario-ASV descritas por ASVSpoof 2019:
%
%                                    a           b           c
%-------------------------------------------------------------------
% S: Room size (square meters)		2-5		    5-10		10-20
% R: RT60 (ms)		         		50-200		200-600		600-1000
% D_s: Talker-to-ASV distance (cm)	10-50		50-100		100-150

%La RIR se guardará en un archivo .mat para su posterior uso

%% Cargamos las posibles combinaciones de tamaño de habitación, RT60,etc:
fid = fopen('possible_comb.txt'); 
data = textscan(fid, '%s', 'Delimiter', '\n', 'CollectOutput', true);
fclose(fid);
tic

for i=1:27 %Recorremos las 27 combinaciones 
    comb=((data{1}{i}));
    
    %Tamaño de la habitación
    if comb(1)=='a'
        tam=[2.5 2 2.7];
    elseif comb(1)=='b'
        tam=[5  2  2.7];
    else
        tam=[5  4  2.7];
    end
    
    %Distancia ASV-Usuario
    if comb(3)=='a'
        distancia=[0.5  0.5 1.5];
    elseif comb(3)=='b'
        distancia=[1    1   1.5];
    else
        distancia=[1.5  1.5 1.5];
    end
    
    %% Modificamos room_sensor_config.txt con la distancia y tamaño elegidos:
    sensor_1=sprintf('sp1 %.1f %.1f %.1f',distancia);
    sensor_2=sprintf('sp2 %.1f %.1f %.1f',distancia);
    sensor_3=sprintf('sp3 %.1f %.1f %.1f',distancia);
    tam_hab=sprintf('room_size %.1f %.1f %.1f',tam);
    
    %Reemplazamos con esta funcion los parámetros de room_sensor-config:
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Room size (in meters)',tam_hab,1);
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_1,1);
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_2,2);
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_3,3);
    
    
    source_xyz=[distancia;distancia;distancia]; %Valor dummy, no se usan
    source_off=[0 0 0;0 0 0;0 0 0];   %Valor dummy, no se usan
    
    %Calculamos RIR con roomsimove_single y salvamos en HH(combinacion).mat:
    HH=roomsimove_single('room_sensor_config.txt',source_xyz,source_off,'omnidirectional',1);
    salida=sprintf('HH%i.mat',i);
    save(salida,'HH');
    
end
toc
