function [ d, d2 ] = domains( image, range_sizes, l )

if nargin < 3
    l = 2;
end

d = {1000,2};
dim = length(image);
index = 1;
counter = 1;

range_sizes = sort(range_sizes, 'descend');

for size = range_sizes
    step = size / l;
    for i = 1:step:(dim-size)
        for j = 1:step:(dim-size)
            counter = counter + 1;
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

sprintf('real domain size: %d\n', counter-1)

sprintf('restricted domain size: %d\n', index-1)

d2 = {1000, 2};

index2 = 1;

for i=1:length(d)
    imres2 = scale_image(d{i, 1});
    if check_equals(d2, imres2, index2-1)
        continue;
    end
    d2(index2, 2) = d(i, 2);
    d2(index2, 1) = {imres2};
    index2 = index2 + 1;
    if mod(index2, 1000) == 0
        sprintf('%d', index2)
    end
end

sprintf('scaled domain size: %d\n', index2-1)



end

