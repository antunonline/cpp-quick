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
    dh-autoreconf \
    libssl1.0-dev

if test -f /etc/alpine-release
then
    apk add openssl-dev g++ cmake \
        make \
        binutils-dev \
        curl curl-dev \
        autoconf \
        openssl-dev \
        make cmake python-dev wget git automake libtool \
        libevent-dev \
        linux-headers
fi

./folly/Subprocess.h:#include
./folly/test/ThreadLocalTest.cpp:#include