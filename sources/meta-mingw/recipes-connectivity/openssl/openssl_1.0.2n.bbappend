FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_mingw32 = " file://mingw-targets.patch"

EXTRA_LIBS_mingw32 = "-lws2_32 -lgdi32 -lcrypt32 -lgcc"

CFLAG_remove_mingw32 = " -DTERMIO"
CFLAG_remove_mingw32 = " -DHAVE_CRYPTODEV"
CFLAG_remove_mingw32 = " -Wa,--noexecstack"
CFLAG_append_mingw32 = " -DNOCRYPT -mno-cygwin -DWIN32_LEAN_AND_MEAN" 

do_compile_prepend_mingw32 () {
	export EX_LIBS="${EXTRA_LIBS}"
}

do_install_prepend_mingw32 () {
	export EX_LIBS="${EXTRA_LIBS}"
}

