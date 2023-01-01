%script to read all 1-halo skies and calc new center-halo positions.

clear all
load TrainingSky.mat

binsize = 100;
%NumberOfSingleHalos = 300; %all skies
NumberOfSingleHalos = 200;  %single-halo skies
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
save Training_Sky_tanforces_bin100_plan010.mat trainingskytanforce
%clear all



%part 2 : calc halos center
load TrainingHalos.mat
load Training_Sky_tanforces_bin100_plan010.mat

matris = trainingskytanforce.matris;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;

image_size = 4200;
binwidth = double(image_size)/double(binsize);

for i = 2 : NumberOfSingleHalos
    mat = matris{i};
    [a b] = max(max(mat));
    [c d] = max(mat(:, b));
    SingleHalosCenter(i, 1) = d*binwidth + binwidth/2;
    SingleHalosCenter(i, 2) = b*binwidth + binwidth/2;
end
for i = 2 : NumberOfSingleHalos
    SingleHalosCenter(i,1) = SingleHalosCenter(i,1) + mod(SingleHalosCenter(i,1),4)*rand();
    SingleHalosCenter(i,2) = SingleHalosCenter(i,2) + mod(SingleHalosCenter(i,2),4)*rand();
    if(SingleHalosCenter(i, 1) < 90)
        SingleHalosCenter(i,1) = 90 + mod(SingleHalosCenter(i,1),4)*rand();
    end
    if(SingleHalosCenter(i, 2) < 90)
        SingleHalosCenter(i,2) = 90 + mod(SingleHalosCenter(i,2),4)*rand();
    end
end

save SingleHalosCenter_trainingskies_bin100_plan010.mat SingleHalosCenter

trainingskies_errores = TrainingHalos(1:NumberOfSingleHalos,[4 5]) - SingleHalosCenter;
save trainingskies_errores_bin100_plan010.mat trainingskies_errores

