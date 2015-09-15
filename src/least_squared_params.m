% Least Squared Params
% Authors: Luca De Sano, Alberto Donizetti
% Released under UNIMIAMIB License

function [s, o] = least_squared_params(img1, img2)

if length(img1) ~= length(img2)
    error('least_squared: ERROR!');
end
    
n = length(img1)^2;
a = single(reshape(img2, [1, n]));
b = single(reshape(img1, [1, n]));

s = ( n * dot(a, b) - sum(a)*sum(b) ) / ( n * sum(a.^2) - sum(a)^2 );
s = min(s, 1);
o = ( sum(b) - s*sum(a) ) / n;

end