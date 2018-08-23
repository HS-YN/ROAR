FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

MAINTAINER Heeseung Yun <terry9772@snu.ac.kr>

# install dependencies
RUN apt-get update && \
  apt-get install -y \
    apt-utils \
    build-essential \
    cmake \
    git \
    pkg-config \
    libjpeg8-dev \
    libtiff5-dev \
    libjasper-dev \
    libpng12-dev \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    liblapack-dev \
    libv4l-dev \
    libx264-dev \
    libx265-dev \
    libatlas-base-dev \
    libmicrohttpd-dev \
    gfortran \
    python3.5-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libprotobuf-lite9v5 \
    libprotobuf-dev \
    protobuf-compiler \
    wget \
    software-properties-common \
    graphicsmagick \
    unzip \
    pkg-config \
    python3-pip \
    lsof \
    lsb-core \
    libhdf5-serial-dev \
    libgraphicsmagick1-dev \
    libleveldb-dev \
    liblmdb-dev \
    libsnappy-dev \
    libopencv-dev \
    python-opencv \
    vim-gnome \
    yasm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Anaconda3 install
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

#RUN apt-get install -y autoconf automake libtool curl make g++ unzip && \
#    git clone https://github.com/protocolbuffers/protobuf.git && cd protobuf && \
#    git submodule update --init --recursive && ./autogen.sh && \
#    ./configure --prefix=/usr && make && \
#    make check || : && make install && ldconfig && \
#    cd .. && rm -rf protobuf

RUN git clone --recursive https://github.com/HS-YN/ROAR

WORKDIR /

