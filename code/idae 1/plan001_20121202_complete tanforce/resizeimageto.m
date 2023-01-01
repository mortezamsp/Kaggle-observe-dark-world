function matris = resizeimageto(tanforce, nbin, image_size)
    binwidth = double(image_size)/double(nbin);
    matris(image_size, image_size) = double(0);
    for i = 1 : nbin
        for j = 1 : nbin
            starti = uint32(max(1,(i-1)*binwidth));
            startj = uint32(max(1,(j-1)*binwidth));
            matris(starti:uint32(i*binwidth),...
                   startj:uint32(j*binwidth)) = tanforce(i, j);
        end
    end
end