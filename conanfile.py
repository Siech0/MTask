from conans import ConanFile
from conan.tools.cmake import CMake, CMakeDeps, CMakeToolchain, cmake_layout


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
    
    # Package exports/imports
    exports_sources = "CMakeLists.txt", "cmake/*", "src/*", "include/*"

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

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
        self.cpp_info.libs = ["mtask"]
