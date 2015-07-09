function [ rms, transf ] = sup_dist( img1, img2 )

if length(img1) ~= length(img2)
    img2 = scale_image(img2);
end

rms_arr = zeros(1,8);

for i = 1:8
    rms_arr(i) = dsh(img1, rotate_image(img2, i));
end

transf = find(rms_arr - min(rms_arr) == 0, 1);
rms = rms_arr(transf);

end

function [ rms ] = dsh(img1, img2)

[s, o] = least_squared_params(img1, img2);

n = length(img1)^2;
a = single(reshape(img2, [1, n]));
b = single(reshape(img1, [1, n]));

rms = sqrt(( sum(b.^2) + s * (s*sum(a.^2) - 2*dot(a,b) + 2*o*sum(a)) + o*(n*o - 2*sum(b)) ) / n);
end
