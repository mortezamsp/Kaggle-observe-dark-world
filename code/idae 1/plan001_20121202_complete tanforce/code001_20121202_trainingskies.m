%script to read all 1-halo skies and calc new center-halo positions.

load TrainingSky.mat

NumberOfSingleHalos = 100;

tanforcematris{NumberOfSingleHalos} = 0;
for i = 2 : NumberOfSingleHalos
    tic
    namestr = ['training_Sky' num2str(i)];
    
    data = TrainingSky{i};%data of all trainingsky csv files
    
    [mat ~] = code001_20121202(data, 400, 1);
    %imwrite(scale255(mat), strcat(namestr, '.jpg'), 'jpg');

    tanforcematris{i} = mat;
    disp(i);
    toc
end

trainingskytanforce.matris = tanforcematris;
trainingskytanforce.nbin = 400;
save Training_Sky_tanforces_bin400.mat trainingskytanforce
clear all


load TrainingHalos.mat
load Training_Sky_tanforces_bin400.mat
matris = trainingskytanforce.matris;
NumberOfSingleHalos = 100;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;
for i = 2 : NumberOfSingleHalos
    mat = matris{i};
    [a b] = max(max(mat));
    [c d] = max(mat(:, b));
    SingleHalosCenter(i, 1) = d*(4200/400);
    SingleHalosCenter(i, 2) = b*(4200/400);
end

save SingleHalosCenter_trainingskies_bin400.mat SingleHalosCenter

trainingskies_errores = TrainingHalos(1:100,[4 5]) - SingleHalosCenter;
save trainingskies_errores_bin400.mat trainingskies_errores

