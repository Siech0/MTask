
include(GNUInstallDirs)

# Install headers
install(
	DIRECTORY
		"include/"
		"${PROJECT_BINARY_DIR}/export/"
	DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
	COMPONENT mtask_Development
)

# Install library targets
install(
	TARGETS mtask_mtask
	EXPORT mtaskTargets
	RUNTIME
		COMPONENT mtask_Runtime
	LIBRARY
		COMPONENT mtask_Development
		NAMELINK_COMPONENT mtask_Development
	ARCHIVE
		COMPONENT mtask_Development
	INCLUDES
		DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
		COMPONENT mtask_Development
)

# Allow package maintainers to freely override the path for the cmake configs
set(
	MTASK_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${CMAKE_PROJECT_NAME}"
	CACHE PATH "CMake package config location relative to install prefix."
)
mark_as_advanced(MTASK_INSTALL_CMAKEDIR)

# Generate CMake configs
include(CMakePackageConfigHelpers)
set(project_config_in "${CMAKE_CURRENT_LIST_DIR}/cmake-config.cmake.in")
set(project_config_out "${CMAKE_CURRENT_BINARY_DIR}/mtaskConfig.cmake")
set(project_version_config_out "${CMAKE_CURRENT_BINARY_DIR}/mtaskConfigVersion.cmake")
set(project_config_targets_out "mtaskConfigTargets.cmake")

# Create version config
write_basic_package_version_file(
	"${project_version_config_out}"
	COMPATIBILITY SameMajorVersion
)

# Configure the package install configuration file
configure_package_config_file(
	"${project_config_in}"
	"${project_config_out}"
	INSTALL_DESTINATION "${MTASK_INSTALL_CMAKEDIR}"
)

# Install CMake Configs
# Export config
install(
	EXPORT ${CMAKE_PROJECT_NAME}Targets
	DESTINATION "${MTASK_INSTALL_CMAKEDIR}"
	NAMESPACE mtask::
	FILE "${project_config_targets_out}"
	COMPONENT mtask_Development
)

# package config + version config
install(
	FILES
		"${project_config_out}"
		"${project_version_config_out}"
	DESTINATION "${MTASK_INSTALL_CMAKEDIR}"
	COMPONENT mtask_Development
)