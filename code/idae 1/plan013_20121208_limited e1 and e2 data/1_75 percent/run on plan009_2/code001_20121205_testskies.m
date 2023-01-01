%script to read all 1-halo skies and calc new center-halo positions.

clear all
load limittedtestdata_se_chaharom.mat

binsize = 100;

NumberOfSingleHalos = 120;
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;

for i = 2 : NumberOfSingleHalos
    tic
	
    data = limittedtestdata{i};%data of all trainingsky csv files
    [cx cy] = code001_20121208(data, binsize);
	SingleHalosCenter(i, :) = [cx cy];
	
    disp(['i = ' num2str(i) '  , time = ' num2str(toc)]);
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

save SingleHalosCenter_testskies_bin400_plan002.mat SingleHalosCenter


