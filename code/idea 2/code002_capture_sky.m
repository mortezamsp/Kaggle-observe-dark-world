%script to collect features about skies
%each bin's features contains state of e1 and e2 of starts in bin. e1 and e2 are bined into 8 bins
%bins captures are cascaded.
%

load TrainingSky.mat
load TrainingHalos.mat

%start cordination of convolving-window
si = 1;
sj = 1;

winsize = 400;
indxinc = winsize / 4;

indx = 0;
skyfeatures(indx+1, 17) = 0;

try
for S = 200 : 300
    tic
	skydata = TrainingSky{S};
	for i = 1 : indxinc : 4200
		for j = 1 : indxinc : 4200
			clear e1bins;e1bins(8) = 0;
			clear e2bins;e2bins(8) = 0;
			for k = 1: size(skydata, 1)
				if(skydata(k, 1)>i && skydata(k, 1)<i+winsize && skydata(k, 2)>j && skydata(k, 2)<j+winsize)
					e1 = skydata(k, 3);
                    e1indx = min(8, 5 + ceil(e1/0.25));
					e1bins(e1indx) = e1bins(e1indx) + 1;
					e2 = skydata(k, 4);
                    e2indx = min(8, 5 + ceil(e2/0.25));
					e2bins(e2indx) = e2bins(e2indx) + 1;
				end
            end
            indx = indx + 1;
			skyfeatures(indx, 1:8) = e1bins;
            skyfeatures(indx, 9:16) = e2bins;
            %mark as halo or not
            for k = 1 : TrainingHalos(S, 1)
                x = TrainingHalos(S, 2+2*k);
                if(x<=i || x>=i+winsize)
                    skyfeatures(indx, 17) = -1;
                    continue;
                end
                y = TrainingHalos(S, 3+2*k);
                if(y<=j || y>=j+winsize)
                    skyfeatures(indx, 17) = -1;
                    continue;
                end
                skyfeatures(indx, 17) = 1;
            end
		end
    end
    disp(['S = ' num2str(S) ', ' num2str(toc)]);
end
catch
    disp(S);disp(i);disp(j);disp(k);
end

save skyfeatures400.mat skyfeatures



p = skyfeatures(:, 1:16);
t = skyfeatures(:, 17);
net = newff(p', t', 3);
[net, tr] = train(net, p', t');

save net400
save tr400
