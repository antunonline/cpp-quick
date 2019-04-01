#!/bin/bash


apt-get update
# Boost
apt-get install -y build-essential make cmake python-dev wget git

# Folly
sudo apt-get install \
    g++ \
    cmake \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev \
    autogen \
    dh-autoreconf