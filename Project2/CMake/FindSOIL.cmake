# Find SOIL
# Find the SOIL includes and library
#
#  SOIL_INCLUDE_DIRS - where to find SOIL.h, etc.
#  SOIL_LIBRARIES    - List of libraries when using SOIL.
#  SOIL_FOUND        - True if SOIL found.
#
# Based on the FindZLIB.cmake module.

if(MSVC)
    FIND_PATH( SOIL_INCLUDE_DIRS 
        SOIL.h 
        PATHS
        /usr/include 
        /usr/local/include 
        $ENV{INCLUDE} 
        ${CMAKE_CURRENT_SOURCE_DIR}/Includes
        )
    FIND_LIBRARY( SOIL_LIBRARIES NAMES SOIL soil
	PATHS 
            ${CMAKE_CURRENT_SOURCE_DIR}/Libs-vc13
            ${CMAKE_CURRENT_SOURCE_DIR}/Libs-vc12
            ${CMAKE_CURRENT_SOURCE_DIR}/Libs-vc10
        )


else ()
if (UNIX)
    FIND_PATH( SOIL_INCLUDE_DIRS 
        NAMES SOIL.h 
        HINTS
        $ENV{INCLUDE} 

        PATHS
        /usr/include 
        /usr/include/SOIL
        /usr/local/include 
        /usr/local/include/SOIL
    )
    FIND_LIBRARY( SOIL_LIBRARIES 
        NAMES SOIL soil
	PATHS 
            /usr/lib 
            /usr/local/lib 
    )
endif(UNIX)

endif(MSVC)

IF(SOIL_INCLUDE_DIRS)
	MESSAGE(STATUS "Found SOIL include dir: ${SOIL_INCLUDE_DIRS}")
ELSE(SOIL_INCLUDE_DIRS)
	MESSAGE(STATUS "Could NOT find SOIL headers.")
ENDIF(SOIL_INCLUDE_DIRS)

IF(SOIL_LIBRARIES)
	MESSAGE(STATUS "Found SOIL library: ${SOIL_LIBRARIES}")
ELSE(SOIL_LIBRARIES)
	MESSAGE(STATUS "Could NOT find SOIL library.")
ENDIF(SOIL_LIBRARIES)

IF(SOIL_INCLUDE_DIRS AND SOIL_LIBRARIES)
	SET(SOIL_FOUND "YES")
ELSE(SOIL_INCLUDE_DIRS AND SOIL_LIBRARIES)
	SET(SOIL_FOUND "NO")
	IF(SOIL_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "Could not find SOIL. Please install SOIL")
	ENDIF(SOIL_FIND_REQUIRED)
ENDIF(SOIL_INCLUDE_DIRS AND SOIL_LIBRARIES)
