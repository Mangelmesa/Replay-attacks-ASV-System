%% Calculo de la longitud de multiples archivos de audio

% Este script calcula la longitud en segundos de cada archivos de audio 
%que se encuentre en la carpeta deseada. Devolverá los valores en un vector

%Introducimos la carpeta deseada
cd('Audios')

duracion_T=zeros(200,1);
for file=1:200
    if file<10
        audioname=sprintf('PA_T_000000%d',file);    elseif file>=10 && file<100
        audioname=sprintf('PA_T_00000%d',file);
    else
        audioname=sprintf('PA_T_0000%d',file);
    end
    audioname=strcat(audioname, '.flac');
    [y,fs] = audioread(audioname);
    duracion_T(file,1) = length(y)./fs; % time in seconds
end

duracion_D=zeros(200,1);
for file=1:200
    if file<10
        audioname=sprintf('PA_D_000000%d',file);
    elseif file>=10 && file<100
        audioname=sprintf('PA_D_00000%d',file);
    else
        audioname=sprintf('PA_D_0000%d',file);
    end
    audioname=strcat(audioname, '.flac');
    [y,fs] = audioread(audioname);
    duracion_D(file,1) = length(y)./fs; % time in seconds
end

cd('..')
