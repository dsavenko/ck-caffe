# Collective Knowledge repository for collaboratively optimising Caffe-based designs

[![logo](https://github.com/ctuning/ck-guide-images/blob/master/logo-powered-by-ck.png)](http://cKnowledge.org)
[![logo](https://github.com/ctuning/ck-guide-images/blob/master/logo-validated-by-the-community-simple.png)](http://cTuning.org)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

## Introduction

[CK-Caffe](https://github.com/dividiti/ck-caffe) is an open framework for
collaborative and reproducible optimisation of convolutional neural networks.
It's based on the [Caffe](http://caffe.berkeleyvision.org) framework from the
Berkeley Vision and Learning Center ([BVLC](http://bvlc.eecs.berkeley.edu)) and
the [Collective Knowledge](http://cknowledge.org) framework for customizable
cross-platform builds and experimental workflows with JSON API from the 
[cTuning Foundation](http://ctuning.org) (see CK intro for more details: [1](https://arxiv.org/abs/1506.06256),
[2](https://www.researchgate.net/publication/304010295_Collective_Knowledge_Towards_RD_Sustainability) ). 
In essence, CK-Caffe is an open-source suite of convenient wrappers and workflows with unified 
JSON API for simple and customized building, evaluation and multi-objective optimisation 
of various Caffe implementations (CPU, CUDA, OpenCL) across diverse platforms
from mobile devices and IoT to supercomputers.

As outlined in our [vision](http://dx.doi.org/10.1145/2909437.2909449), 
we invite the community to collaboratively design and optimize convolutional
neural networks to meet the performance, accuracy and cost requirements for
deployment on a range of form factors - from sensors to self-driving cars. To
this end, CK-Caffe leverages the key capabilities of CK to crowdsource
experimentation across diverse platforms, CNN designs, optimization
options, and so on; exchange experimental data in a flexible JSON-based format;
and apply leading-edge predictive analytics to extract valuable insights from
the experimental data.

See [cKnowledge.org/ai](http://cKnowledge.org/ai), [shared optimization statistics](http://cKnowledge.org/repo) 
and [online demo of CK AI API with self-optimizing DNN](http://cKnowledge.org/ai/ck-api-demo) for more details.

## Authors/contributors

* Anton Lokhmotov, [dividiti](http://dividiti.com)
* Unmesh Bordoloi, [General Motors](http://gm.com)
* Grigori Fursin, [dividiti](http://dividiti.com) / [cTuning foundation](http://ctuning.org)

## Quick installation on Ubuntu

Please refer to our [Installation Guide](https://github.com/dividiti/ck-caffe/wiki/Installation) for detailed instructions for Ubuntu, Gentoo, Yocto, RedHat, CentOS, Windows and Android.

### Installing general dependencies

```
$ sudo apt install coreutils \
                   build-essential \
                   make \
                   cmake \
                   wget \
                   git \
                   python \
                   python-pip
```

### Installing Caffe dependencies
```
$ sudo apt install libboost-all-dev \
                   libgflags-dev \
                   libgoogle-glog-dev \
                   libhdf5-serial-dev \
                   liblmdb-dev \
                   libleveldb-dev \
                   libprotobuf-dev \
                   protobuf-compiler \
                   libsnappy-dev \
                   libopencv-dev
$ sudo pip install protobuf
```

### Installing CK

```
$ sudo pip install ck
$ ck version
```

### Installing CK-Caffe repository

```
$ ck pull repo:ck-caffe --url=https://github.com/dividiti/ck-caffe
```

### Building Caffe and all dependencies via CK

The first time you run caffe benchmark, CK will 
build and install all missing dependencies for your machine,
download required data sets and will start benchmark:

```
$ ck run program:caffe
```

### Testing installation via image classification

```
 $ ck compile program:caffe-classification --speed
 $ ck run program:caffe-classification
```

Note, that you will be asked to select a jpeg image from available CK data sets.
We added standard demo images (cat.jpg, catgrey.jpg, fish-bike.jpg, computer_mouse.jpg)
to the ['ctuning-datasets-min' repository](https://github.com/ctuning/ctuning-datasets-min).

You can list them via
```
 $ ck pull repo:ctuning-datasets-min
 $ ck search dataset --tags=dnn
```

### Participating in collaborative evaluation and optimization of various Caffe engines and models (on-going crowd-benchmarking)
It is now possible to participate in crowd-benchmarking of Caffe via
```
$ ck crowdbench caffe --user={your email or ID to acknowledge contributions} --env.CK_CAFFE_BATCH_SIZE=5
```

During collaborative benchmarking, you can select various engines (will be build on your machine) 
and models for evaluation.

You can also manually install additional flavours of Caffe engines across diverse hardware 
and OS (Linux/Windows/Android on odroid, RPi, ARM, Intel, AMD, NVIDIA, etc) 
as described [here](https://github.com/dividiti/ck-caffe/wiki/Installation).

You can also install extra models as following:
```
 $ ck list package --tags=caffemodel
 $ ck install package:{name of above packages}
```

You can even evaluate DNN engines on Android mobile devices connected via adb to your host machine via:

```
$ ck crowdbench caffe --target_os=android21-arm64 --env.CK_CAFFE_BATCH_SIZE=1
```

Feel free to try different batch sizes by changing command line option --env.CK_CAFFE_BATCH_SIZE.

You can crowd-benchmark Caffe on Windows without re-compilation, 
i.e. using Caffe CPU or OpenCL binaries pre-built by the CK. 
You should install such binaries as following:

```
 $ ck install package:lib-caffe-bvlc-master-cpu-bin-win
```
or
```
 $ ck install package:lib-caffe-bvlc-opencl-libdnn-viennacl-bin-win
```

You can also use this [Android app](https://play.google.com/store/apps/details?id=openscience.crowdsource.video.experiments)
to crowdsource benchmarking of ARM-based Caffe libraries for image recognition.

You can see continuously aggregated results in the 
[public Collective Knowledge repository](http://cknowledge.org/repo/web.php?native_action=show&native_module_uoa=program.optimization&scenario=1eb2f50d4620903e).

If you forget this link, you can open this website from command line:
```
 $ ck browse experiment.bench.caffe
```

### Creating dataset subsets

The ILSVRC2012 validation dataset contains 50K images. For quick experiments,
you can create a subset of this dataset, as follows. Run:

```
$ ck install package:imagenet-2012-val-lmdb-256
```

When prompted, enter the number of images to convert to LMDB, say, `N` = 100.
The first `N` images will be taken.


### Customizing caffe benchmarking via CK command line

You can customize various Caffe parameters such as batch size and iterations via CK command line:

```
$ ck run program:caffe --env.CK_CAFFE_BATCH_SIZE=1 --env.CK_CAFFE_ITERATIONS=10
```

### Installing CK on Windows, Android and various flavours of Linux

You can find details about CK-Caffe installation for Windows, various flavours 
of Linux and Android [here](http://github.com/dividiti/ck-caffe/wiki/Installation).

## Online demo of a unified CK-AI API 

* [Simple demo](http://cknowledge.org/repo/web.php?template=ck-ai-basic) to classify images with
continuous optimization of DNN engines underneath, sharing of mispredictions and creation of a community training set;
and to predict compiler optimizations based on program features.

## Benchmarking results

### Compare accuracy of 4 models

In this [Jupyter
notebook](https://github.com/dividiti/ck-caffe/blob/master/script/explore-accuracy/explore_accuracy.20160808.ipynb),
we compare the Top-1 and Top-5 accuracy of 4 models:

- [AlexNet](https://github.com/BVLC/caffe/tree/master/models/bvlc_alexnet)
- [SqueezeNet 1.0](https://github.com/DeepScale/SqueezeNet/tree/master/SqueezeNet_v1.0)
- [SqueezeNet 1.1](https://github.com/DeepScale/SqueezeNet/tree/master/SqueezeNet_v1.1)
- [GoogleNet](https://github.com/BVLC/caffe/tree/master/models/bvlc_googlenet)

on the [Imagenet validation set](http://academictorrents.com/details/5d6d0df7ed81efd49ca99ea4737e0ae5e3a5f2e5) (50,000 images).

We have thus independently verified that on this data set [SqueezeNet](https://arxiv.org/abs/1602.07360) matches (and even slightly exceeds) the accuracy of [AlexNet](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf).

The experimental data is stored in the main CK-Caffe repository under '[experiment](https://github.com/dividiti/ck-caffe/tree/master/experiment)'.

### Compare performance across models and configurations

We have performed several performance analysis studies across a range of platforms. The following public results are available:

- [NVIDIA TX1](https://github.com/dividiti/ck-caffe-nvidia-tx1) ([view on github.com](https://github.com/dividiti/ck-caffe-nvidia-tx1/blob/master/script/caffe-tensorrt/ck-caffe-nvidia-tx1-with-tensorrt.20170429.ipynb); [view on nbviewer.jupyter.org](https://nbviewer.jupyter.org/github/dividiti/ck-caffe-nvidia-tx1/blob/master/script/caffe-tensorrt/ck-caffe-nvidia-tx1-with-tensorrt.20170429.ipynb?raw)): 4 models, 6 Caffe configs + 2 TensorRT 1.0 EA configs. **NB:** The Caffe results are released with approval from General Motors. The TensorRT 1.0 EA results are obtained with [CK-TensorRT](https://github.com/dividiti/ck-tensorrt) and released with approval from General Motors and NVIDIA.

- [NVIDIA GTX1080](https://github.com/dividiti/ck-caffe-nvidia-gtx1080): 4 models, 14 configs. **NB:** The Caffe results are released with approval from General Motors. 

- [Samsung Chromebook 2](http://www.samsung.com/us/computing/chromebooks/under-12/samsung-chromebook-2-11-6-xe503c12-k01us/) ([view on github.com](https://github.com/dividiti/ck-caffe-explore-batch-size-chromebook2/blob/master/script/compare-time-fw/compare_time_fw.20160809.ipynb); [view on nbviewer.jupyter.org](https://nbviewer.jupyter.org/github/dividiti/ck-caffe-explore-batch-size-chromebook2/blob/master/script/compare-time-fw/compare_time_fw.20160809.ipynb?raw)): 4 models, 4 configs.

## Next steps

CK-Caffe is part of an ambitious long-term and community-driven 
project to enable collaborative and systematic optimization 
of realistic workloads across diverse hardware 
in terms of performance, energy usage, accuracy, reliability,
hardware price and other costs
([ARM TechCon'16 talk](http://schedule.armtechcon.com/session/know-your-workloads-design-more-efficient-systems), 
[ARM TechCon'16 demo](https://github.com/ctuning/ck/wiki/Demo-ARM-TechCon'16), 
[DATE'16](http://tinyurl.com/zyupd5v), 
[CPC'15](http://arxiv.org/abs/1506.06256)).

We are working with the community to unify and crowdsource performance analysis 
and tuning of various DNN frameworks (or any realistic workload) 
using Collective Knowledge Technology:
* [CK-TensorFlow](https://github.com/dividiti/ck-tensorflow)
* [CK-Caffe2](https://github.com/ctuning/ck-caffe2)
* [CK-TinyDNN](https://github.com/ctuning/ck-tiny-dnn)
* [Android app for DNN crowd-benchmarking and crowd-tuning](https://play.google.com/store/apps/details?id=openscience.crowdsource.video.experiments)
* [CK-powered ARM workload automation](https://github.com/ctuning/ck-wa)

We continue gradually exposing various design and optimization
choices including full parameterization of existing models.

## Open R&D challenges

We use crowd-benchmarking and crowd-tuning of such realistic workloads across diverse hardware for 
[open academic and industrial R&D challenges](https://github.com/ctuning/ck/wiki/Research-and-development-challenges.mediawiki) - 
join this community effort!

## Related Publications with long term vision

```
@inproceedings{Lokhmotov:2016:OCN:2909437.2909449,
 author = {Lokhmotov, Anton and Fursin, Grigori},
 title = {Optimizing Convolutional Neural Networks on Embedded Platforms with OpenCL},
 booktitle = {Proceedings of the 4th International Workshop on OpenCL},
 series = {IWOCL '16},
 year = {2016},
 location = {Vienna, Austria},
 url = {http://doi.acm.org/10.1145/2909437.2909449},
 acmid = {2909449},
 publisher = {ACM},
 address = {New York, NY, USA},
 keywords = {Convolutional neural networks, OpenCL, collaborative optimization, deep learning, optimization knowledge repository},
} 

@inproceedings{ck-date16,
    title = {{Collective Knowledge}: towards {R\&D} sustainability},
    author = {Fursin, Grigori and Lokhmotov, Anton and Plowman, Ed},
    booktitle = {Proceedings of the Conference on Design, Automation and Test in Europe (DATE'16)},
    year = {2016},
    month = {March},
    url = {https://www.researchgate.net/publication/304010295_Collective_Knowledge_Towards_RD_Sustainability}
}
```

* <a href="https://github.com/ctuning/ck/wiki/Publications">All related references with BibTex</a>

## Testimonials and awards

* 2015: ARM and the cTuning foundation use CK to accelerate computer engineering: [HiPEAC Info'45 page 17](https://www.hipeac.net/assets/public/publications/newsletter/hipeacinfo45.pdf), [ARM TechCon'16 presentation and demo](http://schedule.armtechcon.com/session/know-your-workloads-design-more-efficient-systems), [public CK repo](https://github.com/ctuning/ck-wa)

## Feedback

Feel free to engage with our community via this mailing list:
* http://groups.google.com/group/collective-knowledge
