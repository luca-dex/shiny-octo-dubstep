imgd = ones(length(img)) * 150;
imshow(uint8(imgd));
waitforbuttonpress;

for i=1:15
    imgd = uint8(decode_step(imgd));
    imshow(uint8(imgd));
    display '-------';
    waitforbuttonpress;
end


