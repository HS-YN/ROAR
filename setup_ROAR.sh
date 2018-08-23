cd darknet
make darknet-cpp
cd ..

cd openpose
mkdir build
cmake -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 CUDA_BIN_PATH=/usr/local/cuda-8.0 ..
make
cd ..

echo("to use charades-webcam together, use these codes below:")
echo("$ conda env create -f environment.yml")
echo("$ source activate object-detection")
echo("$ python charades-webcam/charades-webcam.py &")
