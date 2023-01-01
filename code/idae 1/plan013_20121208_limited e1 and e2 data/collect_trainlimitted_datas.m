
load TrainingSky

limitteddata{300} = 0;
for i=1:300
    sky = TrainingSky{i};
    skystars(1, 4) = 0;
    indx=1;
    for j=1:size(sky, 1)
        if(sky(j, 3) > 0.75 || sky(j, 3) < -0.75)
            continue;
        end
        if(sky(j, 4) > 0.75 || sky(j, 4) < -0.75)
            continue;
        end
        skystars(indx, :) = sky(j, :);
        indx = indx + 1;
    end
    limitteddata{i} = skystars;
    clear sky;clear skystars;
end

save limitteddata_se_chaharom.mat limitteddata
