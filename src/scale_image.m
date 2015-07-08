function [ outimg ] = scale_image( image )

    n = length(image)/2;
    outimg = zeros(n);
    
    for i=1:n
        for j=1:n
            outimg(i,j) = uint8(sum(sum(image(2*i-1:2*i,2*j-1:2*j)))/4);
        end
    end


end

