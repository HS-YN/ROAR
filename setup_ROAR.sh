cd darknet
if [! -f "/ROAR/darknet/yolov3.weights"]
then
wget https://pjreddie.com/media/files/yolov3.weights
fi
cd ..

cd openpose
mkdir build; cd build
cmake -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 CUDA_BIN_PATH=/usr/local/cuda-8.0 ..
make
cd ../..

echo "to use charades-webcam together, use these codes below:" 
echo "$ conda env create -f environment.yml" 
echo "$ source activate object-detection" 
echo "$ python charades-webcam/charades-webcam.py &" 
