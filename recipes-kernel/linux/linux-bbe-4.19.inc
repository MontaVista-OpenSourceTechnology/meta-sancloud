SECTION = "kernel"
DESCRIPTION = "Linux kernel for SanCloud BeagleBone devices"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

inherit kernel

require recipes-kernel/linux/cmem.inc
require recipes-kernel/linux/ti-uio.inc

# Look in the generic major.minor directory for files
FILESEXTRAPATHS_prepend = "${THISDIR}/linux-bbe-4.19:"

SRC_URI = "git://github.com/SanCloudLtd/linux.git;protocol=https;branch=${BRANCH}"

S = "${WORKDIR}/git"

do_configure_append() {
    oe_runmake -C ${S} O=${B} sancloud_bbe_defconfig
}

# Pull in the devicetree files into the rootfs & add run-time dependency for PM
# firmware to the rootfs
RDEPENDS_${KERNEL_PACKAGE_NAME}-base += "${KERNEL_PACKAGE_NAME}-devicetree amx3-cm3"
