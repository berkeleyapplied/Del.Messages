function(GenThriftPyOutput source_dir output_dir)
    if(NOT EXISTS ${output_dir})
        file(MAKE_DIRECTORY ${output_dir})
    endif()
    file(GLOB_RECURSE input_files "${source_dir}/*.thrift")
    foreach(input_file ${input_files})
        if(EXISTS ${input_file} AND ${input_file} MATCHES ".*thrift")
            exec_program(${THRIFT_COMPILER}
                ARGS -out ${output_dir} --gen py ${input_file}
                OUTPUT_VARIABLE __thrift_OUT
                RETURN_VALUE THRIFT_RETURN
            )
            message("thrift_gen_py: ${input_file}")
        else()
            message("thrift_gen_py: file ${input_file} does not exists")
        endif()
    endforeach()
endfunction()

if(BUILD_PY_SRC)
    if(NOT THRIFT_COMPILER)
        find_program(THRIFT_COMPILER thrift
            $ENV{THRIFT_HOME}/bin
            /usr/local/bin
            /usr/bin
            NO_DEFAULT_PATH
        )
    endif()
    if(NOT BUILD_PY_DEST)
        set(BUILD_PY_DEST ${CMAKE_CURRENT_SOURCE_DIR})
    endif()
    message("Running GenThriftPyOutput:")
    message("Compiler: ${THRIFT_COMPILER}")
    message("Source: ${BUILD_PY_SRC}")
    message("Dest: ${BUILD_PY_DEST}")
    GenThriftPyOutput(${BUILD_PY_SRC} ${BUILD_PY_DEST})
endif()

