from conans import ConanFile, tools
from conan.tools.cmake import CMake, CMakeDeps, CMakeToolchain, cmake_layout
import re, os

class ConanRecipe(ConanFile):

    # Package Description
    name = "mtask"
    version = "0.1.0"
    license = "MIT"
    author = "siech0"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "Simple tasking library"
    topics = ("<Put some tag here>", "<here>", "<and here>")
   
    # Package Options
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    
    # Package exports/imports/requires
    build_requires = "gtest/cci.20210126"
    exports_sources = "CMakeLists.txt", "cmake/*", "src/*", "include/*"

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    def set_version(self):
        filepath = "include/mtask/version.hpp"
        try:
            data = tools.load(filepath)
            major_version = re.search(r"MTASK_VERSION_MAJOR\s+(\d+)", data).group(1)
            minor_version = re.search(r"MTASK_VERSION_MINOR\s+(\d+)", data).group(1)
            patch_version = re.search(r"MTASK_VERSION_PATCH\s+(\d+)", data).group(1)
            version_string = "{}.{}.{}".format(major_version, minor_version, patch_version)
            self.version = version_string
        except Exception as e:
            self.version = None

    def layout(self):
        cmake_layout(self)

    def generate(self):
        tc = CMakeToolchain(self)
        tc.variables["MTASK_BUILD_EXAMPLES"] = "OFF"
        tc.variables["MTASK_BUILD_TESTS"] = "OFF"
        tc.generate()
        deps = CMakeDeps(self)
        deps.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        filename = "mtask"
        targetname = "mtask::mtask"

        self.cpp_info.names["cmake_find_package"] = filename
        self.cpp_info.names["cmake_find_package_multi"] = filename
        self.cpp_info.set_property("cmake_file_name", filename)
        self.cpp_info.set_property("cmake_target_name", targetname)
        self.cpp_info.set_property("cmake_target_aliases", [targetname])
        self.cpp_info.libs = ["mtask"]