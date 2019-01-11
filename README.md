# Graph-Based-Blind-Image-Deblurring

This code is the upgraded implementation of our TIP paper "Graph-based Blind Image Deblurring from a Single Photograph".

## Prerequisite

Matlab(>=R2015a)

## Running the tests

```
Step 1. run graph_blind_main.m
Step 2. select a blurred image
```

## Parameters

Users only need to tune *ONE* parameter. On line 21, the estimated kernel size ***k_estimate_size***. 
* The ***k_estimate_size*** must be *LARGER* than the real kernel size (The default value is 69).
* In order to have the best performance, please set the value close to real kernel size and slightly larger.

If you want to turn off the intermediate output, you can set *show_intermediate=false* on line 22.

## About noise

In order to be more robust with noise, we add several denoising modules beyond the paper.
* We embed a TV denoising to pre-process the input image. 
* We add a wavelet domain filtering for intermediate output kernels. 
* We add a mask to filter small/noisy gradient in the gradient domain.

More sophisticated denoising, such as BM3D, can be done by users in advance.

## About Non-blind image deblurring

After kernel estimation with the proposed algorithm, we use the state-of-the-art methods to do non-blind image deblurring.
Here, we provide users with [1] to do the following non-blind image deblurring process.
Users can also employ [2] or the non-blind deblurring method in [3], by themselves.

[1] D. Krishnan and R. Fergus, “Fast image deconvolution using hyperlaplacian priors,” in Proceedings of Neural Information Processing Systems, 2009, Conference Proceedings, pp. 1033–1041.

[2] D. Zoran and Y. Weiss, “From learning models of natural image patches to whole image restoration,” in Proceedings of IEEE International Conference on Computer Vision, 2011, Conference Proceedings, pp. 479–486.

[3] J. Pan, D. Sun, H. Pfister, and M.-H. Yang, “Blind image deblurring using dark channel prior,” in Proceedings of IEEE Conference on Computer Vision and Pattern Recognition, June 2016.

## Citation

```
@ARTICLE{GraphBID, 
author={Y. Bai and G. Cheung and X. Liu and W. Gao}, 
journal={IEEE Transactions on Image Processing}, 
title={Graph-Based Blind Image Deblurring From a Single Photograph}, 
year={2019}, 
volume={28}, 
number={3}, 
pages={1404-1418}, 
doi={10.1109/TIP.2018.2874290}, 
ISSN={1057-7149}, 
month={March},}
```