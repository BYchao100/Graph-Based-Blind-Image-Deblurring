function [ x ] = Deconvolution_FHLP( y,kernel )
% Fast Image Deconvolution Using Hyper Laplacian Priors (NIPS 2009)
% Authors: Dilip Krishnan, Rob Fregus

kernel(kernel==0)=1e-10;
kernel=kernel/sum(kernel(:));

lambda = 2e3;
alpha = 0.5;

ks = floor((size(kernel, 1) - 1)/2);

% edgetaper to better handle circular boundary conditions
y = padarray(y, [1 1]*ks, 'replicate', 'both');
for a=1:4
  y = edgetaper(y, kernel);
end

% Check if Eero Simoncell's function exists
% if (exist('pointOp') ~= 3) 
%   fprintf('WARNING: Will use slower interp1 for LUT interpolations. \nFor speed please see comments at the top of fast_deconv.m\n'); 
% end;

clear persistent;
% snr_blur = snr(y, ks, yorig);
% tic;
[x] = fast_deconv(y, kernel, lambda, alpha);
% timetaken = toc;
% snr_recon = snr(x, ks);

% remove padding
x = x(ks+1:end-ks, ks+1:end-ks);

end

