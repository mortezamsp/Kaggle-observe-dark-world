
load TrainingSky
load TrainingHalos
load Training_Sky_tanforces_bin400

images{300} = 0;
for i = 2 : 300
    
    sv(400, 400, 3) = uint8(0);
    
    %for i=101:300, which their tanfmatris data are NOT made before.
    if( i > 100)
        tanf = uint8(scale255(code001_20121202(TrainingSky{i}, 400, 0)));
    else
    %for i=2:100, which their tanfmatris data are made before.
        tanf = uint8(scale255(trainingskytanforce.matris{i}) / 2);
    end
    
    sky = TrainingSky{i};
    svs = vizualstars(sky, 400) * 255;
    
    tanf(svs == 255) = 255;
    sv(:, :, 3) = tanf;
    sv(:, :, 2) = svs;
    sv(:, :, 1) = svs;
    
    for j = 1 : TrainingHalos(i, 1)
        cx = max(1, min(400, uint32(floor(TrainingHalos(i, 2+j*2) / 4200 * 400))));
        cy = max(1, min(400, uint32(floor(TrainingHalos(i, 3+j*2) / 4200 * 400))));
        sv = drawcross(sv, cx, cy, 4, 1, 255,255,0);
    end
    
    images{i} = sv;
    imwrite(sv, ['visualstars_' num2str(i) '.jpg'], 'jpg');
    clear sky;clear sv;
    disp(i);
end
save training_visualstars.mat images
clear images
