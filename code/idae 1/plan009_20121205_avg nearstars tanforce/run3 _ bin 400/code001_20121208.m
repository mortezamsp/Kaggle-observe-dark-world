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
				
			numberOfNearStars = 0;
			sumtanforce = 0;
            for k = 1 : size(skydata, 1)
				x = skydata(k, 1);
				y = skydata(k, 2);
				e1 = skydata(k, 3);
				e2 = skydata(k, 4);

				%even more efficiant
				if(abs(x-x0)<binwidth && abs(y-y0)<binwidth)
					continue;
				end
				%else
				numberOfNearStars = numberOfNearStars + 1;
				
                angle_wrt_halo = atan((y-y0)/(x-x0));
                tangential_force = -(e1*cos(2.0*angle_wrt_halo)+e2*sin(2.0*angle_wrt_halo));

                sumtanforce = sumtanforce + tangential_force;
            end
             
			%this condition is new in this version of code!!
			sumtanforce = sumtanforce / numberOfNearStars;
			
			if(sumtanforce > maxv)
				maxv = sumtanforce;
				maxx = i*binwidth + binwidth/2;
				maxy = j*binwidth + binwidth/2;
			end
        end
    end

end%function

