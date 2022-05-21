# Hacking

Here is some wisdom to help you build and test this project as a developer and
potential contributor.

If you plan to contribute, please read the [CONTRIBUTING](CONTRIBUTING.md)
guide.

### Presets

This project makes use of [presets][1] to simplify the process of configuring
the project. As a developer, you are recommended to always have the [latest
CMake version][2] installed to make use of the latest Quality-of-Life
additions.

As a developer, you should create a `CMakeUserPresets.json` file at the root of
the project:

```json
{
  "version": 2,
  "cmakeMinimumRequired": {
    "major": 3,
    "minor": 14,
    "patch": 0
  },
  "configurePresets": [
    {
      "name": "dev-common",
      "description": "Common development settings.",
      "hidden": true,
      "binaryDir": "${sourceDir}/build",
      "inherits": [ "conan", "clang-tidy", "cppcheck" ]
    },
    {
      "name": "dev-unix",
      "description": "Development settings for unix.",
      "inherits": [ "dev-common", "ci-unix" ],
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Debug"
      }
    },
    {
      "name": "dev-windows",
      "description": "Development settings for windows.",
      "inherits": [ "dev-common", "ci-win64" ]
    }
  ]
}
```

You should replace `<os>` in your newly created presets file with the name of
the operating system you have, which may be `win64` or `unix`. You can see what
these correspond to in the [`CMakePresets.json`](CMakePresets.json) file.

`CMakeUserPresets.json` is also the perfect place in which you can put all
sorts of things that you would otherwise want to pass to the configure command
in the terminal.

### Dependency manager

The above preset will make use of the [conan][conan] dependency manager. After
installing it, download the dependencies and generate the necessary CMake
files by running this command in the project root:

```sh
conan install . -s build_type=Debug -b missing
```

Note that if your conan profile does not specify the same compiler used by
CMake, then that could potentially cause issues. See the [conan docs][profile]
on profiles.

[conan]: https://conan.io/
[profile]: https://docs.conan.io/en/latest/using_packages/using_profiles.html

### Configure, build and test

If you followed the above instructions, then you can configure, build and test
the project respectively with the following commands from the project root on
any operating system with any build system:

```sh
cmake --preset=dev
cmake --build --preset=dev
ctest --preset=dev
```

If you are using a compatible editor (e.g. VSCode) or IDE (e.g. CLion, VS), you
will also be able to select the above created user presets for automatic
integration.

Please note that both the build and test commands accept a `-j` flag to specify
the number of jobs to use, which should ideally be specified to the number of
threads your CPU has. You may also want to add that to your preset using the
`jobs` property, see the [presets documentation][1] for more details.

### Developer targets
#### `coverage`

Available if `ENABLE_COVERAGE` is enabled. This target processes the output of
the previously run tests when built with coverage configuration. The commands
this target runs can be found in the `COVERAGE_TRACE_COMMAND` and
`COVERAGE_HTML_COMMAND` cache variables. The trace command produces an info
file by default, which can be submitted to services with CI integration. The
HTML command uses the trace command's output to generate a HTML document to
`<binary-dir>/coverage_html` by default.

#### `docs`

Available if `BUILD_MCSS_DOCS` is enabled. Builds to documentation using
Doxygen and m.css. The output will go to `<binary-dir>/docs` by default
(customizable using `DOXYGEN_OUTPUT_DIRECTORY`).

#### `format-check` and `format-fix`

These targets run the clang-format tool on the codebase to check errors and to
fix them respectively. Customization available using the `FORMAT_PATTERNS` and
`FORMAT_COMMAND` cache variables.

#### `run-examples`

Runs all the examples created by the `add_example` command.

#### `spell-check` and `spell-fix`

These targets run the codespell tool on the codebase to check errors and to fix
them respectively. Customization available using the `SPELL_COMMAND` cache
variable.

[1]: https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html
[2]: https://cmake.org/download/
