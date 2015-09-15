% Parameters and settings
% Authors: Luca De Sano, Alberto Donizetti
% Released under UNIMIAMIB License

clear;
clear -global;

global doms;
global doms2;
global encoding;

img = imread('images/hole.bmp');
dom_range = [16, 32, 64];
l = 2;
min_rms = 2;
max_rms = 15;
output = '../workspace/hole_16-32-64_0_20.mat';


[doms, doms2] = domains(img, dom_range, l);

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
    partial_enc = qtfunction(img, [x, y], length(img)/2, max_rms, min_range, max_range, doms2, min_rms);
    display '--------------------finito'
    parfor_enc = [parfor_enc ;partial_enc];
end

encoding = parfor_enc;

save(output)
