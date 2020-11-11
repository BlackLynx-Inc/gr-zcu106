DESCRIPTION = "Runtime libraries from MinGW-w64 project"
LICENSE = "ZPL-2.1"
LIC_FILES_CHKSUM = "file://../COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"

COMPATIBLE_HOST = ".*-mingw.*"

SRC_URI = "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${PV}.tar.bz2"
SRC_URI[md5sum] = "df0e7657f46cbd59ed9cbe2a50c66e15"
SRC_URI[sha256sum] = "ece7a7e7e1ab5e25d5ce469f8e4de7223696146fffa71c16e2a9b017d0e017d2"

S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
B = "${WORKDIR}/build-${TARGET_SYS}"

inherit autotools nativesdk

INHIBIT_DEFAULT_DEPS = "1"
DEPENDS = "nativesdk-mingw-w64-headers virtual/${TARGET_PREFIX}gcc-initial "

PROVIDES += "virtual/nativesdk-libc"
PROVIDES += "virtual/nativesdk-${SDK_PREFIX}libc-initial"
PROVIDES += "virtual/nativesdk-${SDK_PREFIX}libc-for-gcc"

# Work around pulling in eglibc for now...
PROVIDES += "virtual/nativesdk-libintl"

STAGINGCC = "gcc-cross-initial-${TARGET_ARCH}"
STAGINGCC_class-nativesdk = "gcc-crosssdk-initial-${SDK_SYS}"
TOOLCHAIN_OPTIONS = " --sysroot=${STAGING_DIR_TARGET}"
PATH_prepend = "${STAGING_BINDIR_TOOLCHAIN}.${STAGINGCC}:"

do_configure() {
    oe_runconf
}

FILES_${PN} += "${exec_prefix}/libsrc"

