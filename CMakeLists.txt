cmake_minimum_required(VERSION 2.8.8)
project(jbig2enc)

include_directories("${PROJECT_SOURCE_DIR}")
include_directories("${PROJECT_BINARY_DIR}")
include_directories("${PROJECT_SOURCE_DIR}/src")
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)

add_definitions(-DVERSION="0.28" -DGENERIC_API_VERSION="0.28" -DGENERIC_LIBRARY_VERSION="0:28" -DGENERIC_VERSION="0.28.0" -DPACKAGE_VERSION="0.28")

find_package(Leptonica)

file (GLOB_RECURSE obj RELATIVE "${PROJECT_SOURCE_DIR}" "src/*.cc")
file (GLOB_RECURSE inc RELATIVE "${PROJECT_SOURCE_DIR}" "src/*.h")
set(obj "src/jbig2arith.cc" "src/jbig2comparator.cc" "src/jbig2enc.cc" "src/jbig2sym.cc")
if (LEPTONICA_FOUND)
    add_library(jbig2enc SHARED ${obj})
    target_link_libraries(jbig2enc "dl")

# install binary
    if (WIN32)
        install (FILES "${PROJECT_BINARY_DIR}/libjbig2enc.dll.a" DESTINATION lib)
        install (FILES "${PROJECT_BINARY_DIR}/libjbig2enc.dll" DESTINATION lib)
        install (FILES "${PROJECT_BINARY_DIR}/libjbig2enc.dll" DESTINATION bin)
    else()
        install (TARGETS jbig2enc DESTINATION lib)
    endif()
# install header
    install (FILES ${inc} DESTINATION include/jbig2enc)
endif()
