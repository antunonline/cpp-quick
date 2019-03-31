

### Preparation

Create user `cpp-dev` and create `/opt/boost` and `/opt/folly` directories.
Then switch ownership of those directories to `cpp-dev` user.


    sudo -i
    useradd -r cpp-dev -s /bin/bash
    mkdir /opt/boost /opt/folly
    chown cpp-dev -R /opt/boost /opt/folly


Prepare build tools by installing:
    * build-essential
    * make
    * cmake
    * python-dev
    * wget
    * git


Shell code:

    apt-get install -y build-essential make cmake python-dev wget git

### Boost

Download latest Boost source package and start installation

Shell code:

    # Su into root
    sudo -i
    # Su into cpp-dev
    su - cpp-dev
    # Enter bash
    bash
    # Go to boost
    cd /opt/boost
    # Download boost sources
    wget  "https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2"
    # Ensure that hash is ok
    cat <<EOF | sha256sum -c || echo "CRITICAL - Tar has been tampered with"
    8f32d4617390d1c2d16f26a27ab60d97807b35440d45891fa340fc2648b04406 boost_1_69_0.tar.bz2
    EOF
    tar -xf boost_1_69_0.tar.bz2
    cd boost_1_69_0
    ./bootstrap.sh
    ./b2 --prefix=/opt/boost -j7
    ./b2 --prefix=/opt/boost install



### Folly

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
        pkg-config

    su - cpp-dev
    cd /opt/folly
    git clone https://github.com/facebook/folly.git .
    # Hash
    git checkout v2019.03.25.00

    cat <<EOF > build.patch
    diff --git a/CMake/FollyCompilerUnix.cmake b/CMake/FollyCompilerUnix.cmake
    index b12e6d1f..1a97983b 100644
    --- a/CMake/FollyCompilerUnix.cmake
    +++ b/CMake/FollyCompilerUnix.cmake
    @@ -42,7 +42,6 @@ function(apply_folly_compile_options_to_target THETARGET)
           -Wno-unused
           -Wunused-label
           -Wunused-result
    -      -Wnon-virtual-dtor
           \${FOLLY_CXX_FLAGS}
       )
     endfunction()
    diff --git a/CMake/folly-deps.cmake b/CMake/folly-deps.cmake
    index eda96e90..8cede61a 100644
    --- a/CMake/folly-deps.cmake
    +++ b/CMake/folly-deps.cmake
    @@ -4,7 +4,6 @@ include(CheckFunctionExists)
    
     find_package(Boost 1.51.0 MODULE
       COMPONENTS
    -    context
         chrono
         date_time
         filesystem
    EOF

    cat build.patch | patch -p1
    cmake -DBOOST_ROOT=/opt/boost -DCMAKE_INSTALL_PREFIX=/opt/folly .
    make -j7
    make install


### GTest

    sudo -i
    mkdir /opt/gtest
    chown cpp-dev /opt/gtest
    su - cpp-dev
    cd /opt/gtest
    git clone https://github.com/google/googletest.git .
    cmake -DCMAKE_INSTALL_PREFIX=/opt/gtest .
    make -j7
    make install