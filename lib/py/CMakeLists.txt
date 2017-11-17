set(DEL_MSG_LIB_PY Del.Messages.Py)
if(NOT GEN_OUTPUT_PATH_PY)
    set(GEN_OUTPUT_PATH_PY "${CMAKE_CURRENT_SOURCE_DIR}/thrift_gen_py")
endif()

#file(GLOB_RECURSE ${THRIFT_FILES} "${THRIFT_SRC_DIR}/*.thrift")
#add_custom_target(
#    RunBuildThriftPy ALL
#    DEPENDS ${THRIFT_FILES}
#    COMMAND ${CMAKE_COMMAND} -DTHRIFT_COMPILER=${THRIFT_COMPILER} -DBUILD_PY_SRC=${THRIFT_SRC_DIR} -DBUILD_PY_DEST=${GEN_OUTPUT_PATH_PY} -P ${CMAKE_SOURCE_DIR}/cmake/BuildThriftPy.cmake
#    COMMENT "Generating All Del.Messages Py Thrift Resources"
#)

thrift_gen_py(${THRIFT_SRC_DIR} ${GEN_OUTPUT_PATH_PY} YES)
add_custom_target(
    RunThriftGenPy ALL
    DEPENDS ${THRIFT_PY_FILES}
    COMMENT "Generating All Del.Messages Py Thrift Resources"
)

if(GEN_INSTALL_PATH_PY)
    install(DIRECTORY ${GEN_OUTPUT_PATH_PY}/ DESTINATION ${GEN_INSTALL_PATH_PY})
endif()
