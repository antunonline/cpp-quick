cmake_minimum_required(VERSION 3.13)
project(Template)

set(CMAKE_CXX_STANDARD 17)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")


FUNCTION(PREPEND var prefix)
    SET(listVar "")
    FOREACH(f ${ARGN})
        LIST(APPEND listVar "${prefix}/${f}")
    ENDFOREACH(f)
    SET(${var} "${listVar}" PARENT_SCOPE)
ENDFUNCTION(PREPEND)


if (EXISTS "/opt/boost" AND IS_DIRECTORY "/opt/boost")
    include_directories(BEFORE "/opt/boost/include/")
    link_directories(BEFORE "/opt/boost/lib")
endif ()

add_subdirectory(http)
add_subdirectory(util)