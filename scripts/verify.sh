#!/bin/sh

(test -f /opt/cpp/gtest/lib64/libgtest.a || test -f /opt/cpp/gtest/lib/libgtest.a) || echo "gtest missing"
test -f /usr/local/lib/libdouble-conversion.a || echo "double-conversion missing"
(test -f /usr/local/lib/libgflags.a  || test -f /usr/lib/x86_64-linux-gnu/libgflags.a) || echo "gflags missing"
(test -f /usr/local/lib64/libglog.a || test -f /usr/lib/x86_64-linux-gnu/libglog.a ) || echo "glog missing"
test -f /opt/cpp/boost/lib/libboost_system.a || echo "boost missing"
test -f /opt/cpp/folly/lib/libfolly.a || echo "folly missing"
test -f /opt/cpp/pistache/lib/libpistache.a || echo "pistache missing"
test -f /opt/cpp/json/include/nlohmann/json.hpp || echo "json missing"
test -f /opt/cpp/restclient-cpp/lib/librestclient-cpp.a || echo "rest missing"