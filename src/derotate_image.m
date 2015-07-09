function [ outimg ] = derotate_image( img, ts )

if ts > 4
    img = flipud(img);
    ts = ts - 4;
end


switch ts
    case 1
        outimg = img;
        return;
    case 4
        outimg = rot90(img);
        return;
    case 3
        outimg = rot90(rot90(img));
        return
    case 2
        outimg = rot90(rot90(rot90(img)));
end


end

