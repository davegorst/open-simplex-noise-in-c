#
# Try to find Open Simplex library and include path.
# Once done this will define
#
# OPENSIMPLEX_FOUND
# OPENSIMPLEX_INCLUDE_PATH
# OPENSIMPLEX_LIBRARY
# 

IF (WIN32)
	FIND_PATH( OPENSIMPLEX_INCLUDE_DIR open-simplex-noise.h
		$ENV{PROGRAMFILES}/OpenSimplex/include
		$ENV{OPENSIMPLEX_DIR}/
		DOC "The OpenSimplex header file")
	FIND_LIBRARY( OPENSIMPLEX_LIBRARY
		NAMES opensimplex
		PATHS
		$ENV{PROGRAMFILES}/OpenSimplex/lib
		$ENV{OPENSIMPLEX_DIR}/
		DOC "The OpenSimplex library")
ELSE (WIN32)
	FIND_PATH( OPENSIMPLEX_INCLUDE_DIR open-simplex-noise.h
		/usr/include
		/usr/local/include
		/sw/include
		/opt/local/include
		DOC "The OpenSimplex header file")
	FIND_LIBRARY( OPENSIMPLEX_LIBRARY
		NAMES opensimplex OpenSimplex
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		DOC "The OpenSimplex library")
ENDIF (WIN32)

IF (OPENSIMPLEX_INCLUDE_DIR)
	SET( OPENSIMPLEX_FOUND 1 CACHE STRING "Set to 1 if OpenSimplex is found, 0 otherwise")
ELSE (OPENSIMPLEX_INCLUDE_DIR)
	SET( OPENSIMPLEX_FOUND 0 CACHE STRING "Set to 1 if OpenSimplex is found, 0 otherwise")
ENDIF (OPENSIMPLEX_INCLUDE_DIR)

MARK_AS_ADVANCED( OPENSIMPLEX_FOUND )
