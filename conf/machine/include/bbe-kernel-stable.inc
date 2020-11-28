require conf/machine/include/bbe-kernel-stable.inc
PREFERRED_PROVIDER_virtual/kernel_bbe = "linux-stable"
KERNEL_DEVICETREE += " \
    am335x-sancloud-bbei-wifi.dtb \
    am335x-sancloud-bbe-icu4.dtb \
    "
