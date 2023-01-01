
load TrainingSky
load TrainingHalos

nbin = 100;

images{300} = 0;

for i = 2 : 300
    
    sky = TrainingSky{i};
    [mat1 x1 y1] = code001_20121209_e1(sky, nbin);
    [mat2 x2 y2] = code001_20121209_e2(sky, nbin);
    
    image(nbin, nbin, 3) = uint8(0);
    image(:, :, 1) = scale255(mat1);
    image(:, :, 2) = scale255(mat2);
    
    for j = 1 : TrainingHalos(i, 1)
        cx = max(1, min(nbin, uint32(floor(TrainingHalos(i, 2+j*2) / 4200 * nbin))));
        cy = max(1, min(nbin, uint32(floor(TrainingHalos(i, 3+j*2) / 4200 * nbin))));
    
        image = drawcross(image, cx,cy, 4, 1, 255,255,255);
    end
    image = drawcross(image, x1,y1, 4, 1, 0,0,0);
    image = drawcross(image, x2,y2, 4, 1, 0,0,0);
    
    images{i} = image;
    %imwrite(image,['train_sky' num2str(i) '.jpg'], 'jpg');
    clear image;disp(i);
end

save images_e1_e2.mat images
