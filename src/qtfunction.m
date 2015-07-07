function [ ] = qtfunction( img, position, size, split_threshold )

global doms;
global encoding;

max_size = 32;
min_size = 8;

x = position(1);
y = position(2);

sprintf('analyzing block (%d:%d, %d:%d)\n', x, x+size-1, y, y+size-1)

if size/2 > max_size
    qtfunction(img, [x y], size/2, split_threshold);
    qtfunction(img, [x+size/2 y], size/2, split_threshold);
    qtfunction(img, [x y+size/2], size/2, split_threshold);
    qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold);
    return
end

rms = repmat(+Inf, [1 4]);
ts = zeros(1, 4);
doms_ind = zeros(1, 4);

for i = 1:length(doms)
    
    d = doms{i};
    
    if length(d) ~= size
        continue
    end
    
    % |1|2|
    % |3|4|
    
    % 1
    if rms(1) ~= 0
        [r, t] = sup_dist(img(x:(x + size/2 - 1), y:(y + size/2 -1)), d);

        if r < rms(1)
            rms(1) = r;
            ts(1) = t;
            doms_ind(1) = i;
        end
    end
    
    % 2
    if rms(2) ~= 0
        [r, t] = sup_dist(img((x + size/2):(x+size-1), y:(y + size/2 -1)), d);

        
        if r < rms(2)
            rms(2) = r;
            ts(2) = t;
            doms_ind(2) = i;
        end
    end
    
    % 3
    if rms(3) ~= 0
        [r, t] = sup_dist(img(x:(x + size/2 - 1), (y + size/2):(y+size-1)), d);
        

        if r < rms(3)
            rms(3) = r;
            ts(3) = t;
            doms_ind(3) = i;
        end
    end
    
    % 3
    if rms(4) ~= 0
        [r, t] = sup_dist(img((x + size/2):(x+size-1) , (y + size/2):(y+size-1)) , d);

        if r < rms(4)
            rms(4) = r;
            ts(4) = t;
            doms_ind(4) = i;
        end
    end
    
    
end

for i = 1:4
    if rms(i) > split_threshold && size/2 > min_size
        switch i
            case 1
                qtfunction(img, [x y], size/2, split_threshold);
            case 2
                qtfunction(img, [x+size/2 y], size/2, split_threshold);
            case 3
                qtfunction(img, [x y+size/2], size/2, split_threshold);
            case 4
                qtfunction(img, [x+size/2 y+size/2], size/2, split_threshold);
        end
    else
        switch i
            case 1
                encoding = [encoding; [x y size/2, doms_ind(i) ts(i)]];
                sprintf('\t\tprocessed block (%d:%d), size = %d\n', x, y, size)
            case 2
                encoding = [encoding; [x+size/2 y size/2, doms_ind(i) ts(i)]];
                sprintf('\t\tprocessed block (%d:%d), size = %d\n', x+size/2, y, size)
            case 3
                encoding = [encoding; [x y+size/2 size/2, doms_ind(i) ts(i)]];
                sprintf('\t\tprocessed block (%d:%d), size = %d\n', x, y+size/2, size)
            case 4
                encoding = [encoding; [x+size/2 y+size/2 size/2, doms_ind(i) ts(i)]];
                sprintf('\t\tprocessed block (%d:%d), size = %d\n', x+size/2, y+size/2, size)
        end

        return
    end
    
    
end




end

