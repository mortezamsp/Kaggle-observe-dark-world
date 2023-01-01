%script to read all 1-halo skies and calc new center-halo positions.

%clear all
load TrainingSky.mat

binsize = 50;
%NumberOfSingleHalos = 300; %all skies
NumberOfSingleHalos = 100;  %single-halo skies
%NumberOfSingleHalos = 20;   %to run efficiant test

tanforcematris{NumberOfSingleHalos} = 0;
for i = 2 : NumberOfSingleHalos
    tic
    namestr = ['training_Sky' num2str(i)];
    
    data = TrainingSky{i};%data of all trainingsky csv files
    
    [mat ~] = code001_20121205_2(data, binsize, 0);
    
    tanforcematris{i} = mat;
    disp(i);
    toc
end

trainingskytanforce.matris = tanforcematris;
trainingskytanforce.nbin = binsize;
save Training_Sky_tanforces_bin400.mat trainingskytanforce
%clear all



load TrainingHalos.mat
load Training_Sky_tanforces_bin400.mat
matris = trainingskytanforce.matris;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;
for i = 2 : NumberOfSingleHalos
    mat = matris{i};
    [a b] = max(max(mat));
    [c d] = max(mat(:, b));
    SingleHalosCenter(i, 1) = d*(4200/binsize);
    SingleHalosCenter(i, 2) = b*(4200/binsize);
end

save SingleHalosCenter_trainingskies_bin400.mat SingleHalosCenter

trainingskies_errores = TrainingHalos(1:NumberOfSingleHalos,[4 5]) - SingleHalosCenter;
save trainingskies_errores_bin400.mat trainingskies_errores

