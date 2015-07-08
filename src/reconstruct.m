ir = zeros(256);
for i=1:length(encoding)
    temp = encoding(i,:);
    x = temp(1);
    y = temp(2);
    s = temp(3);
    id = temp(4);
    r = temp(5);
    
    block = doms{id,1};
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
    
    b = imresize(block, 0.5);
    ir(x:x+s-1, y:y+s-1) = b;
end

ir = uint8(ir);