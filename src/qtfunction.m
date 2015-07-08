function [ ] = qtfunction( img, position, size, split_threshold, p )

global doms;
global encoding;
global img_copy;

max_size = 32;
min_size = 8;

x = position(1);
y = position(2);

sprintf('analyzing block (%d:%d, %d:%d)\n', x, x+size-1, y, y+size-1)

if size/2 > max_size
    qtfunction(img, [x y], size/2, split_threshold, p);
    qtfunction(img, [x+size/2 y], size/2, split_threshold, p);
    qtfunction(img, [x y+size/2], size/2, split_threshold, p);
    qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold, p);
    return
end

rms = repmat(+Inf, [1 4]);
ts = zeros(1, 4);
doms_ind = zeros(1, 4);

for i = 1:length(doms)
    
    d = doms{i,1};
    
    if length(d) ~= size
        continue
    end
    
    % |1|2|
    % |3|4|
    
    % 1
    if rms(1) > 0
        [r, t] = sup_dist(img(x:(x + size/2 -1), y:(y + size/2 -1)), d);

        if r < rms(1)
            rms(1) = r;
            ts(1) = t;
            doms_ind(1) = i;
        end
    end
    
    % 2
    if rms(2) > 0
        [r, t] = sup_dist(img((x + size/2):(x+size-1), y:(y + size/2 -1)), d);

        
        if r < rms(2)
            rms(2) = r;
            ts(2) = t;
            doms_ind(2) = i;
        end
    end
    
    % 3
    if rms(3) > 0
        [r, t] = sup_dist(img(x:(x + size/2 - 1), (y + size/2):(y+size-1)), d);
        

        if r < rms(3)
            rms(3) = r;
            ts(3) = t;
            doms_ind(3) = i;
        end
    end
    
    % 4
    if rms(4) > 0
        [r, t] = sup_dist(img((x + size/2):(x+size-1) , (y + size/2):(y+size-1)) , d);

        if r < rms(4)
            rms(4) = r;
            ts(4) = t;
            doms_ind(4) = i;
        end
    end
    
    
end

if rms(1) > split_threshold && size/2 > min_size
    qtfunction(img, [x y], size/2, split_threshold, p);
else
    img1 = img(x:(x + size/2 -1), y:(y + size/2 -1);
    [s, o] = least_squared_params(img1, d);
    encoding = [encoding; [x y size/2 doms{doms_ind(1),2} ts(1) s o]];
    img_copy(x:(x + size/2 -1), y:(y + size/2 -1)) = 1;
    sprintf('\tUP LEFT processed block (%d:%d), size = %d, rms = %d\n', x, y, size, rms(1))
end

if rms(2) > split_threshold && size/2 > min_size
    qtfunction(img, [x+size/2 y], size/2, split_threshold, p);
else
    img1 = img((x + size/2):(x+size-1), y:(y + size/2 -1));
    [s, o] = least_squared_params(img1, d);
    encoding = [encoding; [x+size/2 y size/2 doms{doms_ind(2),2} ts(2) s o]];
    img_copy((x + size/2):(x + size -1), y:(y + size/2 -1)) = 1;
    sprintf('\tUP RIGHT processed block (%d:%d), size = %d, rms = %d\n', x+size/2, y, size, rms(2))
end

if rms(3) > split_threshold && size/2 > min_size
    qtfunction(img, [x y+size/2], size/2, split_threshold, p);
else
    img1 = img(x:(x + size/2 - 1), (y + size/2):(y+size-1));
    [s, o] = least_squared_params(img1, d);
    encoding = [encoding; [x y+size/2 size/2, doms{doms_ind(3),2} ts(3) s o]];
    img_copy(x:(x + size/2 -1), (y + size/2):(y + size -1)) = 1;
    sprintf('\tDOWN LEFT processed block (%d:%d), size = %d, rms = %d\n', x, y+size/2, size, rms(3))
end

if rms(4) > split_threshold && size/2 > min_size
    qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold, p);
else
    img1 = img((x + size/2):(x+size-1) , (y + size/2):(y+size-1));
    [s, o] = least_squared_params(img1, d);
    encoding = [encoding; [x+size/2 y+size/2 size/2, doms{doms_ind(4),2} ts(4) s o]];
    img_copy((x + size/2):(x + size -1), (y + size/2):(y + size -1)) = 1;
    sprintf('\tDOWN RIGHT processed block (%d:%d), size = %d, rms = %d\n', x+size/2, y+size/2, size, rms(4))
end

set(p, 'CData', img_copy);
drawnow;

end

function [s, o] = least_squared_params(img1, img2)

if 2*length(img1) == length(img2)
    img2 = imresize(img2, 0.5, 'nearest');
else
    s = 0;
    o = 0;
    return
end
    

n = length(img1);
a = reshape(img1, [1, n*n]);
b = reshape(img2, [1, n*n]);

s = ( n * dot(a, b) - sum(a)*sum(b) ) / ( n * sum(a.^2) - sum(a)^2 );
o = ( sum(b) - s*sum(a) ) / n;

end

