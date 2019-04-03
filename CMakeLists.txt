cmake_minimum_required(VERSION 3.13)
project(Template)


include(${CMAKE_CURRENT_LIST_DIR}/CMake/setup.cmake)

REGISTER_LIB_IF_EXISTS("boost")
REGISTER_LIB_IF_EXISTS("pistache")
REGISTER_LIB_IF_EXISTS("folly")
REGISTER_LIB_IF_EXISTS("restclient-cpp")
REGISTER_LIB_IF_EXISTS("json")