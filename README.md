# Graph-Based-Blind-Image-Deblurring

This code is the upgraded implementation of our TIP paper "Graph-based Blind Image Deblurring from a Single Photograph".

## Prerequisite

Matlab(>=R2015a)

## Running the tests

```
1. run graph_blind_main.m
2. select the blurred image
```

## Parameters

Users only need to tune *ONE* parameter. On line 21, the estimated kernel size ***k_estimate_size***. 
* The ***k_estimate_size*** must be LARGER than the real kernel size (The default value is 69).
* In order to have the best performance, please set the value close to real kernel size or slightly larger.

## To be robust with noise

In order to be more robust with noise, we add several denoising modules beyond the paper.
* We embed a TV denoising to pre-process the input image. 
* We add a wavelet thresholding for intermediate output kernels. 
* We add a mask to filter small/noisy gradient in the gradient domain.

More sophisticated denoising can be done by users before running the blind deblurring, such as BM3D.

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


