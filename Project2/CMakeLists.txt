


cmake_minimum_required(VERSION 3.0)




if (POLICY CMP0020)
	cmake_policy(SET CMP0020 OLD)
	IF(CMAKE_MAJOR_VERSION VERSION_GREATER "2")
		#For cmake version 3
#		cmake_policy(SET CMP0043 OLD)
#		cmake_policy(SET CMP0054 OLD)
	ENDIF()
endif()

# Create a target for the library
# On MSVC platforms, CMake will add the following preprocessor definition for you.
# <LIBRARY_NAME>_EXPORTS
set(TARGET_NAME Project2)



project(${TARGET_NAME})
message(STATUS "AT " ${TARGET_NAME})

LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_PREFIX})
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/CMake)

###############################################################################
# All 3rd-party libraries go here.
###############################################################################
find_package(OpenMP)
if (OPENMP_FOUND)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")	
endif()
find_package(OpenGL REQUIRED)
if(OPENGL_FOUND)
    include_directories(${OPENGL_INCLUDE_DIR})
    #link_libraries(${OPENGL_gl_LIBRARY} ${OPENGL_glu_LIBRARY})
endif()

find_package(GLM REQUIRED)
if (GLM_FOUND)
	include_directories(${GLM_INCLUDE_DIRS})
endif()

# Need glew32
find_package(GLEW REQUIRED)
if (GLEW_FOUND)
    include_directories(${GLEW_INCLUDE_DIR})
    #link_libraries(${GLEW_LIBRARIES})
endif()

find_package(GLFW REQUIRED)
if (GLFW_FOUND)
	include_directories(${GLFW_INCLUDE_DIR})
endif()
find_package(SOIL REQUIRED)
if (SOIL_FOUND)
	include_directories(${SOIL_INCLUDE_DIRS})
	#link_libraries(${SOIL_LIBRARIES})
endif()

find_package(ASSIMP REQUIRED)
if (ASSIMP_FOUND)
    include_directories(${ASSIMP_INCLUDE_DIRS})
    #link_libraries(${ASSIMP_LIBRARIES})
else ()
	MESSAGE("ASSIMP Library/Includes missing")
endif()

#if(UNIX)
#    find_package(ZLIB REQUIRED)
#    if(ZLIB_FOUND)
#        include_directories(${ZLIB_INCLUDE_DIRS})
#        link_libraries(${ZLIB_LIBRARIES})
#    endif(ZLIB_FOUND)
#endif(UNIX)

find_package(OpenGL)
if (OPENGL_FOUND)
   MESSAGE("OpenGL Found")
   include_directories(${OPENGL_INCLUDE_DIR})
else (OPENGL_FOUND)
   MESSAGE("OpenGL environment missing")
endif (OPENGL_FOUND)

#make VERBOSE=1
file(GLOB_RECURSE RES_FILES "shaders/*.*")
file(GLOB_RECURSE RES_FILES "skybox/*.*")
file(GLOB_RECURSE RES_FILES "textures/*.*")
file(GLOB_RECURSE RES_FILES "objects/*.*")
file(GLOB_RECURSE RES_FILES "splines/*.*")
file(GLOB	RES_FILES	"track")

if (MSVC)
	ADD_DEFINITIONS("/D_CRT_SECURE_NO_WARNINGS")
	ADD_DEFINITIONS("/D_SCL_SECURE_NO_WARNINGS")
	ADD_DEFINITIONS(/DWINVER=0x0601)
	###############################################################################
        # Set windows resource files
        ###############################################################################
        set(RESOURCE_FILES  Project2.rc)
        file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/shaders/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/skybox/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/textures/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/objects/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/points/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		#set(RESOURCE_FILES ${RESOURCE_FILES} ${RES_FILES})
		file(GLOB_RECURSE RES_FILES "${CMAKE_SOURCE_DIR}/splines/*")
		LIST(APPEND RESOURCE_FILES ${RES_FILES})
		file(GLOB	RES_FILES	"${CMAKE_SOURCE_DIR}/track*")
		
		LIST(APPEND RESOURCE_FILES${RES_FILES})
		#set(RESOURCE_FILES Project2.rc ${RES_FILES})
		#file(COPY ${CMAKE_SOURCE_DIR}/libs-vc12/ DESTINATION ${PROJECT_BINARY_DIR}/track)
        source_group("Resource Files" FILES ${RESOURCE_FILES})
	#add_custom_command(
	# OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/track
	 #COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/track  ${CMAKE_CURRENT_BINARY_DIR}/track
	# DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/track
	#)
else ()
    file(COPY ${CMAKE_SOURCE_DIR}/shaders/ DESTINATION ${PROJECT_BINARY_DIR}/shaders/)
    file(COPY ${CMAKE_SOURCE_DIR}/skybox/ DESTINATION ${PROJECT_BINARY_DIR}/skybox/)
    file(COPY  ${CMAKE_SOURCE_DIR}/textures/ DESTINATION ${PROJECT_BINARY_DIR}/textures/)
    file(COPY  ${CMAKE_SOURCE_DIR}/splines/ DESTINATION ${PROJECT_BINARY_DIR}/splines/)
    file(COPY  ${CMAKE_SOURCE_DIR}/objects/ DESTINATION ${PROJECT_BINARY_DIR}/objects/)
	file(COPY ${CMAKE_SOURCE_DIR}/track DESTINATION ${PROJECT_BINARY_DIR}/)
	
endif(MSVC)



#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/Release)
#add_executable(mybin ${Headers} ${Sources})
###############################################################################
# Add source files
###############################################################################
set(SOURCE_FILES
	${SOURCE_FILES}
	${RESOURCE_FILES}
	Camera.h
	#resource.h
	Mesh.h
	Model.h
	rc_spline.cpp
	rc_spline.h
	shader.h
	
	Project2.h
	Project2.cpp
	
	util_vectors.h
)

###############################################################################
# Update source files for the add_executable command
###############################################################################
set(SOURCE_FILES ${SOURCE_FILES} ${GEN_OUT_FILES})


###############################################################################
# create an executable
###############################################################################
add_executable(${TARGET_NAME} ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(${TARGET_NAME} 
    ${OPENGL_LIBRARIES} 
    #${OPENGL_glu_LIBRARY}
    ${GLEW_LIBRARIES}
    ${GLFW_LIBRARIES} 
    ${SOIL_LIBRARIES}
    ${ASSIMP_LIBRARY}
    )


# Organize target into a group in Visual Studio IDE
IF (DEFINED TARGET_FOLDER)
	set_property(TARGET ${TARGET_NAME} PROPERTY FOLDER ${TARGET_FOLDER})
ENDIF()

###############################################################################
# Put common libraries here
###############################################################################
# target_link_libraries(${TARGET_NAME} glew32.lib)

###############################################################################
# All 3rd-party target_link_libraries go here.
###############################################################################


# Common libraries required
#target_link_libraries(${TARGET_NAME} opengl32.lib glu32.lib)
#target_link_libraries(${TARGET_NAME} opengl32.lib)


###############################################################################
# Check if C++0x and C++11 are supported on Unix
###############################################################################
# Initialize CXXFLAGS.
if(UNIX)
    set(CMAKE_CXX_FLAGS                "-Wall -std=c++11")
    #set(CMAKE_CXX_FLAGS_DEBUG          "-O0 -g")
    set(CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")

    # Compiler-specific C++11 activation.
    if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
        execute_process(
            COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
        if (NOT (GCC_VERSION VERSION_GREATER 4.7 OR GCC_VERSION VERSION_EQUAL 4.7))
            message(FATAL_ERROR "${PROJECT_NAME} requires g++ 4.7 or greater.")
        endif ()
    elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
    else ()
        message(FATAL_ERROR "Your C++ compiler does not support C++11.")
    endif ()
    # Finalize target libraries
    #mf_end_use(${TARGET_NAME})
ENDIF (UNIX)
