# ROAR
Robot-Oriented Action Recognition

## How to run

1. `git clone --recursive https://github.com/HS-YN/ROAR`
2. Prepare darknet-cpp
   * `cd darknet; make darknet-cpp; cd ../`
3. Prepare openpose
   * `cd openpose; mkdir build`
   * `cmake -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 CUDA_BIN_PATH=/usr/local/cuda-8.0 ..`
   * if you'd like to use different cuda version, please change the directory accordingly.
   * `make; cd ../..`
4. (Optional) prepare charades-webcam
   * If you want to use charades-webcam together, use these codes below
   * `cd charades-webcam; conda env create -f environment.yml; cd ..`
   * `source activate object-detection`
   * `python charades-webcam/charades-webcam.py &` (background execution)
   * After using, don't forget to deactivate virtual environment by `source deactivate`
5. You're all set! run `openpose/examples/tutorial_pose/3_HTTP_test2.cpp`
   (If you want this process to be done automatically, please execute `sh setup_ROAR.sh`)

## Environment

* `Docker` and `Nvidia-docker` installed in host OS
* `NVIDIA 390.77 Linux Driver` in host OS
* `X11-xephyr` if you want to see the result real-time
  * Run `sudo apt-get install xserver-xephyr` in **host**
* Rest of the dependencies can be resolved in docker container!
  * Just run `sudo nvidia-docker build -t ROAR .`

(Note: It is highly likely that there won't be any problem executing this program for other NVIDIA driver settings, but if there are any, please don't hesitate sharing your problem via [issues](https://github.com/HS-YN/ROAR/issues).)

## Structure

> Root
> > OpenPose:v1.3.0
> > Darknet-cpp:master
> > charades-webcam:master

### [OpenPose](https://github.com/HS-YN/openpose/tree/v1.3.1)

This is version 1.3.0 of OpenPose, such that the original code can be used without major changes.
Diff can be found [here](https://github.com/CMU-Perceptual-Computing-Lab/openpose/compare/master...HS-YN:v1.3.1).

* `/3rdparty/caffe`
  * automatic change incurred from the shell script installing caffe dependencies
* `/examples/tutorial_pose/CMakeLists.txt`
  * integrate `Darknet` and `Protobuf`
* `/examples/tutorial_pose/HTTP`
  * serial communication between server and robot
* `/examples/tutorial_pose/3_HTTP_main2.cpp`
  * integrated darknet and protobuf for classification and communication

### [Darknet](https://github.com/HS-YN/darknet/tree/ROAR)

This is Darknet-cpp, cloned from prabindh/darknet. There were some modification for better performance of the program, which is explained below.
Diff can be found [here](https://github.com/prabindh/darknet/compare/master...HS-YN:ROAR).

* `Makefile`
  * use `/usr/local/cuda-8.0/bin/nvcc` rather than `nvcc` for compiler
  * use `/usr/local/cuda-8.0` rather than `/usr/local/cuda` for better performance
* `/src/compare.c`
  * changed the type of network from `network` to `network *` for consistency with original darknet code
  * also changed the type issue propagated from the change above
* `/src/softmax_layer.c` and `/src/softmax_layer_kernels.cu`
  * modified for matching type change mentioned above

### [Charades-webcam](https://github.com/HS-YN/charades-webcam)

Diff can he found [here](https://github.com/gsig/charades-webcam/compare/master...HS-YN:master)

* `environment.yml`
  * Use other version of library dependencies for the conda repositories that do not exist.
* `charades-webcam.py`
  * Modified for static image usage, not webcam.
* `util/visualization-utils.py`
  * Remove log output

