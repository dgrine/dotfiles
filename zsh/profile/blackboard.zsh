# C++
if [ -x "$(command -v cpp)" ]; then
    function bb-cpp-create() {
        if [ $# -lt 2 ]; then
            echo "error: namespace and app must be specified"
            return 1
        fi
        namespace=$1
        project=$2

        # CMakeLists.txt
        echo "Creating CMakeLists.txt"
        cat <<EOT > CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(${project})
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
include("cmake/runtime_checks.cmake")
enable_testing()
add_subdirectory(lib)
add_subdirectory(ut)
EOT
        # cmake/toolchain/clang.cmake
        echo "Creating cmake/toolchain/clang.cmake"
        mkdir -p cmake/toolchain
        cat <<EOT > cmake/toolchain/clang.cmake
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
#set(CMAKE_MAKE_PROGRAM make)
EOT

        # cmake/runtime_checks.cmake
        echo "Creating cmake/runtime_checks.cmake"
        cat <<EOT > cmake/runtime_checks.cmake
SET(BB_RTC "\${BB_RTC}" CACHE STRING "Run-time checks")
if (DEFINED BB_RTC)
    if ("\${BB_RTC}" STREQUAL "AsanAddress")
        SET(asan_flags "-fsanitize=address -fsanitize=leak -fno-omit-frame-pointer -g")
    elseif ("\${BB_RTC}" STREQUAL "AsanMemory")
        SET(asan_flags "-fsanitize=memory -fsanitize-memory-track-origins -fno-omit-frame-pointer -g")
    elseif ("\${BB_RTC}" STREQUAL "Valgrind")
    elseif ("\${BB_RTC}" STREQUAL "")
    else()
        MESSAGE(FATAL_ERROR "Unknown sanitizer defined in BB_RTC: '\${BB_RTC}'")
    endif()

    if (NOT "\${BB_RTC}" STREQUAL "Valgrind")
        MESSAGE(STATUS "Enabling Sanitizer: \${asan_flags}")
        SET(CMAKE_CXX_FLAGS "\${CMAKE_CXX_FLAGS} \${asan_flags}")
        SET(CMAKE_C_FLAGS "\${CMAKE_C_FLAGS} \${asan_flags}")
        SET(CMAKE_EXE_LINKER_FLAGS "\${CMAKE_EXE_LINKER_FLAGS} \${asan_flags}")
        SET(CMAKE_MODULE_LINKER_FLAGS "\${CMAKE_MODULE_LINKER_FLAGS} \${asan_flags}")
    endif()
else()
    MESSAGE(STATUS "Skipping Sanitizer")
endif()
EOT

        # .gitignore
        echo "Creating .gitignore"
        cat <<EOT > .gitignore
build/
.vscode
.ccls-*
.clang-format
compile_commands.json
EOT

        # .vscode/launch.json
        echo "Creating .vscode/launch.json"
        mkdir -p .vscode/
        cat <<EOT > .vscode/launch.json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "${project}",
            "program": "`pwd`/build/debug/ut/${project}-ut",
            "env": {
                "ASAN_OPTIONS=detect_leaks": "0"
            },
            "args": [],
            "cwd": "\`${project}\`"
        }
    ]
}
EOT

        # extern
        echo "Downloading doctest"
        mkdir -p extern/doctest/public/doctest
        cd extern/doctest/public/doctest
        curl -O -j https://raw.githubusercontent.com/onqtam/doctest/master/doctest/doctest.h
        cd ../../../..

        # lib
        echo "Creating library directory structure"
        mkdir -p lib/public/${namespace}/${project}
        mkdir -p lib/private/${namespace}/${project}
        cd lib
        # lib/CMakeLists.txt
        cat <<EOT > CMakeLists.txt
set(librarySources "private/${namespace}/${project}/hello_world.cpp")
add_library(${project}-lib \${librarySources})
target_include_directories(${project}-lib
    PUBLIC public/
    PRIVATE private/
)
EOT
        # lib/public/${namespace}/${project}/hello_world.hpp
        cat <<EOT > public/${namespace}/${project}/hello_world.hpp
#include <string>

std::string hello_world();
EOT
        # lib/private/${namespace}/${project}/hello_world.cpp
        cat <<EOT > private/${namespace}/${project}/hello_world.cpp
#include <${namespace}/${project}/hello_world.hpp>

std::string hello_world()
{
    return "Hello World!";
}
EOT
        cd ..

        # ut
        echo "Creating unit-test directory structure"
        mkdir -p ut/private
        cd ut
        # ut/CMakeLists.txt
        cat <<EOT > CMakeLists.txt
set(unitTestSources "private/main.cpp")
add_executable(ut \${unitTestSources})
target_link_libraries(ut PUBLIC ${project}-lib)
target_include_directories(ut PRIVATE ../extern/doctest/public)
target_compile_definitions(ut PRIVATE DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN)

add_test(NAME ut COMMAND app_ut)
EOT
        # ut/private/main.cpp
        cat <<EOT > private/main.cpp
#include <${namespace}/${project}/hello_world.hpp>
#include <doctest/doctest.h>

TEST_CASE("unit-test")
{
    CHECK("Hello World!" == hello_world());
}
EOT
        cd ..
    }

    function bb-cpp-configure() {
        bb-cpp-clean()
        local dir=""

        dir="build/debug"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/clang.cmake
        cd ../..

        dir="build/debug-rtc-address"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/clang.cmake -DBB_RTC="AsanAddress" 
        cd ../..

        dir="build/reldeb"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/clang.cmake
        cd ../..

        dir="build/reldeb-rtc-address"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/clang.cmake -DBB_RTC="AsanAddress"
        cd ../..

        dir="build/release"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/clang.cmake
        cd ../..

        # .clang-complete
        ln -sf ~/dev/repos/setup/clang-format/.clang-format
        python3 ~/dev/repos/setup/coc/generate_compile_commands.py
    }


    function bb-cpp-build() {
        if [ $# -lt 1 ]; then
            echo "error: build name must be specified"
            ls build/
            echo "usage: cpp-build debug-rtc-address"
            return 1
        else
            local dir="build/$1"
            echo "Building $2 in ${dir}"
            cd $dir && make $2 -j32
            cd -
        fi
    }

    function bb-cpp-ut() {
        if [ $# -lt 1 ]; then
            echo "error: build name must be specified"
            ls build/
            return 1
        fi
        if [ ! -d "build/$1" ]; then
            echo "error: invalid build name '$1'"
            ls build/
            return 1
        fi
        echo "Building unit-test for ${1}"
        bb-cpp-build $1 ut
        if [ $? -eq 0 ]; then
            echo "Running unit-test ${ut}"
            local ut="build/${1}/ut/ut"
            ${ut}
        else
            echo "error: build failed, skipping unit-test run"
            return 1
        fi
    }

    function bb-cpp-clean() {
        rm -rf build/
    }
fi


