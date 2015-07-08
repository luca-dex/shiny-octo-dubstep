function [ outputimg ] = decode_step( img )
 global encoding;
 
 outputimg = zeros(length(img));
 
 for i=1:length(encoding)
          
    x = encoding(i,1);
    y = encoding(i,2);
    sr = encoding(i,3);
    xd = encoding(i,4);
    yd = encoding(i,5);
    sd = encoding(i,6);
    r = encoding(i,7);
    s = encoding(i,8);
    o = encoding(i,9);
    
    if sd ~= 2*sr
        display '-----------------------------> PORCODIO';
    end
    
    block = single(img(xd:xd+sd-1, yd:yd+sd-1));
    switch r
        case 1
            block = block;
        case 2
            block = rot90(rot90(rot90(block)));
        case 3
            block = rot90(rot90(block));
        case 4
            block = rot90(block);
        case 5 
            block = flipud(block);
        case 6
            block = flipud(rot90(rot90(rot90((block)))));
        case 7
            block = flipud(rot90(rot90(block)));
        case 8
            block = flipud(rot90(block));
    end
    
    block = imresize(block, 0.5);
    block = block * s + o;
    
    outputimg(x:x+sr-1, y:y+sr-1) = uint8(block);
 
 end


end

