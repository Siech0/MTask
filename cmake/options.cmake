
##### Options Used By Library #####

# Build all artifacts
option(MTASK_BUILD_ALL "Build all artifacts." OFF)

# Build examples
option(MTASK_BUILD_EXAMPLES "Build example artifacts." ${PROJECT_IS_TOP_LEVEL})

# Build tests
option(MTASK_BUILD_TESTS "Build test artifacts." OFF)

# Build benchmarks
option(MTASK_BUILD_BENCHMARKS "Build benchmark artifacts." OFF)

# Build documentation
option(MTASK_BUILD_DOCS "Build documentation artifacts." OFF)

# Generate install targets
option(MTASK_INSTALL "Generate install targets." ${PROJECT_IS_TOP_LEVEL})

# Enable linting
option(MTASK_ENABLE_FORMAT "Generate clang-format targets." OFF)

# Enable spell checking
option(MTASK_ENABLE_SPELLCHECK "Generating spell-check targets." OFF)