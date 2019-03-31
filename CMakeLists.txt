cmake_minimum_required(VERSION 3.13)
project(Template)


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