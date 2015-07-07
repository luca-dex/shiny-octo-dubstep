function [ rms, transf, scal ] = sup_dist( img1, img2 )
    
scal = length(img1) / length(img2);

if length(img1) ~= length(img2)
   img2 = imresize(img2, scal, 'nearest');
end

temp = img2;

rms_arr = zeros(1, 8);

rms_arr(1) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(2) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(3) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(4) = dsh(img1, temp);

temp = flipud(img2);
rms_arr(5) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(6) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(7) = dsh(img1, temp);

temp = rot90(temp);
rms_arr(8) = dsh(img1, temp);

transf = find(rms_arr - min(rms_arr) == 0);
transf = transf(1);
rms = rms_arr(transf);
scal = scal*2;

end

function [ rms ] = dsh(img1, img2)
    rms = max(max(abs((img1 - img2) + (img2 - img1))));
end
