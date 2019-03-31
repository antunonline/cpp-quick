cmake_minimum_required(VERSION 3.11)

project(Template-Util)

set(CMAKE_CXX_STANDARD 17)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

add_library(TemplateUtil src/Json.cpp include/Json.h)

target_link_libraries(TemplateUtil boost_system pthread)

set_target_properties(TemplateUtil PROPERTIES LINK_SEARCH_END_STATIC 1)