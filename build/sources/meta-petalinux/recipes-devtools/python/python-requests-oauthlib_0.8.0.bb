LICENSE = "ISC"
LIC_FILES_CHKSUM = "file://LICENSE;md5=22d117a849df10d047ed9b792838e863"

SRC_URI[md5sum] = "4358a879a4377393bcfd37d0f9ae6d4d"
SRC_URI[sha256sum] = "883ac416757eada6d3d07054ec7092ac21c7f35cb1d2cf82faf205637081f468"

PYPI_PACKAGE = "requests-oauthlib"
inherit pypi setuptools

RDEPENDS_${PN} += "${PYTHON_PN}-requests"

