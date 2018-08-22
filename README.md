# ROAR
Robot-Oriented Action Recognition

## Environment

* `Docker` and `Nvidia-docker` installed in host OS
* `NVIDIA 390.77 Linux Driver` in host OS
* Rest of the dependencies can be resolved in docker container!

(Note: It is highly likely that there won't be any problem executing this program for other NVIDIA driver settings, but if there are any, please don't hesitate sharing your problem via issues.)

## Structure

> Root
> > OpenPose:v1.3.0
> > Darknet-cpp:master
> > charades-webcam:master

### OpenPose

This is version 1.3.0 of OpenPose, such that the original code can be used without major changes.

* `/3rdparty/caffe`
  * automatic change incurred from the shell script installing caffe dependencies
* `/examples/tutorial_pose/CMakeLists.txt`
  * integrate `Darknet` and `Protobuf`
* `/examples/tutorial_pose/HTTP`
  * serial communication between server and robot
* `/examples/tutorial_pose/3_HTTP_main2.cpp`
  * integrated darknet and protobuf for classification and communication

### Darknet

This is Darknet-cpp, cloned from prabindh/darknet. There were some modification for better performance of the program:

* `Makefile`
  * use `/usr/local/cuda-8.0/bin/nvcc` rather than `nvcc` for compiler
  * use `/usr/local/cuda-8.0` rather than `/usr/local/cuda` for better performance
* `/src/compare.c`
  * changed the type of network from `network` to `network *` for consistency with original darknet code
  * also changed the type issue propagated from the change above
* `/src/softmax_layer.c` and `/src/softmax_layer_kernels.cu`
  * modified for matching type change mentioned above

Detailed changelog can be provided by request.

### Charades-webcam:master

* `environment.yml`
  * Use other version of library dependencies for the conda repositories that do not exist.
* `charades-webcam.py`
  * Modified for static image usage, not webcam.
* `util/visualization-utils.py`
  * Remove log output

