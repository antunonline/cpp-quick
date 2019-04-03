set(CMAKE_CXX_STANDARD 17)
#set(BUILD_SHARED_LIBS OFF)
#set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

include_directories(BEFORE /opt/boost/include /opt/folly/include /opt/cpp/pistache/include)
link_directories(BEFORE /opt/boost/lib /opt/folly/lib /opt/cpp/pistache/lib)

function(MakeLibStatic NAME)
    set_target_properties(${NAME} PROPERTIES LINK_SEARCH_END_STATIC 1)
    set_target_properties(${NAME} PROPERTIES COMPILE_FLAGS "-static-libstdc++ -static")
    set_target_properties(${NAME} PROPERTIES BUILD_SHARED_LIBS OFF)
endfunction(MakeLibStatic)

function(MakeStaticForProduction TARGET)
    if(EXISTS "/etc/alpine-release")
        MakeLibStatic("${NAME}")
    endif()
endfunction(MakeStaticForProduction)



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