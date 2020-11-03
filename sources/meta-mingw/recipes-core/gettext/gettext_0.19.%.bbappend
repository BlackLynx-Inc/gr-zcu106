DEPENDS_append_mingw32 = " pthreads-win32"
LDFLAGS_prepend_mingw32 = " -lpthread "

CFLAGS_append_mingw32 = " -DLIBXML_STATIC"
EXTRA_OECONF_append_mingw32 = " --enable-threads=windows --enable-static"

FILESEXTRAPATHS_prepend_mingw32 := "${THISDIR}/${BPN}:"
SRC_URI_append_mingw32 = " \
		file://fix-gl_cv_prog_as_underscore-test.patch \
		"

FILES_libgettextlib_mingw32 = "${bindir}/libgettextlib-*.dll"
FILES_libgettextsrc_mingw32 = "${bindir}/libgettextsrc-*.dll"

PACKAGES_prepend_mingw32 = "libintl "
FILES_libintl_mingw32 = "${bindir}/libintl*.dll"

