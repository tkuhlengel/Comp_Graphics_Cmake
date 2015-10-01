# Comp_Graphics_Cmake
Cmake files for Penn State's Computer Graphics Course, CMPSC458

Usable for Windows and Linux.  If anyone wants to fix them for XCode, let me know.

Directions:

Finding the Includes and Libraries should just work out of the box now for Win and Linux.

Linux Users: Make sure you've installed the proper packages for

GCC
CMake

SOIL
ASSIMP
GLFW
GLM
GLEW
an OpenGL implementation for your Machine.


Drop the files inside the Project2 Directory in the same directory as Project2.cpp.

Use CMake GUI and do an out of source build (set a different build directory from the source directory).
    1) Hit Configure
    2) Fix any problems or missing libraries/include directories
    3) Repeat 1 and 2 until no problems.
    4) Hit Generate

Note: I separated Project2.cpp into Project2.cpp and Project2.h, so you'll either have to edit the CMakeLists.txt file (starting at line 149) and comment out the Project2.h with a #, or you can add a dummy file for Project2.h

