function newimage = drawcross(im, cx, cy, len, border, r, g, b)

    if(size(im, 3) == 1)
        newimage(:,:,1) = im;
        newimage(:,:,2) = im;
        newimage(:,:,3) = im;
    else
        if(size(im, 3) > 1)
            newimage = im;
        end
    end
    
    cx = uint32(floor(cx));
    cy = uint32(floor(cy));
    
    for i = max(1,cx-len) : min(cx+len, size(im,1))
        for j = max(1,cy-border) : min(cy+border, size(im,2))
            newimage(i, j, 1) = r;
            newimage(i, j, 2) = g;
            newimage(i, j, 3) = b;
        end
    end
    for i = max(1,cy-len) : min(cy+len, size(im,2))
        for j = max(1,cx-border) : min(cx+border, size(im,1))
            newimage(j, i, 1) = r;
            newimage(j, i, 2) = g;
            newimage(j, i, 3) = b;
        end
    end

end
