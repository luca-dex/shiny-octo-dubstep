function [ d ] = domains( image, range_sizes, l )

if nargin < 3
    l = 2;
end

d = {1000,2};
dim = length(image);
index = 1;

for size = range_sizes
    step = size / l;
    for i = 1:step:(dim-size)
        for j = 1:step:(dim-size)
            imm = image(i:i+size-1, j:j+size-1);
            d(index,1) = {imm};
            d(index,2) = {[i j size]};
            index = index + 1;
        end
    end
end


end

