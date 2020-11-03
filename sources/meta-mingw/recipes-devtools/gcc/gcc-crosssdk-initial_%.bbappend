DEPENDS_append_mingw32 = " nativesdk-mingw-w64-headers"
EXTRA_OECONF_remove_mingw32 = "--enable-initfini-array"
EXTRA_OECONF_append_mingw32 = " --disable-initfini-array"
