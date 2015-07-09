clear;
clear -global;

global doms;
global doms2;
global encoding;

img = imread('images/lena512.bmp');

dom_range = [8, 16, 32];

[doms, doms2] = domains(img, dom_range, 1);

global img_copy;
img_copy = img;
p = imshow(img, 'Border', 'tight');
drawnow;

min_range = dom_range(1) / 2;
max_range = dom_range(length(dom_range)) / 2;

qtfunction(img, [1, 1], length(img), 20, p, min_range, max_range);


 
 