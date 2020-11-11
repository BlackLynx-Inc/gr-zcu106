# Disable default x11 support
PACKAGECONFIG_class-nativesdk_mingw32 = ""

FILES_${PN}-bin_mingw32 = "${bindir}/*.exe ${sbindir}/*.exe"
