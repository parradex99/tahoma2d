# looks for libtiff(4.2.0 modified)
#
# Configures and builds the modified libtiff library
execute_process(COMMAND ./configure --with-pic --disable-jbig --disable-webp WORKING_DIRECTORY ${SDKROOT}/tiff-4.2.0)
execute_process(COMMAND make WORKING_DIRECTORY ${SDKROOT}/tiff-4.2.0)
find_path(
    TIFF_INCLUDE_DIR
    NAMES
        tiffio.h
    HINTS
        ${SDKROOT}
    PATH_SUFFIXES
        tiff-4.2.0/libtiff/
# if mono or another framework with a tif library
# is installed, ignore it.
if(BUILD_ENV_APPLE)
    NO_DEFAULT_PATH
    NO_CMAKE_ENVIRONMENTPATH
    NO_CMAKE_PATH
endif()
)

find_library(
    TIFF_LIBRARY
    NAMES
        libtiff.a
    HINTS
        ${SDKROOT}
    PATH_SUFFIXES
        tiff-4.2.0/libtiff/.libs
    NO_DEFAULT_PATH
)

message("***** libtiff Header path:" ${TIFF_INCLUDE_DIR})
message("***** libtiff Library path:" ${TIFF_LIBRARY})

set(TIFF_NAMES ${TIFF_NAMES} TIFF)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(TIFF
    DEFAULT_MSG TIFF_LIBRARY TIFF_INCLUDE_DIR)

if(TIFF_FOUND)
    set(TIFF_LIBRARIES ${TIFF_LIBRARY})
endif()

mark_as_advanced(
    TIFF_LIBRARY
    TIFF_INCLUDE_DIR
)
