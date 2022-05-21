cmake_minimum_required(VERSION 3.14)

###### Setup Project #####

project(
	mtask
	VERSION 0.1.0
	DESCRIPTION "Tasking utility library"
	HOMEPAGE_URL "https://www.example.com"
	LANGUAGES CXX
)

include(GNUInstallDirs)
include(cmake/project-is-top-level.cmake)
include(cmake/options.cmake)


##### Library Setup #####

# Load Dependencies
find_package(Threads REQUIRED)

# Prepare sources
set(MTASK_SOURCES 
	"src/mtask.cpp"
)

set(MTASK_HEADERS
	"include/mtask/mtask.hpp"
)

# Create library
add_library(mtask_mtask ${MTASK_SOURCES} ${MTASK_HEADERS})
add_library(mtask::mtask ALIAS mtask_mtask)

target_include_directories( mtask_mtask
	PUBLIC
		"$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

target_link_libraries( mtask_mtask
	PUBLIC
		Threads::Threads
)

set_target_properties(
	mtask_mtask PROPERTIES
	CXX_VISIBILITY_PRESET hidden TODO: Implement export configs
    VISIBILITY_INLINES_HIDDEN YES
	VERSION "${PROJECT_VERSION}"
	SOVERSION "${PROJECT_VERSION_MAJOR}"
	EXPORT_NAME mtask
	OUTPUT_NAME mtask
)

# Generate + link against export header
include(GenerateExportHeader)
generate_export_header(
	mtask_mtask
	BASE_NAME mtask
	EXPORT_FILE_NAME export/mtask/mtask_export.hpp
)

target_include_directories( mtask_mtask SYSTEM
	PUBLIC 
		"$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

if(NOT BUILD_SHARED_LIBS)
	target_compile_definitions(mtask_mtask PUBLIC MTASK_STATIC_DEFINE)
endif()

##### Additional Artifacts #####
# Examples
if(MTASK_BUILD_ALL OR MTASK_BUILD_EXAMPLES)
	add_subdirectory(example)
endif()

# Tests
if(MTASK_BUILD_ALL OR MTASK_BUILD_TESTS)
	add_subdirectory(test)
endif()

# Benchmarks
if(MTASK_BUILD_BENCHMARKS OR MTASK_BUILD_BENCHMARKS)
	add_subdirectory(bench)
endif()

##### Install #####
if(MTASK_INSTALL)
	include(cmake/install-rules.cmake)
endif()