function newimage = drawzoom(im, cx, cy, len, r, g, b)

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
    
    w = size(im,1);
    for i = max(1,cx-len) : min(cx+len, w)
        if(cy-len > 0)
            newimage(i, cy-len, 1) = r;
            newimage(i, cy-len, 2) = g;
            newimage(i, cy-len, 3) = b;
        end
        if(cy+len <= w)
            newimage(i, cy+len, 1) = r;
            newimage(i, cy+len, 2) = g;
            newimage(i, cy+len, 3) = b;
        end
        if(i~=cx && cy>0)
            newimage(i, cy, 1) = r;
            newimage(i, cy, 2) = g;
            newimage(i, cy, 3) = b;
        end
    end
    for i = max(1,cy-len) : min(cy+len, size(im,2))
        if(cx-len > 0)
            newimage(cx-len, i, 1) = r;
            newimage(cx-len, i, 2) = g;
            newimage(cx-len, i, 3) = b;
        end
        if(cy+len <= w)
            newimage(cx+len, i, 1) = r;
            newimage(cx+len, i, 2) = g;
            newimage(cx+len, i, 3) = b;
        end
        if(i~=cy && cx>0)
            newimage(cx, i ,1) = r;
            newimage(cx, i ,2) = g;
            newimage(cx, i ,3) = b;
        end
    end

end
