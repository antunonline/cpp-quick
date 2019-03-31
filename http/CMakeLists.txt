cmake_minimum_required(VERSION 3.11)

project(Template-Http)

set(CMAKE_CXX_STANDARD 17)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

add_library(TemplateHttp src/HttpServer.cpp src/HttpClient.cpp include/HttpServer.h include/HttpClient.h)

target_link_libraries(TemplateHttp boost_system pthread /opt/folly/folly.a)
target_include_directories(TemplateHttp PUBLIC "/opt/folly")

set_target_properties(TemplateHttp PROPERTIES LINK_SEARCH_END_STATIC 1)