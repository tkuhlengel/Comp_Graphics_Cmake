# FindGLM - attempts to locate the glm matrix/vector library.
#
# This module defines the following variables (on success):
#   GLM_INCLUDE_DIRS  - where to find glm/glm.hpp
#   GLM_FOUND         - if the library was successfully located
#
# It is trying a few standard installation locations, but can be customized
# with the following variables:
#   GLM_ROOT_DIR      - root directory of a glm installation
#                       Headers are expected to be found in either:
#                       <GLM_ROOT_DIR>/glm/glm.hpp           OR
#                       <GLM_ROOT_DIR>/include/glm/glm.hpp
#                       This variable can either be a cmake or environment
#                       variable. Note however that changing the value
#                       of the environment varible will NOT result in
#                       re-running the header search and therefore NOT
#                       adjust the variables set by this module.

#=============================================================================
# Copyright 2012 Carsten Neumann
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)
# @rxc314 modified this to suit MVN environment
#IF(NOT EXISTS ${GLM_DIR})
#	find_package(GLM QUIET NO_MODULE)
#	mark_as_advanced(GLM_DIR)
#ENDIF()

#IF( EXISTS ${GLM_DIR})
#	SET(GLM_FOUND 1)	
#	MESSAGE(STATUS "GLM FOUND at ${GLM_DIR}")
#ELSEIF(GLM_FIND_REQUIRED)
#	MESSAGE(FATAL_ERROR  "GLM NOT FOUND")
#ENDIF()

#SET(GLM_ROOT_DIR ${GLM_DIR})
# default search dirs
SET(_glm_HEADER_SEARCH_DIRS
    "/usr/include"
    "/usr/local/include")

# check environment variable
SET(_glm_ENV_ROOT_DIR "$ENV{GLM_ROOT_DIR}")

IF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)
    SET(GLM_ROOT_DIR "${_glm_ENV_ROOT_DIR}")
ENDIF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)

# put user specified location at beginning of search
IF(GLM_ROOT_DIR)
    SET(_glm_HEADER_SEARCH_DIRS "${GLM_ROOT_DIR}"
                                "${GLM_ROOT_DIR}/include"
								"${CMAKE_CURRENT_SOURCE_DIR}/Includes"
								"${CMAKE_CURRENT_SOURCE_DIR}/Includes/glm"
                                 "${_glm_HEADER_SEARCH_DIRS}"
								 )
ENDIF(GLM_ROOT_DIR)

# locate header
FIND_PATH(GLM_INCLUDE_DIR "glm/glm.hpp"
    PATHS ${_glm_HEADER_SEARCH_DIRS})

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GLM DEFAULT_MSG
    GLM_INCLUDE_DIR)

IF(GLM_FOUND)
    SET(GLM_INCLUDE_DIRS "${GLM_INCLUDE_DIR}")

    MESSAGE(STATUS "GLM_INCLUDE_DIR = ${GLM_INCLUDE_DIR}")
ENDIF(GLM_FOUND)
