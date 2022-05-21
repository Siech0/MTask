cmake_minimum_required(VERSION 3.14)

project(mtask-tests LANGUAGES CXX)
enable_testing()

##### Dependency Managment #####

find_package(GTest REQUIRED)
if(NOT TARGET mtask::mtask)
    find_package(mtask REQUIRED)
endif()

###### Test Exectuable #####
add_executable(mtask-tests
    src/sanity-tests.cpp
)

target_link_libraries(mtask-tests
    mtask::mtask
    GTest::gtest
    GTest::gtest_main
)

##### Test Discovery #####

include(CTest)
include(GoogleTest)
gtest_discover_tests(mtask-tests)