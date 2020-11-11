DEFAULTTUNE ?= "aarch64"
SOC_FAMILY ?= "zynqmp"

require conf/machine/include/arm/arch-armv8.inc
require conf/machine/include/soc-family.inc

# Linux Configuration
KERNEL_IMAGETYPE ?= "Image"

# KMACHINE
KMACHINE ?= "zynqmp"

XSERVER_append = "xf86-video-armsoc"

PREFERRED_PROVIDER_virtual/libgles1 = "libmali-xlnx"
PREFERRED_PROVIDER_virtual/libgles2 = "libmali-xlnx"
PREFERRED_PROVIDER_virtual/egl = "libmali-xlnx"
