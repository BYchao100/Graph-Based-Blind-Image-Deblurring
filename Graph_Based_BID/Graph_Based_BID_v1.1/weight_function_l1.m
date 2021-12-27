function [ w ] = weight_function_l1( d )
% Compute weights of l1-Graph Laplacian
% Written by Yuanchao Bai

d=abs(d);
epsilon=0.01;
d(d<epsilon)=epsilon;
w=1./d;
end

