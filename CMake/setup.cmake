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