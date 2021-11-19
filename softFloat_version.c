#include "softFloat_version.h"

#define Q(str)    #str
#define QSTR(str) Q(str)

static const char* version_string = QSTR( VERS_STRING );

const char* softFloat_version() { return version_string; }
