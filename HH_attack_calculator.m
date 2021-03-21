%% Calculo del RIR para los ataques
%
% La distancia a la que se realiza el ataque de replay viene determinada
% por ASVSpoof 2019
%%

for i=1:3
    
    if i==1
        distancia=[0.25 0.25 1.5];
    elseif i==2
        distancia=[0.75 0.75 1.5];
    else
        distancia=[1.25 1.25 1.5];
    end

    sensor_1=sprintf('sp1 %.1f %.1f %.1f',distancia);
    sensor_2=sprintf('sp2 %.1f %.1f %.1f',distancia);
    sensor_3=sprintf('sp3 %.1f %.1f %.1f',distancia);
    
    %Reemplazamos con esta funcion los parámetros de room_sensor-config:
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_1,1);
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_2,2);
    func_replace_string('room_sensor_config.txt','room_sensor_config.txt','% Sensor positions (in meters)',sensor_3,3);
    
    source_xyz=[distancia;distancia;distancia];
    source_off=[0 0 0;0 0 0;0 0 0];
    HH=roomsimove_single('room_sensor_config.txt',source_xyz,source_off,'omnidirectional');
    
    if i==1
        salida=sprintf('HH_attack_a.mat');
    elseif i==2
        salida=sprintf('HH_attack_b.mat');
    else
        salida=sprintf('HH_attack_c.mat');
    end
    
    save(salida,'HH');
end