cmake_minimum_required(VERSION 3.11)

project(Template-Http)
include(../CMake/setup.cmake)

add_library(TemplateHttp src/HttpServer.cpp src/HttpClient.cpp include/HttpServer.h include/HttpClient.h)
target_link_libraries(TemplateHttp boost_system glog pthread folly crypto ssl)
MakeLibStatic(TemplateHttp)

add_executable(TemplateHttpTest test/main.cpp test/TestHttp.cpp)
target_include_directories(TemplateHttpTest PUBLIC /opt/cpp/gtest/include ${CMAKE_SOURCE_DIR}/http/include)
target_link_directories(TemplateHttpTest PUBLIC /opt/cpp/gtest/lib)
target_link_libraries(TemplateHttpTest gtest event glog boost_system ssl crypto pthread folly iberty boost_filesystem boost_system boost_program_options boost_regex gflags double-conversion dl TemplateHttp)
