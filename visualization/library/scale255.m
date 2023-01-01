function newimage = scale255(image)
    maxv = max(max(max(image)));
    minv = min(min(min(image)));
    difv = maxv - minv;
    newimage = uint8((image - minv) .* (255 / difv));
end