# Copyright 2012 Cloudera Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# - Find Thrift (a cross platform RPC lib/tool)
# This module defines
#  THRIFT_VERSION, version string of ant if found
#  THRIFT_INCLUDE_DIR, where to find THRIFT headers
#  THRIFT_CONTRIB_DIR, where contrib thrift files (e.g. fb303.thrift) are installed
#  THRIFT_LIBS, THRIFT libraries
#  THRIFT_FOUND, If false, do not try to use ant

# prefer the thrift version supplied in THRIFT_HOME
message(STATUS "THRIFT_HOME: $ENV{THRIFT_HOME}")
find_path(THRIFT_INCLUDE_DIR thrift/Thrift.h HINTS
    $ENV{THRIFT_HOME}/include/
    /usr/local/include/
    /opt/local/include/
)

find_path(THRIFT_CONTRIB_DIR share/fb303/if/fb303.thrift HINTS
    $ENV{THRIFT_HOME}
    /usr/local/
)

set(THRIFT_LIB_PATHS
    $ENV{THRIFT_HOME}/lib
    /usr/local/lib
    /opt/local/lib
)

find_path(THRIFT_STATIC_LIB_PATH libthrift.a PATHS ${THRIFT_LIB_PATHS})

# prefer the thrift version supplied in THRIFT_HOME
find_library(THRIFT_LIB NAMES thrift HINTS ${THRIFT_LIB_PATHS})

find_program(THRIFT_COMPILER thrift
    $ENV{THRIFT_HOME}/bin
    /usr/local/bin
    /usr/bin
    NO_DEFAULT_PATH
)

if (THRIFT_LIB)
    set(THRIFT_FOUND TRUE)
    set(THRIFT_LIBS ${THRIFT_LIB})
    set(THRIFT_STATIC_LIB ${THRIFT_STATIC_LIB_PATH}/libthrift.a)
    if (THRIFT_COMPILER)
        exec_program(${THRIFT_COMPILER}
            ARGS -version OUTPUT_VARIABLE THRIFT_VERSION RETURN_VALUE THRIFT_RETURN)

        # define utility function to generate cpp files
        # modified from https://github.com/snikulov/cmake-modules/blob/master/FindThrift.cmake
        function(thrift_gen_cpp thrift_file output_dir base_dir THRIFT_CPP_FILES_LIST THRIFT_GEN_INCLUDE_DIR)
            set(_res)
            set(_res_inc_path)
            if(EXISTS ${thrift_file} AND ${thrift_file} MATCHES ".*\.thrift")
                get_filename_component(_target_base ${thrift_file} DIRECTORY)
                string(REGEX REPLACE "${base_dir}" "${output_dir}" _target_base ${_target_base})
                get_filename_component(_target_name ${thrift_file} NAME_WE)
                set(_target_dir "${_target_base}/${_target_name}")
                message("thrift_gen_cpp: ${thrift_file}")

                if(NOT EXISTS ${_target_dir})
                    file(MAKE_DIRECTORY ${_target_dir})
                endif()
                exec_program(${THRIFT_COMPILER}
                    ARGS -out "${_target_dir}" --gen cpp ${thrift_file}
                    OUTPUT_VARIABLE __thrift_OUT
                    RETURN_VALUE THRIFT_RETURN)
                file(GLOB_RECURSE __result_src "${_target_dir}/*.cpp")
                file(GLOB_RECURSE __result_hdr "${_target_dir}/*.h")
                file(GLOB_RECURSE __result_skel "${_target_dir}/*skeleton*")
                if(__result_skel)
                    list(REMOVE_ITEM __result_src ${__result_skel})
                endif()
                list(APPEND _res ${__result_src})
                list(APPEND _res ${__result_hdr})
                if(__result_hdr)
                    list(GET __result_hdr 0 _res_inc_path)
                    get_filename_component(_res_inc_path ${_res_inc_path} DIRECTORY)
                endif()
                add_custom_command(
                    OUTPUT ${_res}
                    COMMAND ${THRIFT_COMPILER} -out "${_target_dir}" --gen cpp ${thrift_file}
                    DEPENDS ${thrift_file}
                )
            else()
                message("thrift_gen_cpp: file ${thrift_file} does not exists")
            endif()
            set(${THRIFT_CPP_FILES_LIST} "${_res}" PARENT_SCOPE)
            set(${THRIFT_GEN_INCLUDE_DIR} "${_res_inc_path}" PARENT_SCOPE)
        endfunction()
    endif ()
else ()
    set(THRIFT_FOUND FALSE)
endif ()

if (THRIFT_FOUND)
    if (NOT THRIFT_FIND_QUIETLY)
        message(STATUS "Thrift version: ${THRIFT_VERSION}")
    endif ()
else ()
    message(STATUS "Thrift compiler/libraries NOT found. "
        "Thrift support will be disabled (${THRIFT_RETURN}, "
        "${THRIFT_INCLUDE_DIR}, ${THRIFT_LIB})")
endif ()


mark_as_advanced(
    THRIFT_LIB
    THRIFT_COMPILER
    THRIFT_INCLUDE_DIR
)
