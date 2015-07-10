function [ d, d2 ] = domains( image, range_sizes, l )

if nargin < 3
    l = 2;
end

d = {1000,2};
dim = length(image);
index = 1;

range_sizes = sort(range_sizes, 'descend');

for size = range_sizes
    step = size / l;
    for i = 1:step:(dim-size)
        for j = 1:step:(dim-size)
            imm = image(i:i+size-1, j:j+size-1);
            if check_equals(d, imm, index-1)
                continue
            end
            d(index,1) = {imm};
            d(index,2) = {[i j size]};
            index = index + 1;
            if mod(index, 1000) == 0
                sprintf('%d', index)
            end
        end
    end
end

d2 = cell(length(d), 2);

for i=1:length(d2)
    d2(i, 2) = d(i, 2);
    d2(i, 1) = {scale_image(d{i, 1})};
end

sprintf('domain size: %d\n', index)

end

