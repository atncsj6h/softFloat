#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright Enrico Sorichetti 2020 - 2021
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( STATUS "CMake version  '${CMAKE_VERSION}'" )
message( STATUS "Processing     '${CMAKE_CURRENT_LIST_FILE}'" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( CMAKE_VERSION VERSION_LESS  3.22 )
  message( FATAL_ERROR "
 CMake '3.22' or higher is required,
 You are running '${CMAKE_VERSION}'" )
endif()
cmake_minimum_required( VERSION ${CMAKE_VERSION} )

if( NOT DEFINED ENV{CMTK} )
  message( FATAL_ERROR "
 unable to locate the cmToolKit directory" )
endif()

set( CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR} )
list( APPEND CMAKE_MODULE_PATH "$ENV{CMTK}/cmake/Modules" )
set( TEMPL_SOURCE_DIR "$ENV{CMTK}/cmake/Templates" )

include( vDump )
include( vDrop )
include( vSnap )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# deprecate 'in-source' builds ( source directory/subdirectories )
# if You accidentally try an 'in-source' build
# You will have to manually clean up the leftovers :
# file 'CMakeCache.txt' and directory 'CMakeFiles'

set( CMAKE_DISABLE_IN_SOURCE_BUILD ON )
set( CMAKE_DISABLE_SOURCE_CHANGES  ON )

get_filename_component( _s "${CMAKE_SOURCE_DIR}" REALPATH )
string( TOLOWER "${_s}" _s )

get_filename_component( _b "${CMAKE_BINARY_DIR}" REALPATH )
string( TOLOWER "${_b}" _b )

if( ( "${_b}" STREQUAL "${_s}" ) OR
    ( "${_b}" MATCHES  "${_s}/" ) )
  message( FATAL_ERROR "
 binary directory '${CMAKE_BINARY_DIR}'
 source directory '${CMAKE_SOURCE_DIR}'
 builds that modify the source directory/subdirectories are not allowed,
 remove file 'CMakeCache.txt' and directory 'CMakeFiles' " )
endif( )

#[[ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  must come before the project command
  lowest macOS supported 10.13 High Sierra
#]]
if( APPLE AND BUILD_OSX_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_DEPLOYMENT_TARGET 10.13 CACHE STRING  "" FORCE)
  set( CMAKE_C_FLAGS   "-Wunguarded-availability" )
  set( CMAKE_CXX_FLAGS "-Wunguarded-availability" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( PROJECT softFloat )
set( VERSION 3.5 )
set( DESCRIPTION "Berkeley IEEE Binary Floating-Point Library" )
set( VARIANT "8086-SSE" )
project( ${PROJECT}
  VERSION ${VERSION}
  LANGUAGES C CXX )
set( VERSION_STRING "${VERSION}" )
set( VERSION_STRING "${VERSION_STRING}-${CMAKE_SYSTEM_PROCESSOR}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( SYSTEM_NAME "${CMAKE_HOST_SYSTEM_NAME}" )
string( TOUPPER "${SYSTEM_NAME}" SYSTEM_NAME_UC  )
set( "${SYSTEM_NAME_UC}" 1 )
add_compile_definitions(
  SYSTEM_NAME="${SYSTEM_NAME}"
  ${SYSTEM_NAME_UC}
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( APPLE AND BUILD_OSX_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_ARCHITECTURES arm64 x86_64 )
  set( VERSION_STRING "${VERSION_STRING}-universal" )
endif()

string( TIMESTAMP  BUILD_TIMESTAMP %Y/%m/%d-%H:%M:%S )
set( VERSION_STRING "${VERSION_STRING} ${BUILD_TIMESTAMP}" )

message( STATUS "Building ${PROJECT} ${VERSION_STRING}" )
add_compile_definitions(
  VERSION_STRING="${VERSION_STRING}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# arch/bits
math( EXPR HOST_ARCH "8 * ${CMAKE_SIZEOF_VOID_P}" OUTPUT_FORMAT DECIMAL)
if( NOT ( HOST_ARCH MATCHES 64 ) )
  message( SEND_ERROR "
 unsupported Architecture '${HOST_ARCH}-bits'" )
endif()
# message( STATUS "Building ${PROJECT} ${VERSION_STRING} '${HOST_ARCH}-bits'" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# endian-ness
if( NOT ( CMAKE_C_BYTE_ORDER STREQUAL "LITTLE_ENDIAN" ) )
  message( SEND_ERROR "
 unsupported Endian-ness '${CMAKE_C_BYTE_ORDER}'" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# cleanup the CMAKE_SYSTEM_PREFIX_PATH
if( APPLE )
  list(REMOVE_DUPLICATES CMAKE_SYSTEM_PREFIX_PATH )
  set( XPATHS /opt/homebrew /opt/macports /usr/X11R6 /usr/pkg /opt /sw )
  foreach( xpath ${XPATHS} )
    list( REMOVE_ITEM CMAKE_SYSTEM_PREFIX_PATH ${xpath} )
  endforeach()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   setup the proper install paths according to the GNU standards,
include( installDirectories )

set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_BIN_DIR}" )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_LIB_DIR}" )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_LIB_DIR}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# rpath handling
set( CMAKE_SKIP_BUILD_RPATH  FALSE )
set( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )
set( CMAKE_INSTALL_RPATH "@executable_path/../${INST_LIB_DIR}" )
set( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( CMAKE_POSITION_INDEPENDENT_CODE ON )
set( CMAKE_EXPORT_COMPILE_COMMANDS  ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
option( WITH_IPO      ""  ON )
option( WITH_CCACHE   ""  ON )

option( BUILD_SHARED  ""  ON )
option( BUILD_STATIC  ""  ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( WITH_IPO )
  include( CheckIPOSupported )
  check_ipo_supported( RESULT HAVE_IPO_SUPPORT )
  if ( HAVE_IPO_SUPPORT )
    message( STATUS "IPO is Supported and Enabled" )
  endif()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( WITH_CCACHE )
  include( ccache )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( CheckIncludeFile )
include( checkHeader )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# we assume that the system has the ISO/IEC headers and terminate if not
include( isoHeaders )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for __int128_t
include( checkType )
type_is_defined( __int128_t )
type_get_size( __int128_t )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# functions
include( CheckFunctionExists )
include( checkFunction )

# the builtins
include( __builtin_bswap )
include( __builtin_clz )

#

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# just to warn about some odd definitions
include( haveBrokenSizeMax )
include( fastTypesLengthsMatch )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# attributes
include( inlineAttr )
include( threadLocalAttr )
include( weakAttr )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the compiler flags
include( defaultCompilerFlags )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( ${PROJECT}_DEFS OPTIONAL )
include( ${PROJECT}_DIAG OPTIONAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_directories(
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/src/${VARIANT}
  ${CMAKE_SOURCE_DIR}/src/include
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   platform.h
if( EXISTS ${CMAKE_SOURCE_DIR}/platform.h.in )
  configure_file( ${CMAKE_SOURCE_DIR}/platform.h.in
    ${CMAKE_BINARY_DIR}/platform.h
  )
  add_compile_definitions(
    HAVE_PLATFORM_H )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   config.h
if( EXISTS ${CMAKE_SOURCE_DIR}/config.h.in )
  configure_file( ${CMAKE_SOURCE_DIR}/config.h.in
    ${CMAKE_BINARY_DIR}/config.h
  )
  add_compile_definitions(
    HAVE_CONFIG_H )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# sources
include( ${PROJECT}_SRCS )

# headers
include( ${PROJECT}_HDRS )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the libraries ( SHARED/STATIC )

set( ${PROJECT}_PROVIDES "${PROJECT}")

set( INST_LIBS "")
foreach( library  ${${PROJECT}_PROVIDES} )
  set( INST_LIBS "${INST_LIBS}-l${library} " )
endforeach()
string( STRIP "${INST_LIBS}"  INST_LIBS )

include( buildLibraries )

foreach( library  ${${PROJECT}_PROVIDES} )

  if( BUILD_SHARED OR BUILD_STATIC )
    build_headers( ${library} )
  endif()

  build_objects( ${library} )

  if( BUILD_SHARED )
    build_shared_library( ${library} )
  endif()

  if( BUILD_STATIC )
    build_static_library( ${library} )
  endif()

endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the pkgconfig control file ${PROJECT}.pc
include( buildPkgconfigPc OPTIONAL)
if( COMMAND build_pkgconfig_pc )
  build_pkgconfig_pc( ${PROJECT} )
endif()
if( COMMAND build_pkgconfig_sh )
  build_pkgconfig_sh( ${PROJECT} )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   the uninstaller
configure_file( $ENV{CMTK}/cmake/Templates/cmake_uninstall.cmake.in
  ${CMAKE_BINARY_DIR}/cmake_uninstall.cmake
  IMMEDIATE @ONLY )
add_custom_target( uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/cmake_uninstall.cmake )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( configurationReport )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
vdump( "main" "exit" )
