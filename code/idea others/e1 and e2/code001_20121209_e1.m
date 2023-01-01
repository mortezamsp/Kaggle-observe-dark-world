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
function [mat maxx maxy] = code001_20121209_e1(skydata, nbin)

	maxx = 0;
	maxy = 0;
	maxv = -Inf;
	
    if(nargin == 1)
        nbin = 50;
    end
    
    image_size = 4200;
    binwidth = double(image_size)/double(nbin);
    mat(nbin, nbin) = 0;
    
    for i = 1 : nbin
        for j = 1 : nbin

            x0 = i*binwidth + binwidth/2;
            y0 = j*binwidth + binwidth/2;
				
			sumtanforce = 0;
            for k = 1 : size(skydata, 1)
				x = skydata(k, 1);
				y = skydata(k, 2);
				e1 = skydata(k, 3);

                angle_wrt_halo = atan((y-y0)/(x-x0));
                tangential_force = -e1*cos(2.0*angle_wrt_halo);

                sumtanforce = sumtanforce + tangential_force;
            end
            mat(i, j) = sumtanforce;
            
			if(sumtanforce > maxv)
				maxv = sumtanforce;
				maxx = i*binwidth + binwidth/2;
				maxy = j*binwidth + binwidth/2;
			end
        end
    end

end%function

