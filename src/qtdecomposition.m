function [ ] = qtdecomposition( img )
global img_copy;
img_copy = img;
p = imshow(img, 'Border', 'tight');
drawnow;
qtfunction(img, [1, 1], length(img), 20, p);





end

