function [ d ] = domains( image, range_sizes, l )

if nargin < 3
    l = 2;
end

d = {};
index = 1;

for size = range_sizes
    step = size / l;
    for i = 1:step:(length(image)-size)
        for j = 1:step:(length(image)-size)
            imm = image(i:i+size-1, j:j+size-1);
            if ~check_dup(imm, d);
                d(index) = {imm};
                index = index + 1;
                if mod(index, 1000) == 0
                    index
                end
            end
        end
    end
end


end

function [ found ] = check_dup(img, d)

found = false;

for i = 1:length(d)
   if length(img) ~= length(d{i})
       continue 
   end
   
   if img == d{i}
      found = true;
      return
   end
   
    
end

end

