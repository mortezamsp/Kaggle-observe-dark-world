%%
%   reading a test-sky file and calcs halo center using gread benchmark
%   returns halo center
%
% input :
%             skydata : csvfile data
%                nbin : number of bins
% outputs :
%              cx, cy : center of halo
%
%%
function [mat] = vizualstars(skydata, imsize)

    mat(imsize, imsize) = 0;
    scale = 4200/imsize;
    
    for k = 1 : size(skydata, 1)
        x = skydata(k, 1);
        y = skydata(k, 2);
        e1 = 100 * (1 + skydata(k, 3));
        e2 = pi * skydata(k, 4);
        x2 = x + e1*sin(e2);
        y2 = y + e1*cos(e2);
        mat = drawline(mat, imsize, x/scale, y/scale, x2/scale, y2/scale);
    end

end%function

function im = drawline(im1, imsize, x1, y1, x2, y2)
    im = im1;
    m = (y2 - y1) / (x2 - x1);
    xinc = 1;
    if(x2 < x1)
        xinc = -1;
    end
    
    for i = x1 : xinc*0.01 : x2
        yr = max(1, min(imsize, uint32((i-x1)*m + y1)));
        xr = max(1, min(imsize, uint32(i)));
        im(xr, yr) = 1;
    end
end