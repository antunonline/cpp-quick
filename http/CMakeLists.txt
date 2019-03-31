cmake_minimum_required(VERSION 3.11)

project(Template-Http)
include(../CMake/setup.cmake)

add_library(TemplateHttp src/HttpServer.cpp src/HttpClient.cpp include/HttpServer.h include/HttpClient.h)
target_link_libraries(TemplateHttp boost_system pthread folly)

