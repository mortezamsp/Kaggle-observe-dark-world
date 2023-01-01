%%
%   reading a test-sky file and calcs halo center using gread benchmark
%   returns probability of beaing halecenter
%
% input :
%             skydata : csvfile data
%                nbin : number of bins
%       calctrueimage : visualizes the sky
% outputs :
%                 mat : data of max halos
%           trueimage : true image of sky
% using :
%   -to use for visualization, set third parameter to 1.
%   -default for nbin is 50 and fo calctrueimage is 0,
%    so you can discard 2nd and 3rth paraneter and use just one parameter.
%
%%
function [mat trueimage] = code001_20121205_2(skydata, nbin, calctrueimage)

    if(nargin == 1)
        nbin = 50;
        calctrueimage = 0;
    end
    
    image_size = 4200;
    binwidth = double(image_size)/double(nbin);

    average_tan_force = double(zeros(nbin, nbin));    
    for i = 1 : nbin
        for j = 1 : nbin

			numberOfNearStars = 0;
             for k = 1 : size(skydata, 1)
             %for k = 1 : 80 : size(skydata, 1)%more efficeiant
                p = k;% + 1;
                x = skydata(p, 1);
                y = skydata(p, 2);
                e1 = skydata(p, 3);
                e2 = skydata(p, 4);

                x0 = i*binwidth + binwidth/2;
                y0 = j*binwidth + binwidth/2;

				%even more efficiant
				if(abs(x-x0)<binwidth && abs(y-y0)<binwidth)
					continue;
                end
				%else
				numberOfNearStars = numberOfNearStars + 1;
				
                angle_wrt_halo = atan((y-y0)/(x-x0));
                tangential_force = -(e1*cos(2.0*angle_wrt_halo)+e2*sin(2.0*angle_wrt_halo));

                average_tan_force(i, j) = average_tan_force(i, j) + tangential_force;
             end
             
			 %this condition is new in this version of code!!
			 average_tan_force(i, j) = average_tan_force(i, j) / numberOfNearStars;
        end
    end

    mat = average_tan_force;
    
    if(calctrueimage == 1)
        %visualizetanforce(average_tan_force, nbin, skydata);
        trueimage = visualizetanforce(average_tan_force, nbin);
    else
        trueimage = 0;
    end
    
end%function

