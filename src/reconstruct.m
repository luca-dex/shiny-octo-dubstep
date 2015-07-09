imgr = zeros(512);
for i=1:length(encoding)
    
    xr = encoding(i,1);
    yr = encoding(i,2);
    sr = encoding(i,3);
    
    xd = encoding(i,4);
    yd = encoding(i,5);
    sd = encoding(i,6);
    
    r = encoding(i,7);
    
    s = encoding(i,8);
    o = encoding(i,9);
    
    
    
    block = img(xd:xd+sd-1, yd:yd+sd-1);
    block = derotate_image(block, r);
    
    b = imresize(block, 0.5);
    imgr(xr:xr+sr-1, yr:yr+sr-1) = b;
end

imshow(uint8(imgr));