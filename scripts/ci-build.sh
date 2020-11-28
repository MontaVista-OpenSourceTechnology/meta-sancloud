#! /bin/bash

set -euo pipefail

BUILD_SDK=no
BUILD_MASTER_NEXT=no
KERNEL_PROVIDER=
SITE_CONF=
KAS_INCLUDES="kas/inc/ci.yml"

usage() {
    echo "meta-sancloud CI build script"
    echo "Usage:"
    echo "    $0 [-s] [-n] [-k KERNEL] [-i SITE_CONF] [-h]"
    echo ""
    echo "    -s: Build an SDK as well as images."
    echo ""
    echo "    -n: Use the master-next branch of poky."
    echo ""
    echo "    -k KERNEL: Use an alternative kernel recipe"
    echo "        Valid values for KERNEL are 'mainline', 'stable', 'lts' and 'rt'."
    echo ""
    echo "    -i SITE_CONF: Use the given file to provide site-specific configuration."
    echo ""
    echo "    -h: Print this help message and exit".
}

while getopts ":snk:i:h" opt; do
    case $opt in
        s)
            BUILD_SDK=yes
            ;;
        n)
            BUILD_MASTER_NEXT=yes
            ;;
        k)
            KERNEL_PROVIDER=$OPTARG
            ;;
        i)
            SITE_CONF=`realpath $OPTARG`
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage >&2
            exit 1
            ;;
        :)
            echo "Option missing argument: -$OPTARG" >&2
            usage >&2
            exit 1
            ;;
    esac
done

echo ">>> Preparing for build"

if [[ "$BUILD_MASTER_NEXT" == "yes" ]]; then
    echo ">>> Enabling master-next branch of poky"
    KAS_INCLUDES="kas/inc/poky-next.yml:${KAS_INCLUDES}"
fi

if [[ -n "$KERNEL_PROVIDER" ]]; then
    echo ">>> Enabling kernel provider '$KERNEL_PROVIDER'"
    KAS_INCLUDES="kas/inc/kernel-${KERNEL_PROVIDER}.yml:${KAS_INCLUDES}"
fi

rm -rf images build
mkdir images build

if [[ -n "$SITE_CONF" ]]; then
    echo ">>> Linking '$SITE_CONF' as site configuration"
    mkdir build/conf
    ln -s "$SITE_CONF" build/conf/site.conf
fi

echo ">>> Building images"
kas build --update --force-checkout kas/bbe-poky.yml:$KAS_INCLUDES
cp  build/tmp/deploy/images/bbe/MLO \
    build/tmp/deploy/images/bbe/am335x-sancloud-bbe.dtb \
    build/tmp/deploy/images/bbe/core-image-base-bbe.wic.bmap \
    build/tmp/deploy/images/bbe/core-image-base-bbe.wic.xz \
    build/tmp/deploy/images/bbe/core-image-base.env \
    build/tmp/deploy/images/bbe/modules-bbe.tgz \
    build/tmp/deploy/images/bbe/u-boot.img \
    build/tmp/deploy/images/bbe/u-boot-initial-env \
    build/tmp/deploy/images/bbe/zImage \
    images

if [[ -e "build/tmp/deploy/images/bbe/am335x-sancloud-bbe-icu4.dtb" ]]; then
    cp build/tmp/deploy/images/bbe/am335x-sancloud-bbe-icu4.dtb images
fi

if [[ -e "build/tmp/deploy/images/bbe/am335x-sancloud-bbei-wifi.dtb" ]]; then
    cp build/tmp/deploy/images/bbe/am335x-sancloud-bbei-wifi.dtb images
fi

if [[ "$BUILD_SDK" == "yes" ]]; then
    echo ">>> Building SDK"
    kas build kas/bbe-sdk-poky.yml:$KAS_INCLUDES
    cp build/tmp/deploy/sdk/poky-*-core-image-base-*.sh images
fi
