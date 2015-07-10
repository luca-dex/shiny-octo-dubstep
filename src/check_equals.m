function [ result ] = check_equals( list, matrix, index )
result = false;
for i=1:index
    element = list{i,1};
    if length(element) ~= length(matrix)
        continue;
    end
    if eq(element, matrix)
        result = true;
        return
    end
end


end

