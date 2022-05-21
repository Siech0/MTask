cmake_minimum_required(VERSION 3.1)
project(PackageTest CXX)

find_package(mtask)

add_executable(example src/test_package.cpp)
target_link_libraries(example mtask::mtask)

