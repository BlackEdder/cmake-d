# Adding D unittests
#
#  Copyright (c) 2010 Jens Mueller <jens.k.mueller@gmx.de>
#
# All rights reserved.
#
# See LICENSE for details.
#

macro(add_unittests _sourcefile)

	set(_testname "${_sourcefile}")
	set(main_unittest "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/unittest.d")
	set(_source_file "${CMAKE_CURRENT_SOURCE_DIR}/${_sourcefile}")

	#message("main_unittest ${main_unittest}")
	#message("testname ${_testname}")
	#message("_sourcefile ${_source_file}")

	if(NOT EXISTS ${main_unittest})
		file(WRITE ${main_unittest} "// Generated by UseDUnittest.cmake\nint main() { return 0; }")
	endif()

	# TODO
	# better way to get the included directories
	get_directory_property(include_dirs INCLUDE_DIRECTORIES)
	set(INCLUDES )
	foreach(include_dir IN LISTS include_dirs)
		list(APPEND INCLUDES "${CMAKE_INCLUDE_FLAG_D}${include_dir}")
	endforeach()

	separate_arguments(CMAKE_D_FLAGS)

	add_test(NAME ${_testname}
	         COMMAND ${CMAKE_D_COMPILER} ${CMAKE_D_FLAGS} ${INCLUDES} ${main_unittest} -unittest -run ${_source_file})

endmacro(add_unittests)
