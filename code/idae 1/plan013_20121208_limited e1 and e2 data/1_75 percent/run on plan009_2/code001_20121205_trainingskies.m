%script to read all 1-halo skies and calc new center-halo positions.

clear all
load limitteddata_se_chaharom.mat

binsize = 400;

NumberOfSingleHalos = 100;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;

for i = 2 : NumberOfSingleHalos
    tic
	
    data = limitteddata{i};%data of all trainingsky csv files
    [cx cy] = code001_20121208(data, binsize);
	SingleHalosCenter(i, :) = [cx cy];
	
    disp(['i = ' num2str(i) '  , time = ' num2str(toc)]);
end
save SingleHalosCenter_trainingskies_bin400_plan009.mat SingleHalosCenter

load TrainingHalos.mat
trainingskies_errores = TrainingHalos(1:NumberOfSingleHalos,[4 5]) - SingleHalosCenter;
save trainingskies_errores_bin100_plan009.mat trainingskies_errores

