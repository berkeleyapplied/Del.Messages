set(DEL_MSG_LIB_CPP Del.Messages.Cpp)
set(GEN_OUTPUT_PATH_CPP "${CMAKE_CURRENT_SOURCE_DIR}/thrift_gen_cpp")

function(GenThriftOutput source_dir output_dir)
    set(THRIFT_SRC_FILES "")
    set(THRIFT_INC_DIRS "")
    if(EXISTS ${output_dir})
        file(REMOVE_RECURSE ${output_dir})
    endif()
    file(GLOB_RECURSE input_files "${source_dir}/*.thrift")
    foreach(input_file ${input_files})
        thrift_gen_cpp(${input_file} ${GEN_OUTPUT_PATH_CPP} ${THRIFT_SRC_DIR} _src _inc)
        list(APPEND THRIFT_SRC_FILES ${_src})
        list(APPEND THRIFT_INC_DIRS ${_inc})
    endforeach()
    set(THRIFT_SRC_FILES ${THRIFT_SRC_FILES} PARENT_SCOPE)
    set(THRIFT_INC_DIRS  ${THRIFT_INC_DIRS}  PARENT_SCOPE)
    add_custom_target(
        RunGenThriftOutput ALL
        DEPENDS ${THRIFT_SRC_FILES}
        COMMENT "Generating All Del.Messages Thrift Resources"
    )
endfunction()

GenThriftOutput(${THRIFT_SRC_DIR} ${GEN_OUTPUT_PATH_CPP})

add_library(${DEL_MSG_LIB_CPP} STATIC ${THRIFT_SRC_FILES})
add_dependencies(${DEL_MSG_LIB_CPP} RunGenThriftOutput)
# Require C++11
set_target_properties(
    ${DEL_MSG_LIB_CPP}
    PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_include_directories(
    ${DEL_MSG_LIB_CPP}
    PUBLIC
    ${THRIFT_INC_DIRS}
)
