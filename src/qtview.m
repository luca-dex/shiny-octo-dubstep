% Test viewer
% Authors: Luca De Sano, Alberto Donizetti
% Released under UNIMIAMIB License

I = imread('images/lena512.bmp');
S = qtdecomp(I, 0.3, [8, 32]);
blocks = repmat(uint8(0),size(S));

for dim = [512 256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(S==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,S,dim,values);
  end
end

blocks(end,1:end) = 1;
blocks(1:end,end) = 1;

imshow(I), figure, imshow(blocks,[])

clear I S blocks dim values numblocks;