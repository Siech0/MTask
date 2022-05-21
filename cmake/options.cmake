
##### Options Used By Library #####

# Build all artifacts
option(MTASK_BUILD_ALL "Build all artifacts." OFF)

# Build examples
option(MTASK_BUILD_EXAMPLES "Build example artifacts." ${PROJECT_IS_TOP_LEVEL})

# Build tests
option(MTASK_BUILD_TESTS "Build test artifacts." OFF)

# Build benchmarks
option(MTASK_BUILD_BENCHMARKS "Build benchmark artifacts." OFF)

# Generate install targets
option(MTASK_INSTALL "Generate install targets." ${PROJECT_IS_TOP_LEVEL})