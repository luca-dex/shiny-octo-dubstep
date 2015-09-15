% Rotate image
% Authors: Luca De Sano, Alberto Donizetti
% Released under UNIMIAMIB License

function [ outimg ] = rotate_image( img, ts )

if ts > 4
    img = flipud(img);
    ts = ts - 4;
end

switch ts
    case 1
        outimg = img;
    case 2
        outimg = rot90(img);
    case 3
        outimg = rot90(rot90(img));
    case 4
        outimg = rot90(rot90(rot90(img)));
end


end

