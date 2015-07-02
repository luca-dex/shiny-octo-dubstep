function [ d_index, transf, scale ] = encode_range( range, domains )

min_rms = +Inf;
index = 1;

for d = domains
    [rms, transf_t, scale_t] = sup_dist(range, cell2mat(d));
    if rms < min_rms
        min_rms = rms;
        d_index = index;
        transf = transf_t;
        scale = scale_t;
        min_rms
    end
    index = index + 1;
    if mod(index, 1000) == 0
        index
    end
    
    if min_rms == 0 
        return
    end
    
end


end

