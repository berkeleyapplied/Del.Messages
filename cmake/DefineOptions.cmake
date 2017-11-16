#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#

#
# Taken from apache thrift cmake resources - WITH MODIFICATIONS
#
include(CMakeDependentOption)

set(THRIFT_COMPILER "" CACHE FILEPATH "External Thrift compiler to use during build")
CMAKE_DEPENDENT_OPTION(BUILD_TESTING "Build with unit tests" ON "HAVE_COMPILER" OFF)

# Libraries to build

# Each language library can be enabled or disabled using the WITH_<LANG> flag.
# By default CMake checks if the required dependencies for a language are present
# and enables the library if all are found. This means the default is to build as
# much as possible but leaving out libraries if their dependencies are not met.

option(WITH_BOOST_FUNCTIONAL "Use boost/tr1/functional.hpp even under C++11 or later" OFF)
if (WITH_BOOST_FUNCTIONAL)
    add_definitions(-DFORCE_BOOST_FUNCTIONAL)
endif()

option(WITH_BOOST_SMART_PTR "Use boost/smart_ptr.hpp even under C++11 or later" OFF)
if (WITH_BOOST_SMART_PTR)
    add_definitions(-DFORCE_BOOST_SMART_PTR)
endif()

option(WITH_BOOST_STATIC "Build with Boost static link library" OFF)
set(Boost_USE_STATIC_LIBS ${WITH_BOOST_STATIC})
if (NOT WITH_BOOST_STATIC)
    add_definitions(-DBOOST_ALL_DYN_LINK)
    add_definitions(-DBOOST_TEST_DYN_LINK)
endif()

# C++
option(WITH_CPP "Build C++ Thrift library" OFF)
if(WITH_CPP)
    find_package(Boost 1.53 QUIET)
    # NOTE: Currently the following options are C++ specific,
    # but in future other libraries might reuse them.
    # So they are not dependent on WITH_CPP but setting them without WITH_CPP currently
    # has no effect.
    if(ZLIB_LIBRARY)
        # FindZLIB.cmake does not normalize path so we need to do it ourselves.
        file(TO_CMAKE_PATH ${ZLIB_LIBRARY} ZLIB_LIBRARY)
    endif()
    find_package(ZLIB QUIET)
    CMAKE_DEPENDENT_OPTION(WITH_ZLIB "Build with ZLIB support" ON
        "ZLIB_FOUND" OFF)
    option(WITH_STDTHREADS "Build with C++ std::thread support" OFF)
    CMAKE_DEPENDENT_OPTION(WITH_BOOSTTHREADS "Build with Boost threads support" OFF
        "NOT WITH_STDTHREADS;Boost_FOUND" OFF)
endif()
CMAKE_DEPENDENT_OPTION(BUILD_CPP "Build C++ library" ON
    "WITH_CPP;Boost_FOUND" OFF)

# C GLib
option(WITH_C_GLIB "Build C (GLib) Thrift library" OFF)
if(WITH_C_GLIB)
    find_package(GLIB QUIET COMPONENTS gobject)
endif()
CMAKE_DEPENDENT_OPTION(BUILD_C_GLIB "Build C (GLib) library" ON
    "WITH_C_GLIB;GLIB_FOUND" OFF)

if(BUILD_CPP)
    set(boost_components)
    if(WITH_BOOSTTHREADS OR BUILD_TESTING)
        list(APPEND boost_components system thread)
    endif()
    if(BUILD_TESTING)
        list(APPEND boost_components unit_test_framework filesystem chrono program_options)
    endif()
    if(boost_components)
        find_package(Boost 1.53 REQUIRED COMPONENTS ${boost_components})
    endif()
elseif(BUILD_C_GLIB AND BUILD_TESTING)
    find_package(Boost 1.53 REQUIRED)
endif()

# Python
option(WITH_PYTHON "Build Python Thrift library" OFF)
find_package(PythonInterp QUIET) # for Python executable
find_package(PythonLibs QUIET) # for Python.h
CMAKE_DEPENDENT_OPTION(BUILD_PYTHON "Build Python library" ON
    "WITH_PYTHON;PYTHONLIBS_FOUND" OFF)

# Java
option(WITH_JAVA "Build Java Thrift library" OFF)
if(ANDROID)
    find_package(Gradle QUIET)
    CMAKE_DEPENDENT_OPTION(BUILD_JAVA "Build Java library" ON
        "WITH_JAVA;GRADLE_FOUND" OFF)
else()
    find_package(Java QUIET)
    find_package(Ant QUIET)
    CMAKE_DEPENDENT_OPTION(BUILD_JAVA "Build Java library" ON
        "WITH_JAVA;JAVA_FOUND;ANT_FOUND" OFF)
endif()

# Common library options
option(WITH_SHARED_LIB "Build shared libraries" ON)
option(WITH_STATIC_LIB "Build static libraries" ON)
if (NOT WITH_SHARED_LIB AND NOT WITH_STATIC_LIB)
    message(FATAL_ERROR "Cannot build with both shared and static outputs disabled!")
endif()

#NOTE: C++ compiler options are defined in the lib/cpp/CMakeLists.txt

macro(MESSAGE_DEP flag summary)
    if(NOT ${flag})
        message(STATUS "   - ${summary}")
    endif()
endmacro(MESSAGE_DEP flag summary)

macro(PRINT_CONFIG_SUMMARY)
    message(STATUS "----------------------------------------------------------")
    message(STATUS "Build configuration Summary")
    message(STATUS "  Build with unit tests:                      ${BUILD_TESTING}")
    message(STATUS " Language libraries:")
    message(STATUS "  Build C++ library:                          ${BUILD_CPP}")
    MESSAGE_DEP(WITH_CPP "Disabled by WITH_CPP=OFF")
    MESSAGE_DEP(Boost_FOUND "Boost headers missing")
    message(STATUS "  Build C (GLib) library:                     ${BUILD_C_GLIB}")
    MESSAGE_DEP(WITH_C_GLIB "Disabled by WITH_C_GLIB=OFF")
    MESSAGE_DEP(GLIB_FOUND "GLib missing")
    message(STATUS "  Build Java library:                         ${BUILD_JAVA}")
    MESSAGE_DEP(WITH_JAVA "Disabled by WITH_JAVA=OFF")
    if(ANDROID)
        MESSAGE_DEP(GRADLE_FOUND "Gradle missing")
    else()
        MESSAGE_DEP(JAVA_FOUND "Java Runtime missing")
        MESSAGE_DEP(ANT_FOUND "Ant missing")
    endif()
    message(STATUS "  Build Python library:                       ${BUILD_PYTHON}")
    if(GEN_OUTPUT_PATH_PY)
        message(STATUS "  Python Build location:                      ${GEN_OUTPUT_PATH_PY}")
    endif()
    MESSAGE_DEP(WITH_PYTHON "Disabled by WITH_PYTHON=OFF")
    MESSAGE_DEP(PYTHONLIBS_FOUND "Python libraries missing")
    message(STATUS " Library features:")
    message(STATUS "  Build shared libraries:                     ${WITH_SHARED_LIB}")
    message(STATUS "  Build static libraries:                     ${WITH_STATIC_LIB}")
    message(STATUS "  Build with Boost static link library:       ${WITH_BOOST_STATIC}")
    message(STATUS "  Build with Boost thread support:            ${WITH_BOOSTTHREADS}")
    message(STATUS "  Build with boost/tr1/functional (forced)    ${WITH_BOOST_FUNCTIONAL}")
    message(STATUS "  Build with boost/smart_ptr (forced)         ${WITH_BOOST_SMART_PTR}")
    message(STATUS "  Build with C++ std::thread support:         ${WITH_STDTHREADS}")
    message(STATUS "  Build with ZLIB support:                    ${WITH_ZLIB}")
    message(STATUS "----------------------------------------------------------")
endmacro(PRINT_CONFIG_SUMMARY)

