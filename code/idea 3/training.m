

load TrainingSky

imsize = 950;
shc(100,2)=0;
for i=2:100
    tic
    [x y]=linemethod(TrainingSky{i}, imsize);
    shc(i,1)=x;
    shc(i,2)=y;
    disp(i);toc
end

for i=1:100
    shc(i,1)=shc(i,1)*4200/imsize;
    shc(i,2)=shc(i,2)*4200/imsize;
end

load TrainingHalos
err=TrainingHalos(1:100,4:5)-shc;
err(1,:)=0;
uint32(sum(sum(abs(err)))/200)
x=0;for i=41:100;x=x+power(power(err(i,1),2)+power(err(i,2),2),0.5);end;uint32(x/100)

save shc_950_060.mat shc
save err_950_060.mat err
