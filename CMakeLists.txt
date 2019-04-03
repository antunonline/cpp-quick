cmake_minimum_required(VERSION 3.13)
project(Template)


FUNCTION(PREPEND var prefix)
    SET(listVar "")
    FOREACH(f ${ARGN})
        LIST(APPEND listVar "${prefix}/${f}")
    ENDFOREACH(f)
    SET(${var} "${listVar}" PARENT_SCOPE)
ENDFUNCTION(PREPEND)

FUNCTION(REGISTER_LIB_IF_EXISTS NAME)
    SET(LIBPREFIX "/opt/cpp")
    SET(LIBPATH "${LIBPREFIX}/${NAME}")
    if (EXISTS "${LIBPATH}" AND IS_DIRECTORY "${LIBPATH}")
        include_directories(BEFORE "${LIBPATH}/include/")
        link_directories(BEFORE "${LIBPATH}/lib")
    endif ()
ENDFUNCTION(REGISTER_LIB_IF_EXISTS)


REGISTER_LIB_IF_EXISTS("boost")
REGISTER_LIB_IF_EXISTS("pistache")
REGISTER_LIB_IF_EXISTS("folly")
REGISTER_LIB_IF_EXISTS("restclient-cpp")
REGISTER_LIB_IF_EXISTS("json")