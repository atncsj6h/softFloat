#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

# set( PROJECT softfloat )
string( TOUPPER "${PROJECT}" PROJECT_UC )

set( VERSION  3 )
set( RELEASE  5 )
set( MODLEVL  0 )
# let's set the revision/BLDLEVL to 0 for now
# will deal with that later for different SCMs ( subversion/git )
set( BLDLEVL  0 )

set( VERSION_TRIPLET "${VERSION}.${RELEASE}.${MODLEVL}" )
set( DESCRIPTION "Berkeley IEEE Binary Floating-Point Library" )

set( VERSION_STRING "${VERSION_TRIPLET}-${CMAKE_SYSTEM_PROCESSOR}" )
if( BUILD_UNIVERSAL_BINARIES )
  set( VERSION_STRING "${VERSION_STRING}-universal" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( PROVIDES  "${PROJECT}" )
set( REQUIRES  )
set( SOVERSION )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( VARIANT  "8086-SSE" )
set( SRCDIR   src )
set( IBMDIR   ibm )

set( IBM_IEEE OFF )
