PROJECT (open-simplex-in-c)

INCLUDE (CPack)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6.0)

SET(CurrentProject ${CMAKE_PROJECT_NAME})
SET(Test_Executable "open-simplex-noise-test")

IF (WINDOWS)
	SET(CPACK_GENERATOR NSIS)
ELSE (WINDOWS)
	SET(CPACK_GENERATOR DEB)
ENDIF (WINDOWS)

SET(CPACK_PACKAGE_NAME "open-simplex-in-c")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Port of Kurt Spencer's java implementation of open simplex noise to C")
SET(CPACK_PACKAGE_VERSION "1.1.2")
SET(CPACK_PACKAGE_VERSION_MAJOR "1")
SET(CPACK_PACKAGE_VERSION_MINOR "1")
SET(CPACK_PACKAGE_VERSION_PATCH "2")
SET(CPACK_RESOURCE_FILE_LICENSE "./LICENSE")
SET(CPACK_RESOURCE_FILE_README "./README.md")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "open-simplex-in-c")
SET(CPACK_PACKAGE_EXECUTABLES ${Test_Executable} "Test of open simplex code.")
SET(CPACK_NSIS_MODIFY_PATH ON)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR} ./)
INCLUDE_DIRECTORIES ( ${INCLUDE_DIRECTORIES} ${CMAKE_SOURCE_DIR}/ )

FIND_PACKAGE ( PNG )

IF (NOT PNG_FOUND)
	MESSAGE ( WARNING " Unable to find PNG library - tests will not be built." )
ELSE (NOT PNG_FOUND)
	SET ( BUILD_TESTS 1 )
ENDIF (NOT PNG_FOUND)

# Set the library name.

SET(CurrentProject ${CMAKE_PROJECT_NAME})
SET(Library "${CurrentProject}")
MESSAGE (STATUS "Setting library name as ${Library}")

# Library build details.

SET(LIBRARY_SRCS
	open-simplex-noise.c
	
	# Headers
	
	open-simplex-noise.h
)

SET(TEST_SRCS
	open-simplex-noise-test.c
)

ADD_LIBRARY(${Library} ${LIBRARY_SRCS})

TARGET_LINK_LIBRARIES (
        ${Library}
)

IF ( BUILD_TESTS )

	MESSAGE ( INFO " Found PNG library - building " ${Test_Executable} )
	
	TARGET_LINK_LIBRARIES (
        ${Library}
        ${PNG_LIBRARY}
	)
	ADD_EXECUTABLE(${Test_Executable} ${TEST_SRCS} )

ENDIF ( BUILD_TESTS )


