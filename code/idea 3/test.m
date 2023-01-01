

load TestSky

imsize = 900;
shc(120,2)=0;
for i=2:120
    tic
    [x y]=linemethod(TestSky{i}, imsize);
    shc(i,1)=x;
    shc(i,2)=y;
    disp(i);toc
end

for i=2:120
    shc(i,1)=shc(i,1)*4200/imsize;
    shc(i,2)=shc(i,2)*4200/imsize;
end

save shc_test_900_060.mat shc
