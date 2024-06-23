#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020, 2024 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message( STATUS "CMake version  '${CMAKE_VERSION}'" )
message( STATUS "Processing     '${CMAKE_CURRENT_LIST_FILE}'" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( CMAKE_VERSION VERSION_LESS  3.29 )
  message( FATAL_ERROR "
 CMake '3.29' or higher is required,
 You are running '${CMAKE_VERSION}'" )
endif()
cmake_minimum_required( VERSION ${CMAKE_VERSION} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( NOT DEFINED ENV{CMTOOLKIT} )
  message( FATAL_ERROR "
 unable to locate the cmToolKit directory" )
endif()

set( CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR} )
list( APPEND CMAKE_MODULE_PATH $ENV{CMTOOLKIT}/cmake/Modules )

set( TEMPL_SOURCE_PATH ${CMAKE_CURRENT_SOURCE_DIR} )
list( APPEND TEMPL_SOURCE_PATH $ENV{CMTOOLKIT}/cmake/Templates )

include( vDump OPTIONAL )
include( vDrop OPTIONAL )
include( vSnap OPTIONAL )
include( vTrace OPTIONAL )

set( VSNAP OFF )
set( VTRACE OFF)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# deprecate 'in-source' builds ( source directory/subdirectories )
# if You accidentally try an 'in-source' build
# You will have to manually clean up the leftovers :
# file 'CMakeCache.txt' and directory 'CMakeFiles'

set( CMAKE_DISABLE_IN_SOURCE_BUILD ON )
set( CMAKE_DISABLE_SOURCE_CHANGES  ON )

get_filename_component( _src "${CMAKE_CURRENT_SOURCE_DIR}" REALPATH )
string( TOLOWER "${_src}" _src )
vsnap( CMAKE_CURRENT_SOURCE_DIR _src )

get_filename_component( _bin "${CMAKE_CURRENT_BINARY_DIR}" REALPATH )
string( TOLOWER "${_bin}" _bin )
vsnap( CMAKE_CURRENT_BINARY_DIR _bin )

if( ${_bin} MATCHES ${_src}/build* )
  # special case for embedded builds
else()
  if( ( "${_bin}" STREQUAL "${_src}" ) OR
      ( "${_bin}" MATCHES  "${_src}/" ) )
    message( FATAL_ERROR "
 binary directory '${CMAKE_CURRENT_BINARY_DIR}'
 source directory '${CMAKE_CURRENT_SOURCE_DIR}'
 builds that modify the source directory/subdirectories are not allowed,
 remove file 'CMakeCache.txt' and directory 'CMakeFiles' " )
  endif( )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# must come before the project command
# lowest macOS supported 11.7.10 Big Sur
if( APPLE )
  set( CMAKE_OSX_DEPLOYMENT_TARGET 11.7.10 CACHE STRING  "" FORCE)
  add_compile_options( -Wunguarded-availability )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( PROJECT softfloat )
project( ${PROJECT} )
include( ${PROJECT}_PROJECT )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( APPLE AND BUILD_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_ARCHITECTURES arm64 x86_64 )
  # set( VERSION_STRING "${VERSION_STRING}-universal" )
endif()

message( STATUS "Building ${PROJECT} ${VERSION_STRING}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( CMAKE_C_STANDARD 17 )
set( CMAKE_C_STANDARD_REQUIRED YES )
set( CMAKE_CXX_STANDARD 17 )
set( CMAKE_CXX_STANDARD_REQUIRED YES )
set( CMAKE_POSITION_INDEPENDENT_CODE ON )
set( CMAKE_EXPORT_COMPILE_COMMANDS  ON )
set( CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup the install paths according to the GNU standards
include( GNUInstallDirs )
include( installDirectories )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${INST_BIN_DIR}" )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${INST_LIB_DIR}" )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${INST_LIB_DIR}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( BUILD_SHARED OFF )
set( BUILD_STATIC ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( ccache )

include( CheckIPOSupported )
check_ipo_supported( RESULT HAVE_IPO_SUPPORT )
if ( HAVE_IPO_SUPPORT )
  message( STATUS "IPO Supported and Enabled" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# include( threadLocalAttr OPTIONAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( ${PROJECT}_SPECS )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the libraries ( SHARED/STATIC )
include( buildLibraries )

foreach( library  ${PROVIDES} )

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

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( configureTemplates )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( ${PROJECT}_IS_TOP_LEVEL OR FORCE_INSTALL )
  set( INST_LIBS "")
  foreach( library  ${PROVIDES} )
    set( INST_LIBS "${INST_LIBS}-l${library} " )
  endforeach()
  string( STRIP "${INST_LIBS}" INST_LIBS )
endif()

if( ${PROJECT}_IS_TOP_LEVEL OR FORCE_INSTALL )
  configure_template( pkgconfig.pc.in ${PROJECT}.pc)
  if( HAVE_${PROJECT_UC}_PC )
    install( FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}.pc
      DESTINATION ${INST_LIB_DIR}/pkgconfig
    )

    if( INSTALL_LOCAL_PKGCONFIG )
    set( LOCAL_PKG_CONFIG_DIR $ENV{LOCAL_PKG_CONFIG_DIR} )
    install( FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}.pc
      DESTINATION ${LOCAL_PKG_CONFIG_DIR}
    )
    endif()
  endif()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( ${PROJECT}_IS_TOP_LEVEL OR FORCE_INSTALL )
  configure_template( pkgconfig.sh.in ${PROJECT}-config )
  if( HAVE_${PROJECT_UC}_CONFIG )
    install( FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}-config
      PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
                  GROUP_EXECUTE GROUP_READ
                  WORLD_EXECUTE WORLD_READ
      DESTINATION ${INST_BIN_DIR}
    )
  endif()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( ${PROJECT}_IS_TOP_LEVEL OR FORCE_INSTALL )
  configure_templates( cmake_uninstall.cmake )
  if( HAVE_CMAKE_UNINSTALL_CMAKE )
    add_custom_target( ${PROJECT}_uninstall
      COMMAND ${CMAKE_COMMAND}
        -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
    )
  endif()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
vdump( "${PROJECT}" "exit" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( ${PROJECT}_IS_TOP_LEVEL )
  include( configurationReport OPTIONAL )
endif()
