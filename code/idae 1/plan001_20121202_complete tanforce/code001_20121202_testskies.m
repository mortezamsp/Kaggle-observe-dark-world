%script to read all 1-halo skies and calc new center-halo positions.

load TestSky.mat
NumberOfSingleHalos = 120;

tanforcematris{NumberOfSingleHalos} = 0;
for i = 2 : NumberOfSingleHalos
    tic
    namestr = ['Test_Sky' num2str(i)];
    
    data = TestSky{i};%data of all testsky csv files
    
    [mat ~] = code001_20121202(data, 400, 0);
    %imwrite(scale255(mat), strcat(namestr, '.jpg'), 'jpg');

    tanforcematris{i} = mat;
    disp(i);
    toc
end

testskytanforce.matris = tanforcematris;
testskytanforce.nbin = 400;
save Test_Sky_tanforces.mat testskytanforce
clear tanforcematris


SingleHalosCenter(NumberOfSingleHalos) = 0;
for i = 2 : NumberOfSingleHalos
    mat = testskytanforce.matris{i};
    [a b] = max(max(mat));
    [c d] = max(mat(:, b));
    SingleHalosCenter(i, 1) = b*(4200/400);
    SingleHalosCenter(i, 2) = d*(4200/400);
end

save SingleHalosCenter.mat SingleHalosCenter

