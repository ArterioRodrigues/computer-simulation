cmake_minimum_required(VERSION 3.10)
project(ComputerSimulation)

set(CMAKE_CXX_STANDARD 17)

find_package(Python3 COMPONENTS Interpreter Development REQUIRED)

execute_process(
  COMMAND python3 -c "import numpy; print(numpy.get_include())"
  OUTPUT_VARIABLE NUMPY_INCLUDE_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "Numpy include dir: ${NUMPY_INCLUDE_DIR}")

add_executable(main 
  src/main.cpp 
  src/helper.cpp 
  src/problem-set-2/binary-search-poisson.cpp
  src/problem-set-2/binary-search-poisson-log.cpp
  src/problem-set-2/transformation-method-poisson.cpp
)

target_include_directories(main PRIVATE 
  ${CMAKE_SOURCE_DIR}/include
  ${NUMPY_INCLUDE_DIR}
  ${Python3_INCLUDE_DIRS})
target_link_libraries(main Python3::Python)
target_compile_options(main PRIVATE -Wno-deprecated-declarations)
