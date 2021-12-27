function [ x_padding,padsize ] = G_padding( x,k,factor )
% Padding the input image for graph construction
% Written by Yuanchao Bai

padsize=size(k)*factor;
x_padding=padarray(x,padsize,'replicate','both');

end

