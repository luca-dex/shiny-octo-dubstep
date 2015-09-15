% A single decode step
% Authors: Luca De Sano, Alberto Donizetti
% Released under UNIMIAMIB License

function [ outputimg ] = decode_step( img )
global encoding;

outputimg = zeros(length(img));

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
    
    if sd ~= 2*sr
        display '-----------------------------> ERROR!';
    end
    
    block = single(img(xd:xd+sd-1, yd:yd+sd-1));
    block = derotate_image(block, r);
    
    block = imresize(block, 0.5);
    block = block * s + o;
   
    
    outputimg(xr:xr+sr-1, yr:yr+sr-1) = uint8(block);
    
end


end

