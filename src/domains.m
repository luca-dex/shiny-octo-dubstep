function [ d ] = domains( image, range_sizes, l )

if nargin < 3
    l = 2;
end

d = {};
dim = length(image);
index = 1;

for size = range_sizes
    step = size / l;
    for i = 1:step:(dim-size)
        for j = 1:step:(dim-size)
            imm = image(i:i+size-1, j:j+size-1);
            d(index) = {imm};
            index = index + 1;
        end
    end
end


end

