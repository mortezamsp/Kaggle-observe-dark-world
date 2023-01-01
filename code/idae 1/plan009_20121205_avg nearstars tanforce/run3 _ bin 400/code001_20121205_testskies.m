%script to read all 1-halo skies and calc new center-halo positions.

load TestSky.mat

binsize = 100;
%NumberOfSingleHalos = 300;
NumberOfSingleHalos = 120;

tanforcematris{NumberOfSingleHalos} = 0;
for i = 2 : NumberOfSingleHalos
    tic
    namestr = ['Test_Sky' num2str(i)];
    
    data = TestSky{i};%data of all testsky csv files
    
    [mat ~] = code001_20121205_2(data, binsize, 0);
    
    tanforcematris{i} = mat;
    disp(i);
    toc
end

testskytanforce.matris = tanforcematris;
testskytanforce.nbin = binsize;
save Test_Sky_tanforces_bin100_plan010.mat testskytanforce
%clear all



load Test_Sky_tanforces_bin100_plan010.mat
matris = testskytanforce.matris;
NumberOfSingleHalos = 120;
binsize = 100;
binwidth = uint32(4200/binsize);
SingleHalosCenter(NumberOfSingleHalos, 2) = 0;
for i = 2 : NumberOfSingleHalos
    mat = matris{i};
    
    [a b] = max(max(mat));
    [c d] = max(mat(:, b));
    %a = max(max(mat));
    %[x y] = find(mat == a);
    %d = sum(x)/size(x, 1);
    %b = sum(y)/size(y, 1);
    %clear x;clear y;
    
    %SingleHalosCenter(i, 1) = (d-1)*binwidth + binwidth/2;
    %SingleHalosCenter(i, 2) = (b-1)*binwidth + binwidth/2;
    SingleHalosCenter(i, 1) = d*binwidth;
    SingleHalosCenter(i, 2) = b*binwidth;
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

save SingleHalosCenter_testskies_bin100_plan010.mat SingleHalosCenter
