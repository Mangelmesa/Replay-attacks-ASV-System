%% Modificador de audio según RIR dado:
%
% En este script se usarán las RIR calculadas con RIR_Calculator para
% modificar los archivos de audio bonafide de ASV Spoof. Se grabarán en
% formato flac con el nombre elegido.
%%

tic
for i=1:27
    
    %Cargamos cada RIR diferente en cada ciclo
    data=sprintf('HH%i.mat',i);
    HH=load(data);
    HH=HH.HH;
    cd('Audios');
    
    %Recorremos los 200 audios bonafide
    for j=1:200
        
        if j<10
            audioname=sprintf('PA_T_000000%d.flac',j);
        elseif j>=10 && j<100
            audioname=sprintf('PA_T_00000%d.flac',j);
        else
            audioname=sprintf('PA_T_0000%d.flac',j);
        end
        
        [s,fs]=audioread(audioname); %Apertura del archivo flac
        
        
        s_HH=fftfilt(HH,s);
        s_HH=s_HH(:,1); %Tenemos 3 sensores, todos a la misma distancia,
                        %nos quedamos solo con el valor de uno
        s_HH_norm=s_HH/max(abs(s_HH)); %Normalizado para evitar clipping
        
        
        %Guardamos los archivos en formato flac:
        filename=sprintf('PA_T_%i_%i.flac',i,j);
        audiowrite(filename,s_HH_norm,fs);
        fprintf('\n Guardando archivo: Impulse response %i numero %i \n',i,j)
    end
    
    cd('..')
end
toc