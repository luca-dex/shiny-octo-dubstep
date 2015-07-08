img = ones(length(i2)) * 150;

for i=1:15
    img = uint8(decode_step(img));
    imshow(uint8(ones(length(i2)))*255 - img);
    waitforbuttonpress;
end


