%code001_20121203_calccenters_script

clear all

load('TrainingHalos.mat')
load('SingleHalosCenter_trainingskies_bin400.mat')
load('Training_Sky_tanforces_bin400.mat')

binsize = 400;

%load image of tanforce
images = trainingskytanforce.matris;
for i = 2 : 100
    
    im = scale255(images{i});
    %im = im > max(max(im)) * 0.99;
    im = im == max(max(im));
    
    %show center of my calculate, by blue cross size 100
    x = uint32(SingleHalosCenter(i, 1) / (4200/binsize));
    y = uint32(SingleHalosCenter(i, 2) / (4200/binsize));
    im = drawcross(im, x,y, 10, 1, 0,0,255);
    
    %show center of greaded benchmark, by red cross size 100
    x = uint32(TrainingHalos(i, 4) / (4200/binsize));
    y = uint32(TrainingHalos(i, 5) / (4200/binsize));
    im = drawcross(im, x,y, 10, 1, 255,0,0);
    
    %save that
    imwrite(im, ['trainsky_centers_' num2str(i) '.jpg'], 'jpg');
end
