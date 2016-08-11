PROJECT (opensimplex)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6.0)

SET(CurrentProject ${CMAKE_PROJECT_NAME})
SET(Test_Executable "opensimplex-test")

IF ( NOT CPACK_GENERATOR )
	IF (WIN32)
		MESSAGE ("Setting NSIS installer for Windows.")
		SET(CPACK_GENERATOR NSIS)
	ELSE (WIN32)
		IF (APPLE)
			MESSAGE ("Setting Package Maker package for Mac OS X system.")
			# TODO
			
		ELSEIF (EXISTS /etc/debian_version)
			MESSAGE ("Setting DEB package for Debian based system.")
			SET(CPACK_GENERATOR DEB)
		ELSEIF (EXISTS /etc/redhat-release)
			MESSAGE ("Setting RPM package for RedHat based system.")
			SET(CPACK_GENERATOR RPM)
		ELSE ()
			MESSAGE ("Setting generic TGZ package for unknown system.")
			SET(CPACK_GENERATOR TGZ)
		ENDIF ()
	ENDIF (WIN32)
ENDIF ( NOT CPACK_GENERATOR )

SET(CPACK_PACKAGE_CONTACT "dgorst@gmail.com")

SET(CPACK_PACKAGE_NAME "opensimplex")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Port of Kurt Spencer's java implementation of open simplex noise to C")
SET(CPACK_PACKAGE_VERSION "1.1.2")
SET(CPACK_PACKAGE_VERSION_MAJOR "1")
SET(CPACK_PACKAGE_VERSION_MINOR "1")
SET(CPACK_PACKAGE_VERSION_PATCH "2")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
SET(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "open-simplex-in-c")
SET(CPACK_PACKAGE_EXECUTABLES ${Test_Executable} "Test of open simplex code.")
SET(CPACK_NSIS_MODIFY_PATH ON)

SET(CPACK_COMPONENT_TEST_APPLICATION_DISPLAY_NAME "Test Application")
SET(CPACK_COMPONENT_LIBRARY_DISPLAY_NAME "Library")
SET(CPACK_COMPONENT_HEADER_DISPLAY_NAME "C Header")

INCLUDE (CPack)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR} ./)
INCLUDE_DIRECTORIES ( ${INCLUDE_DIRECTORIES} ${CMAKE_SOURCE_DIR}/ )

FIND_PACKAGE ( ZLIB )

IF ( ZLIB_FOUND )
	FIND_PACKAGE ( PNG )

	IF (NOT PNG_FOUND)
		MESSAGE ( WARNING " Unable to find PNG library - tests will not be built." )
	ELSE (NOT PNG_FOUND)
		SET ( BUILD_TESTS 1 )
	ENDIF (NOT PNG_FOUND)
ELSE ( ZLIB_FOUND )
		MESSAGE ( WARNING " Unable to find ZLIB library - tests will not be built." )

ENDIF ( ZLIB_FOUND )

# Set the library name.

SET(CurrentProject ${CMAKE_PROJECT_NAME})
SET(Library "${CurrentProject}")
MESSAGE (STATUS "Setting library name as ${Library}")

# Library build details.

SET(HEADERS
	open-simplex-noise.h
)
SET(LIBRARY_SRCS
	open-simplex-noise.c
	
	# Headers
	
	${HEADERS}
)

SET(TEST_SRCS
	open-simplex-noise-test.c
)

ADD_LIBRARY(${Library} SHARED ${LIBRARY_SRCS})

TARGET_LINK_LIBRARIES (
        ${Library}
)

INSTALL (TARGETS ${Library} DESTINATION lib COMPONENT Library)
INSTALL (FILES ${HEADERS} DESTINATION include COMPONENT Headers)

IF ( BUILD_TESTS )

	MESSAGE ( INFO " Building tests " ${Test_Executable} )
	
	ADD_EXECUTABLE(${Test_Executable} ${TEST_SRCS} )

	TARGET_LINK_LIBRARIES (
		${Test_Executable}
		${Library}
 		${PNG_LIBRARY_RELEASE}
	)
	
	INSTALL (TARGETS ${Test_Executable} DESTINATION bin COMPONENT Tests)

ENDIF ( BUILD_TESTS )


