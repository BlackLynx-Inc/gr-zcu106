DESCRIPTION = "libGLES for ZynqMP with Mali 400"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://README.md;md5=d5750ae6496dd931669b454b5aaae2cd"

PROVIDES += "virtual/libgles1 virtual/libgles2 virtual/egl"
RPROVIDES_${PN} += "libGLESv2.so libEGL.so libGLESv1_CM.so libMali.so"

FILESEXTRAPATHS_append := " \
                ${THISDIR}/files: \
                ${THISDIR}/r5p1-01rel0: "

PV = "r5p1-01rel0"
SRC_URI = " \
    file://r5p1-01rel0.tar \
    file://egl.pc \
    file://glesv1_cm.pc \
    file://glesv1.pc \
    file://glesv2.pc \
    "

COMPATIBLE_MACHINE = "(-)"
COMPATIBLE_MACHINE_zynqmp = "(.*)"

S = "${WORKDIR}/${PV}"

X11RDEPENDS = "libxdamage libxext libx11 libdrm libxau libxcb libxdmcp libxfixes"
RDEPENDS_${PN} = " \
    mali-modules \
    ${@base_contains('DISTRO_FEATURES', 'x11', '${X11RDEPENDS}', '', d)}    \
    "

EGL_TYPE = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11',  \
            bb.utils.contains('DISTRO_FEATURES', 'fbdev',  'fbdev', '', d), d)}"

do_install() {
    # install headers
    install -d -m 0655 ${D}${includedir}/EGL
    install -m 0644 ${S}/${EGL_TYPE}/usr/include/EGL/*.h ${D}${includedir}/EGL/
    install -d -m 0655 ${D}${includedir}/GLES
    install -m 0644 ${S}/${EGL_TYPE}/usr/include/GLES/*.h ${D}${includedir}/GLES/
    install -d -m 0655 ${D}${includedir}/GLES2
    install -m 0644 ${S}/${EGL_TYPE}/usr/include/GLES2/*.h ${D}${includedir}/GLES2/
    install -d -m 0655 ${D}${includedir}/KHR
    install -m 0644 ${S}/${EGL_TYPE}/usr/include/KHR/*.h ${D}${includedir}/KHR/

    install -d ${D}${libdir}/pkgconfig
    install -m 0644 ${WORKDIR}/egl.pc ${D}${libdir}/pkgconfig/egl.pc
    install -m 0644 ${WORKDIR}/glesv2.pc ${D}${libdir}/pkgconfig/glesv2.pc
    install -m 0644 ${WORKDIR}/glesv1.pc ${D}${libdir}/pkgconfig/glesv1.pc
    install -m 0644 ${WORKDIR}/glesv1_cm.pc ${D}${libdir}/pkgconfig/glesv1_cm.pc

    install -d ${D}${libdir}
    cp -a ${S}/${EGL_TYPE}/usr/lib/*.so* ${D}${libdir}
}

# Inhibit warnings about files being stripped
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"

# These libraries shouldn't get installed in world builds unless something
# explicitly depends upon them.
EXCLUDE_FROM_WORLD = "1"
