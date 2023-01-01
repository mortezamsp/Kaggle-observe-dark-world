%script to read all 1-halo skies and calc new center-halo positions.

load limitteddata_se_chaharom.mat

NumberOfSingleHalos = 100;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;

for i = 2 : NumberOfSingleHalos
    tic
    
    data = limitteddata{i};%data of all trainingsky csv files
    [cx cy] = code001_20121209_se_chaharom(data, 800);
    SingleHalosCenter(i, :) = [cx, cy];

    disp(['i = ' num2str(i) '  ,time = ' num2str(toc())]);
end
save SingleHalosCenter_trainingskies_bin800_limitted_plan002.mat SingleHalosCenter

load TrainingHalos.mat
trainingskies_errores = TrainingHalos(1:100,[4 5]) - SingleHalosCenter;
save trainingskies_errores_bin800_limitted_plan002.mat trainingskies_errores
