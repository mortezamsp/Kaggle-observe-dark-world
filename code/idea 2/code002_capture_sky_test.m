%script to collect features about skies
%each bin's features contains state of e1 and e2 of starts in bin. e1 and e2 are bined into 8 bins
%bins captures are cascaded.
%

load TrainingSky.mat

%start cordination of convolving-window
si = 1;
sj = 1;

winsize = 400;
indxinc = winsize / 4;

indx = 0;
testskyfeatures(indx+1, 16) = 0;

%result of net simulation for test skies
testskysim{120} = 0;

%load net

try
for S = 200 : 300
    tic
	skydata = TrainingSky{S};
    skysim(4200/indxinc, 4200/indxinc) = 0;
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
            ebins = [e1bins e2bins];
            ishalo = sim(net, ebins');
            skysim(ceil(i/indxinc), ceil(j/indxinc)) = ishalo;
        end
    end
    testskysim{S} = skysim;
    clear skysim;
    disp(['S = ' num2str(S) ', ' num2str(toc)]);
end
catch
    disp(S);disp(i);disp(j);disp(k);disp(err);
end

save testskysim.mat testskysim

