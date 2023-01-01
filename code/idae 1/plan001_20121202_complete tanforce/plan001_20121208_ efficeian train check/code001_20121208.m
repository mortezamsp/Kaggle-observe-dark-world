%
%   reading a test-sky file and calcs halo center using gread benchmark
%   returns probability of beaing halecenter
%
% input :
%             skydata : csvfile data
%                nbin : number of bins
% outputs :
%              cx ,cy : center of halo
% using :
%   -to use for visualization, set third parameter to 1.
%   -default for nbin is 50 and fo calctrueimage is 0,
%    so you can discard 2nd and 3rth paraneter and use just one parameter.
%
%
function [maxx maxy] = code001_20121208(skydata, nbin)

    maxx = 0;
    maxy = 0;
    maxv = -Inf;
    
    if(nargin == 1)
        nbin = 50;
    end
    
    image_size = 4200;
    binwidth = double(image_size)/double(nbin);

    for i = 1 : nbin
        for j = 1 : nbin

             x0 = i*binwidth + binwidth/2;
             y0 = j*binwidth + binwidth/2;
             
             sumtanforce = 0;
             for k = 1 : size(skydata, 1)
                p = k;% + 1;
                x = skydata(p, 1);
                y = skydata(p, 2);
                e1 = skydata(p, 3);
                e2 = skydata(p, 4);

                angle_wrt_halo = atan((y-y0)/(x-x0));
                tangential_force = -(e1*cos(2.0*angle_wrt_halo)+e2*sin(2.0*angle_wrt_halo));

                sumtanforce = sumtanforce + tangential_force;
             end
             
             if(sumtanforce > maxv)
                 maxv = sumtanforce;
                 maxx = i*binwidth + binwidth/2;
                 maxy = j*binwidth + binwidth/2;
             end
             
        end
    end

end%function

