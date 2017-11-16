set(DEL_MSG_LIB_PY Del.Messages.Py)
if(NOT GEN_OUTPUT_PATH_PY)
    set(GEN_OUTPUT_PATH_PY "${CMAKE_CURRENT_SOURCE_DIR}/thrift_gen_py")
endif()

#
# Remains of an older version - which globbed all files greedily (NOT OPTIMAL)
#
function(GenThriftPyOutput source_dir output_dir)
    set(THRIFT_PY_FILES "")
    if(NOT EXISTS ${output_dir})
        file(MAKE_DIRECTORY ${output_dir})
    endif()
    file(GLOB_RECURSE input_files "${source_dir}/*.thrift")
    foreach(input_file ${input_files})
        if(EXISTS ${input_file} AND ${input_file} MATCHES ".*\.thrift")
            exec_program(${THRIFT_COMPILER}
                ARGS -out ${output_dir} --gen py ${input_file}
                OUTPUT_VARIABLE __thrift_OUT
                RETURN_VALUE THRIFT_RETURN
            )
            file(GLOB_RECURSE THRIFT_PY_FILES_CUR "${output_dir}/*.py")
            file(GLOB_RECURSE THRIFT_PY_FILES_SKEL "${output_dir}/*skeleton*")
            file(GLOB_RECURSE THRIFT_PY_FILES_INIT "${output_dir}/*__init__*")
            if(THRIFT_PY_FILES_SKEL)
                list(REMOVE_ITEM THRIFT_PY_FILES_CUR ${THRIFT_PY_FILES_SKEL})
            endif()
            set(THRIFT_PY_FILES_DIFF ${THRIFT_PY_FILES_CUR})
            if(THRIFT_PY_FILES)
                list(REMOVE_ITEM THRIFT_PY_FILES_DIFF ${THRIFT_PY_FILES})
            endif()
            set(THRIFT_PY_FILES ${THRIFT_PY_FILES_CUR})
            add_custom_command(
                OUTPUT ${THRIFT_PY_FILES_DIFF}
                COMMAND ${THRIFT_COMPILER} -out "${output_dir}" --gen py ${input_file}
                DEPENDS ${input_file}
            )
            message("thrift_gen_py: ${input_file}")
            foreach(file ${THRIFT_PY_FILES_DIFF})
                message("                ${file}")
            endforeach()
        else()
            message("thrift_gen_py: file ${input_file} does not exists")
        endif()
    endforeach()
    set(THRIFT_PY_FILES ${THRIFT_PY_FILES} PARENT_SCOPE)
    add_custom_target(
        RunGenPyThriftOutput ALL
        DEPENDS ${THRIFT_PY_FILES}
        COMMENT "Generating All Del.Messages Py Thrift Resources"
    )
endfunction()

file(GLOB_RECURSE ${THRIFT_FILES} "${THRIFT_SRC_DIR}/*.thrift")
add_custom_target(
    RunBuildThriftPy ALL
    DEPENDS ${THRIFT_FILES}
    COMMAND ${CMAKE_COMMAND} -DTHRIFT_COMPILER=${THRIFT_COMPILER} -DBUILD_PY_SRC=${THRIFT_SRC_DIR} -DBUILD_PY_DEST=${GEN_OUTPUT_PATH_PY} -P ${CMAKE_SOURCE_DIR}/cmake/BuildThriftPy.cmake
    COMMENT "Generating All Del.Messages Py Thrift Resources"
)
