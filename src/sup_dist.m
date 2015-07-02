function [ rms, transf, scal ] = sup_dist( img1, img2 )

scal = length(img1) / length(img2);

if length(img1) ~= length(img2)
   img2 = imresize(img2, [length(img1) length(img1)], 'nearest');
end

temp = img2;

rms_arr = zeros(1, 8);

rms_arr(1) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(2) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(3) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(4) = dist_sup(img1, temp);

temp = flipud(img2);
rms_arr(5) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(6) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(7) = dist_sup(img1, temp);

temp = rot90(temp);
rms_arr(8) = dist_sup(img1, temp);

transf = find(rms_arr - min(rms_arr) == 0);
transf = transf(1);
rms = rms_arr(transf);

end

function [ rms ] = dist_sup(img1, img2)
    rms = max(max(abs((img1 - img2) + (img2 - img1))));
end
