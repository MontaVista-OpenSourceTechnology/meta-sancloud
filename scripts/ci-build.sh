#! /bin/bash

set -e

CONF=$1

mkdir images
IMAGES_DIR=`realpath images`

kas build --update --force-checkout kas/dev/${CONF}.yml:kas/inc/ci.yml

cd build/tmp/deploy/images/bbe
cp  MLO \
    am335x-sancloud-bbe.dtb \
    am335x-sancloud-bbe-icu4.dtb \
    am335x-sancloud-bbei-wifi.dtb  \
    core-image-base-bbe.wic.bmap \
    core-image-base-bbe.wic.xz \
    core-image-base.env \
    modules-bbe.tgz \
    u-boot.img \
    u-boot-initial-env \
    zImage \
    ${IMAGES_DIR}
