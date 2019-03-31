cmake_minimum_required(VERSION 3.11)

project(Template-Util)
include(../CMake/setup.cmake)

add_library(TemplateUtil src/Json.cpp include/Json.h)
target_link_libraries(TemplateUtil boost_system pthread)
MakeLibStatic(TemplateUtil)