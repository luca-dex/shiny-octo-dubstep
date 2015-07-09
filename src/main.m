clear;
clear -global;

global doms;
global doms2;
global encoding;

img = imread('images/FullMoon2010.bmp');

dom_range = [8, 16, 32];

[doms, doms2] = domains(img, dom_range, 1);

min_range = dom_range(1) / 2;
max_range = dom_range(length(dom_range)) / 2;

parpool(4);

parfor_enc = [];


parfor i=1:4
    x = 0;
    y = 0;
    switch i
        case 1
            x = 1;
            y = 1;
        case 2
            x = 1;
            y = length(img) / 2 + 1;
        case 3
            x = length(img) / 2 + 1;
            y = 1;
        case 4
            x = length(img) / 2 + 1;
            y = length(img) / 2 + 1;
    end
    partial_enc = qtfunction(img, [x, y], length(img)/2, 10, min_range, max_range, doms2);
    display '--------------------finito';
    parfor_enc = [parfor_enc ;partial_enc];
end

encoding = parfor_enc;



 
 