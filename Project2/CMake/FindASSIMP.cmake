IF(UNIX)
    FIND_PATH(
      ASSIMP_INCLUDE_DIRS
      NAMES postprocess.h scene.h version.h config.h cimport.h
      PATHS 
        /usr/include/
        /usr/local/include/
        /usr/include/assimmp/
        /usr/local/include/assimp/
    )

    FIND_LIBRARY(
      ASSIMP_LIBRARY
      NAMES assimp
      PATHS 
        /usr/local/lib/
        /usr/lib/
    )
ELSE ()
    IF(MSVC)
        FIND_PATH(
          ASSIMP_INCLUDE_DIRS
          NAMES postprocess.h scene.h version.h config.h cimport.h
          PATHS ${CMAKE_SOURCE_DIR}/Includes/assimp
        )

        FIND_LIBRARY(
          ASSIMP_LIBRARY
          NAMES assimp
          PATHS ${CMAKE_SOURCE_DIR}/libs-vc12
        )
    ENDIF(MSVC)
ENDIF(UNIX)

IF (ASSIMP_INCLUDE_DIRS AND ASSIMP_LIBRARY)
  SET(ASSIMP_FOUND TRUE)
  MESSAGE("FOUND ASSIMP")
ENDIF (ASSIMP_INCLUDE_DIRS AND ASSIMP_LIBRARY)

IF (ASSIMP_FOUND)
  IF (NOT ASSIMP_FIND_QUIETLY)
    MESSAGE(STATUS "Found asset importer library: ${ASSIMP_LIBRARY}")
  ENDIF (NOT ASSIMP_FIND_QUIETLY)
ELSE (ASSIMP_FOUND)
  IF (ASSIMP_FIND_REQUIRED)
    MESSAGE(FATAL_ERROR "Could not find asset importer library")
  ENDIF (ASSIMP_FIND_REQUIRED)
ENDIF (ASSIMP_FOUND)
