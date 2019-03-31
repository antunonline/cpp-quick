
set(CMAKE_CXX_STANDARD 17)
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

include_directories(BEFORE /opt/boost/include /opt/folly/include)
link_directories(BEFORE /opt/boost/lib /opt/folly/lib)

function(MakeLibStatic NAME)
    set_target_properties(${NAME} PROPERTIES LINK_SEARCH_END_STATIC 1)
endfunction(MakeLibStatic)