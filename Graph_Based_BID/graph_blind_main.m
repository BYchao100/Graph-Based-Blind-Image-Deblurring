clear;
close all;

addpath(genpath('.\Graph_Based_BID_p1.1'));

%% Blurry Input
[img_name, img_path]=uigetfile('*.*');
I=imread(fullfile(img_path, img_name));

if numel(size(I))>2
    Y_b=im2double(rgb2gray(I));
else
    Y_b=im2double(I);
end

figure(2);
imshow(Y_b);
title('Blurry Image');

%% Blind image deblurring
k_estimate_size=69; % set approximate kernel size
show_intermediate=true; % show intermediate output or not

border=20;% cut boundaries of the input blurry image (default border length: 20) 
tic;
[ k_estimate,Y_intermediate ] = bid_rgtv_c2f_cg( Y_b(border+1:end-border,border+1:end-border),k_estimate_size,show_intermediate );
t=toc;
fprintf('Grpah based Blind Deblurring Running Time:%f s\n',t);

figure(3);
imshow(k_estimate,[]);
title('Estimated kernel');
%% Fast Hyper Laplacian Priors non-blind deblurring
I_b=im2double(I);
I_FHLP=I_b;
I_blur=I_b;
tic;
if numel(size(I_FHLP))>2
    for i=1:3
        [ I_FHLP(:,:,i) ]=Deconvolution_FHLP(I_blur(:,:,i),k_estimate);
    end
else
    [ I_FHLP ]=Deconvolution_FHLP(I_blur,k_estimate);   
end
t=toc;
fprintf('FHLP Run Time: %f s\n',t);
figure(7);
imshow(I_FHLP);
title('Fast Image Deconvolution Using Hyper Laplacian Priors');
drawnow
imwrite(I_FHLP,'restored_image_FHLP.jpg');
%% Write Kernel in an image
k_out=k_rescale(k_estimate);
imwrite(k_out,'restored_kernel.jpg');