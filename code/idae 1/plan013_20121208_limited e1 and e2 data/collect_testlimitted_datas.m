
load TestSky

limittedtestdata{300} = 0;
for i=1:120
    sky = TestSky{i};
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
    limittedtestdata{i} = skystars;
    clear sky;clear skystars;
end

save limittedtestdata_se_chaharom.mat limittedtestdata
