%% Generador de audios Spoof
%
%Usando los archivos obtenidos con RIR_Applier, les aplicamos los efectos
%no lineales calculados con SSS y de nuevo los pasamos por
%roomsimove_single para simular un ataque. Los archivos Hm se obtienen de
%SSS, representan los HHFR. Los audios se guardan en %archivos flac.

%% Posibles combinaciones de calidad del altavoz y distancia:
fid = fopen('possible_comb_attack.txt');
data = textscan(fid, '%s', 'Delimiter', '\n', 'CollectOutput', true);
fclose(fid);
tic
%%

for i=1:9
    
    comb=((data{1}{i}));
    
    if comb(1)=='a'
        HH=load('Hm_perfect.mat');
        HH=HH.Hm_perfect;
        
    elseif comb(1)=='b'
        HH=load('Hm_High.mat');
        HH=HH.Hm_High;
        
    else
        HH=load('Hm_Low.mat');
        HH=HH.Hm_Low;
        
    end
    
    if comb(2)=='a'
        HH_attack=load('HH_attack_a.mat');
        HH_attack=HH_attack.HH;
        
    elseif comb(2)=='b'
        HH_attack=load('HH_attack_b.mat');
        HH_attack=HH_attack.HH;
    else
        HH_attack=load('HH_attack_c.mat');
        HH_attack=HH_attack.HH;
        
    end
    
    cd('Audios');
    
    %% Recorremos los audios generados:
    for j=1:27
        for k=1:200
            audioname=sprintf('PA_T_%i_%i.flac',j,k);
            
            [s,fs]=audioread(audioname);
            
            s_HH=real(conv2(s,HH,'same')); %Efectos no lineales altavoz
            s_HH=fftfilt(HH_attack,s_HH); %Pasador por el RIR
            s_HH=s_HH(:,1); %Nos quedamos con un canal de audio mono
            s_HH_norm=real(s_HH/max(abs(s_HH))); %Normalizamos para evitar clipping
            
            
            filename=sprintf('PA_T_%i_%i_spoof.flac',j,k);
            audiowrite(filename,s_HH_norm,fs);
            fprintf('\n Guardando archivo: Spoof with impulse response %i number %i \n',j,k)
        end
        
        
    end
    cd('..')
end
toc