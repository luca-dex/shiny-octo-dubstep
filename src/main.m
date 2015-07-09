clear;
clear -global;

global doms;
global encoding;

img = imread('images/lena512.bmp');

dom_range = [16, 32, 64];

doms = domains(img, dom_range, 1);

global img_copy;
img_copy = img;
p = imshow(img, 'Border', 'tight');
drawnow;

min_range = dom_range(1) / 2;
max_range = dom_range(length(dom_range)) / 2;

qtfunction(img, [1, 1], length(img), 10, p, min_range, max_range);


 
 