function newimage = drawrectangle(image, x, y, r, fillvalue)
    newimage = image;
    for i = max(1,x-r) : min(x+r, size(image,1))
        for j = max(1,y-r) : min(y+r, size(image,2))
            newimage(i, j) = fillvalue;
        end
    end
end