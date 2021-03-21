# Replay-attacks-ASV-System

=====================================================================================================
Generador de audios de data augmentation y audios spoof siguiendo las directrices de ASVSpoof 2019
=====================================================================================================

1. Archivos incluidos:
_______________________

-->Funciones y archivos de roomsimove (https://homepages.loria.fr/evincent/software/Roomsimove_1.4.zip):
    --> cardioid.mat
    -->omnidirectional.mat
    -->room_sensor_config.txt
    -->roomsimove.m
    -->roomsimove_apply.m
    -->roomsimove_single.m
    -->RT60.m
    -->source_config

--> Función de Synchronized Swept Sine (https://ant-novak.com/pages/sss/):
    --> SSS
    
-->Funciones y archivos extra generados:
    -->func_replace_string.m
    -->HH_attack_calculator.m
    -->possible_comb.txt
    -->possible_comb_attack.txt
    -->RIR_Applier.m
    -->RIR_Calculator.m
    -->Spoof_generator.m
    
--> Archivos de audio en la carpeta Audios


3. Funcionamiento de los scripts:
___________________________________
1. Correr RIR_Calculator: Esta función calculará los RIR de las 27 configuraciones diferentes establecidas en ASVSpoof 2019, según distancia ASV-usuario, RT60 y tamaño
de habitación, y guardará la respuesta al impulso en archivos .mat. No es necesario realizar modificación alguna.

2. Correr RIR_Applier: Necesita la entrada de los archivos de audio de la carpeta Audios, y devuelve en ella misma los archivos originales modificados por la RIR. 
La manera de salvar los nombres de los audios puede ser modificada a conveniencia.

3. Correr SSS: Genera los HHFR que simulan los efectos no lineales del altavoz usado para el ataque. Solo necesita modificar f1, f2 y descomentar al final para salvar el valor

4. Correr HH_attack_calculator: Esta función calcula el RIR de la habitación cuando se realizan los ataques. Encontramos unas distancias ASV-Usuario distintas a las usadas en 
la generación de audios bonafide. No requiere modificación.

5. Correr Spoof_generator: Esta función usa el RIR de la habitación y el HHFR para simular los ataques según la Fig.2 del Evaluation Plan de ASVSpoof 2019. 
                           Necesita los archivos de la carpeta Audios para funcionar, y guarda en ella los archivos generados.

Una vez hecho esto, en la carpeta Audios tendremos los audios originales, los audios de data augmentation bonafide, y los audios spoof deseados.

4. Comentarios y problemas encontrados:
___________________________________
1. El archivo de room_sensor_config.txt es usado por roomsimove_single y contiene distintas configuraciones, entre ellas el tamaño de habitación, posición de los sensores 
y coef. de absorción de las paredes. Esos parámetros se pueden modificar para simular distintas habitaciones. El valor de RT60 establecido por ASVSpoof 2019 (se puede consultar 
al principio del script RIR_Calculator.m) no se puede obtener para el tamaño de habitación que ellos usan. 
Posibles soluciones/alternativas:
  1. Variar el tamaño de la habitación fuera del rango para obtener RIR correcto. Por tanto, tendríamos el mismo RT60 pero unas dimensiones de la habitación muy diferentes.
  2. Variar el coeficiente de absorción de las paredes: La única otra alternativa, pues RT60 solo depende de ambos valores. Por defecto todos los valores están a 0.671.
  Según (https://cds.cern.ch/record/1251519/files/978-3-540-48830-9_BookBackMatter.pdf), ese valor no tiene mucho sentido. Variando el valor dependiendo del tamaño de la 
  habitación podemos obtener el RT60 deseado, puesto que con un valor fijo nunca obtendremos tres valores que casen. Además, el valor no puede ser muy pequeño puesto que si
  no MATLAB no puede calcular tantos ecos. 
  
2. La función SSS genera los efectos no lineales del altavoz. Para los altavoces de calidad alta-baja, se escucha el audio repetido con mucho eco. 
Posibles soluciones/alternativas: 
  1. Variar la frecuencia y la duración del SSS no cambia este efecto
