function [ partial_enc ] = ...
    qtfunction( img, position, size, split_threshold, min_size, max_size, doms, min_rms )

global img_copy;

x = position(1);
y = position(2);

partial_enc = [];

if size/2 > max_size
    a = qtfunction(img, [x y], size/2, split_threshold, min_size, max_size, doms, min_rms);
    b = qtfunction(img, [x+size/2 y], size/2, split_threshold, min_size, max_size, doms, min_rms);
    c = qtfunction(img, [x y+size/2], size/2, split_threshold, min_size, max_size, doms, min_rms);
    d = qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold, min_size, max_size, doms, min_rms);
    partial_enc = [a; b; c; d;];
    return
end

rms = repmat(+Inf, [1 4]);
ts = zeros(1, 4);
doms_ind = zeros(1, 4);

for i = 1:length(doms)
    
    d = doms{i,1};
    
    if length(d) ~= size/2
        continue
    end
    
    % |1|2|
    % |3|4|
    
    % 1
    if rms(1) > min_rms
        [r, t] = sup_dist(img(x:(x + size/2 -1), y:(y + size/2 -1)), d);

        
        
        if r < rms(1)
            rms(1) = r;
            ts(1) = t;
            doms_ind(1) = i;
        end
    end
    
    % 2
    if rms(2) > min_rms
        [r, t] = sup_dist(img((x + size/2):(x+size-1), y:(y + size/2 -1)), d);
        
        
        if r < rms(2)
            rms(2) = r;
            ts(2) = t;
            doms_ind(2) = i;
        end
    end
    
    % 3
    if rms(3) > min_rms
        [r, t] = sup_dist(img(x:(x + size/2 - 1), (y + size/2):(y+size-1)), d);
        
        
        if r < rms(3)
            rms(3) = r;
            ts(3) = t;
            doms_ind(3) = i;
        end
    end
    
    % 4
    if rms(4) > min_rms
        [r, t] = sup_dist(img((x + size/2):(x+size-1) , (y + size/2):(y+size-1)) , d);
        
        if r < rms(4)
            rms(4) = r;
            ts(4) = t;
            doms_ind(4) = i;
        end
    end
    
    
end

if rms(1) > split_threshold && size/2 > min_size
    partial_enc = [partial_enc; qtfunction(img, [x y], size/2, split_threshold, min_size, max_size, doms, min_rms)];
else
    img1 = img(x:(x + size/2 -1), y:(y + size/2 -1));
    [s, o] = least_squared_params(img1, doms{doms_ind(1),1});
    partial_enc = [partial_enc; [x y size/2 doms{doms_ind(1),2} ts(1) s o]];
    sprintf('\tUP LEFT processed block (%d:%d), size = %d, rms = %d\n', x, y, size, rms(1))
end

if rms(2) > split_threshold && size/2 > min_size
    partial_enc = [partial_enc; qtfunction(img, [x+size/2 y], size/2, split_threshold, min_size, max_size, doms, min_rms)];
else
    img1 = img((x + size/2):(x+size-1), y:(y + size/2 -1));
    [s, o] = least_squared_params(img1, doms{doms_ind(2),1});
    partial_enc = [partial_enc; [x+size/2 y size/2 doms{doms_ind(2),2} ts(2) s o]];
    sprintf('\tUP RIGHT processed block (%d:%d), size = %d, rms = %d\n', x+size/2, y, size, rms(2))
end

if rms(3) > split_threshold && size/2 > min_size
    partial_enc = [partial_enc; qtfunction(img, [x y+size/2], size/2, split_threshold, min_size, max_size, doms, min_rms)];
else
    img1 = img(x:(x + size/2 - 1), (y + size/2):(y+size-1));
    [s, o] = least_squared_params(img1, doms{doms_ind(3),1});
    partial_enc = [partial_enc; [x y+size/2 size/2, doms{doms_ind(3),2} ts(3) s o]];
    sprintf('\tDOWN LEFT processed block (%d:%d), size = %d, rms = %d\n', x, y+size/2, size, rms(3))
end

if rms(4) > split_threshold && size/2 > min_size
    partial_enc = [partial_enc; qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold, min_size, max_size, doms, min_rms)];
else
    img1 = img((x + size/2):(x+size-1) , (y + size/2):(y+size-1));
    [s, o] = least_squared_params(img1, doms{doms_ind(4),1});
    partial_enc = [partial_enc; [x+size/2 y+size/2 size/2, doms{doms_ind(4),2} ts(4) s o]];
    sprintf('\tDOWN RIGHT processed block (%d:%d), size = %d, rms = %d\n', x+size/2, y+size/2, size, rms(4))
end

end



