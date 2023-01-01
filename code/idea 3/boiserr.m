function newshc = boiserr(shc, h)

    newshc = shc;
    
    for i = 1 : size(shc, 1)
        newshc(i, 1) = shc(i, 1) + mod(shc(i, 1), h) * rand()*100;
        newshc(i, 2) = shc(i, 2) + mod(shc(i, 2), h) * rand()*100;
    end

end
