gr-zcu106 Read Me

Follow the steps below to create a Yocto Linux image for Xilinx ZC106 platform with GNU radio built in the filesystem using OE meta-sdr layer

Build Instructions

1. Clone repo
2. Go to top-level directory
3. $ source setupsdk
4. $ MACHINE=zcu106-zynqmp bitbake petalinux-image-gr

This will kick off the build which should complete with 0 errors.

Deploy Instructions

Go to zcu-106-build/images/zcu106mp/deploy
Copy the following files to the SD card
Boot.bin (Rename from TBD)
Image (Rename from TBD)
rootfs.cpio.gz.u-boot (Rename from TBD)
system.dtb (TBD)
Insert SD card in ZC106 card

Power up ZCU106 card.

Once board is up and running, Halt at u-boot and run below command. ZynqMP> mmc dev 0 && mmcinfo && load mmc 0:1 0x80000 Image && load mmc 0:1 0x4000000 system.dtb && load mmc 0:1 0x6000000 rootfs.cpio.gz.u-boot && booti 0x80000 0x6000000 0x4000000

Board should boot correctly after this.
