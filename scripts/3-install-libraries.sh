#!/bin/bash

# Run this script as cpp users if installing under Ubuntu.
# If script is ran under Alpine in container, run as root
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



# Install GTest

cd /opt/cpp
echo "Installing GTest"
if ! test -d gtest; then mkdir gtest; fi
cd gtest
if ! test -d .git; then git clone https://github.com/google/googletest.git .; fi
if ! test -f /opt/cpp/gtest/lib/libgtest.a;
then
cmake -DCMAKE_INSTALL_PREFIX=/opt/cpp/gtest .
make -j7
make install
touch installed
fi

# Install double-conversion
cd /opt/cpp
if ! test -f double-conversion; then mkdir double-conversion;fi
cd double-conversion

if ! test -d .git;
then
    git clone https://github.com/google/double-conversion .
    git checkout v3.1.4
fi

if ! test -f /usr/local/lib/libdouble-conversion.a;
then
    cmake .
    make -j7 install
fi

# Install gflags
cd /opt/cpp

if ! test -d gflags; then mkdir gflags; fi
cd gflags

if ! test -d .git; then git clone https://github.com/gflags/gflags.git .; fi

if ! test -f /usr/local/lib/libgflags.a
then
    git checkout v2.2.2
    cmake .
    make -j7 install
fi


# Install glog
cd /opt/cpp
if ! test -d glog; then mkdir glog; fi
cd glog
if ! test -d .git; then git clone https://github.com/google/glog.git .; fi

if ! test -f /usr/local/lib64/libglog.a
then
    git checkout v0.4.0
    cmake .
    make -j7 install
fi

# Install boost
cd /opt/cpp
echo "Installing Boost"
if ! test -d /opt/cpp/boost; then mkdir boost; fi
cd boost

## Download boost
if ! test -f "boost_1_69_0.tar.bz2"
then
# Download boost sources
wget  "https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2"
# Ensure that hash is ok
cat <<EOF | sha256sum -c || echo "CRITICAL - Tar has been tampered with"
8f32d4617390d1c2d16f26a27ab60d97807b35440d45891fa340fc2648b04406 boost_1_69_0.tar.bz2
EOF
tar -xf boost_1_69_0.tar.bz2
fi

## Install boost
cd boost_1_69_0
    if ! test -f /opt/cpp/boost/lib/libboost_system.a; then
    ./bootstrap.sh
    ./b2 --prefix=/opt/cpp/boost -j7 || (echo "Failed compiling Boost"; exit 1)
    ./b2 --prefix=/opt/cpp/boost install || (echo "Failed installing Boost"; exit 1)
    touch installed
    fi

echo "Installing Folly"
cd /opt/cpp/
if ! test -d folly; then mkdir folly; fi
cd folly

if ! test -d .git; then git clone https://github.com/facebook/folly.git .; fi
git checkout v2019.03.25.00

# Apply folly build patch
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
diff --git a/folly/Subprocess.h b/folly/Subprocess.h
index ee98793f..036dd223 100644
--- a/folly/Subprocess.h
+++ b/folly/Subprocess.h
@@ -98,7 +98,7 @@
 #if __APPLE__
 #include <sys/wait.h>
 #else
-#include <wait.h>
+#include <sys/wait.h>
 #endif

 #include <exception>
EOF

# Build folly
if ! test -f patched; then cat build.patch | patch -p1; fi
touch patched

if ! test -f /opt/cpp/folly/lib/libfolly.a; then
    cmake -DBOOST_ROOT=/opt/cpp/boost -DCMAKE_INSTALL_PREFIX=/opt/cpp/folly .
    make -j7 || (echo "Failed building Folly"; exit 1)
    make install || (echo "Failed installing Folly"; exit 1)
fi


# Install Pistache
echo "Installing Pistache"
cd /opt/cpp

if ! test -d pistache; then mkdir pistache; fi
cd pistache

if ! test -d .git; then git clone https://github.com/oktal/pistache.git .; fi
if ! test -d build; then mkdir build; fi
cd build
if ! test -f /opt/cpp/pistache/lib/libpistache.a;
then
git submodule update --init
cmake -DCMAKE_INSTALL_PREFIX=/opt/cpp/pistache -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
make -j7 || (echo "Failed building Pistache"; exit 1)
make install || (echo "Failed installing Pistache"; exit 1)
touch installed
fi


# Install Json library
echo "Installing Json"
cd /opt/cpp
if ! test -d json; then  mkdir json; fi
cd json

if ! test -d .git; then git clone https://github.com/nlohmann/json.git . ; fi


# Install HTTP client
echo "Installing HTTP Client"
# https://github.com/embeddedmz/httpclient-cpp

cd /opt/cpp
if ! test -d restclient-cpp; then mkdir restclient-cpp; fi
cd restclient-cpp
if ! test -d .git; then git clone https://github.com/mrtazz/restclient-cpp .; fi
if ! test -f /opt/cpp/restclient-cpp/lib/librestclient-cpp.a;
then
    ./autogen.sh
    ./configure --prefix=/opt/cpp/restclient-cpp
    make -j7
    make install
    touch installed
fi

echo "Finished installation"