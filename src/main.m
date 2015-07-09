clear;
clear -global;

global doms;
global encoding;

i = imread('images/lena512.bmp');

dom_range = [8, 16, 32, 64];

doms = domains(i, dom_range, 1);

global img_copy;
img_copy = i;
p = imshow(i, 'Border', 'tight');
drawnow;

min = dom_range(1) / 2;
max = dom_range(length(dom_range)) / 2;

qtfunction(i, [1, 1], length(i), 20, p, min, max);


 
 