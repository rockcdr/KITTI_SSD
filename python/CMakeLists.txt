if(NOT HAVE_PYTHON)
  message(STATUS "Python interface is disabled or not all required dependencies found. Building without it...")
  return()
endif()

include_directories(${PYTHON_INCLUDE_DIRS} ${NUMPY_INCLUDE_DIR} ${Boost_INCLUDE_DIRS})
file(GLOB_RECURSE python_srcs ${PROJECT_SOURCE_DIR}/python/*.cpp)

set(CMAKE_SHARED_LINKER_FLAGS "-L/usr/local/lib -Wl,-Bstatic -lprotobuf -Wl,-Bdynamic -pthread -lpthread ${CMAKE_SHARED_LINKER_FLAGS}")
add_library(pycaffe SHARED ${python_srcs})
target_link_libraries(pycaffe ${Caffe_LINK} ${PYTHON_LIBRARIES} ${Boost_LIBRARIES})
set_target_properties(pycaffe PROPERTIES PREFIX "" OUTPUT_NAME "_caffe9")
caffe_default_properties(pycaffe)

if(UNIX OR APPLE)
    set(__linkname "${PROJECT_SOURCE_DIR}/python/caffe/_caffe9.so")
    add_custom_command(TARGET pycaffe POST_BUILD
                       COMMAND ln -sf $<TARGET_LINKER_FILE:pycaffe> "${__linkname}"
                       COMMAND ${CMAKE_COMMAND} -E make_directory ${PROJECT_SOURCE_DIR}/python/caffe9/proto
                       COMMAND touch ${PROJECT_SOURCE_DIR}/python/caffe9/proto/__init__.py
                       COMMAND cp ${proto_gen_folder}/*.py ${PROJECT_SOURCE_DIR}/python/caffe9/proto/
                       COMMENT "Creating symlink ${__linkname} -> ${PROJECT_BINARY_DIR}/lib/_caffe9${Caffe_POSTFIX}.so")
endif()

# ---[ Install
file(GLOB files1 *.py requirements.txt)
install(FILES ${files1} DESTINATION python)

file(GLOB files2 caffe/*.py)
install(FILES  ${files2} DESTINATION python/caffe9)
install(TARGETS pycaffe  DESTINATION python/caffe9)
install(DIRECTORY caffe/imagenet caffe/proto caffe/test DESTINATION python/caffe9)



