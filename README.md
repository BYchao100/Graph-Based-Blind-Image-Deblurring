# Graph-Based-Blind-Image-Deblurring

This code is the upgraded implementation of TIP paper "Graph-based Blind Image Deblurring from a Single Photograph".

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Matlab(>=R2015a)

## Running the tests

```
1. run graph_blind_main.m
2. select the blurred image
```

### Parameters

Users only need to tune ONE parameter. On line 21, estimated kernel size "k_estimate_size". 
* The estimated kernel size must be LARGER than the real kernel size (The default value is 69).
* In order to have the best performance, please set the value close to real kernel size or slightly larger.

## Deployment

Add additional notes about how to deploy this on a live system

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


