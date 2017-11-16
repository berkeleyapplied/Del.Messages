# Project
project (del_messages)

#CMake
cmake_minimum_required (VERSION 3.2 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(DEL_MSG_LIB_PY Del.Messages.Py)
set(DEL_MSG_LIB_JAVA Del.Messages.Java)

set(THRIFT_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

# Find Thrift for reference
if (NOT THRIFT_FOUND)
	find_package(Thrift REQUIRED)
endif()

include(DefineOptions)

if(BUILD_TESTING)
	message(STATUS "Building with unittests")
	enable_testing()
	# Define "make check" as alias for "make test"
	#add_custom_target(check COMMAND ctest)
else ()
	message(STATUS "Building without tests")
endif ()

if(BUILD_CPP)
    message(STATUS "Building with C++")
	add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/cpp)
	if(BUILD_TESTING)
		add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/test/cpp)
	endif()
endif()

if(BUILD_C_GLIB)
    message(STATUS "Building with C GLIB")
	add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/c_glib)
endif()

if(BUILD_JAVA)
    message(STATUS "Building with JAVA")
	add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/java)
endif()

if(BUILD_PYTHON)
    message(STATUS "Building with Python")
	add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/py)
	if(BUILD_TESTING)
		add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/test/py)
	endif()
endif()

PRINT_CONFIG_SUMMARY()
