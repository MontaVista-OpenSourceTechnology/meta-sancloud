PREFERRED_PROVIDER_virtual/kernel = "linux-mainline"
KBUILD_DEFCONFIG = "multi_v7_defconfig"
KCONFIG_MODE = "alldefconfig"
MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-devicetree"
