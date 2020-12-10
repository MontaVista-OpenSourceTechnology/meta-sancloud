# Yocto BSP layer for the SanCloud boards

## Quick links

[<img align=right src="https://www.sancloud.com/wp-content/uploads/2016/09/sancloud_and_address_web.png">](https://www.sancloud.com/)

* [SanCloud website](https://www.sancloud.com/)

* [BeagleBone Enhanced Description](https://www.sancloud.com/beaglebone-enhanced-bbe)

* [Sancloud repositories on GitHub](https://github.com/SanCloudLtd)

## Description

This is the Yocto Project Board Support Package (BSP) layer for SanCloud devices.

Currently supported hardware with corresponding Yocto Project MACHINE names:

* `bbe`: Sancloud BeagleBone Enhanced (BBE)

This BSP layer supports the following configurations:

* Poky Reference Distribution

For Arago distribution and Automotive Grade Linux (AGL) support please see
the [dunfell branch](https://github.com/SanCloudLtd/meta-sancloud/tree/dunfell)
or any of the [tagged releases](https://github.com/SanCloudLtd/meta-sancloud/releases)
of this layer.

## Getting started with Poky

This BSP layer includes build configuration files for use with the kas build
tool (https://github.com/siemens/kas). The kas tool can be installed by running
`pip install kas` as long as you have a recent Python version.

To use kas to build the Poky distro for the BBE, run the following command in
the top directory of this repository:

    kas build kas/bbe-poky.yml

The build configuration files in the kas directory can be used as the basis of
further customisation and integration work. It's recommended to copy the build
configuration files into your own repository (adding a `url:` entry for the
meta-sancloud layer) and work there so that your changes can be tracked
separately from future BSP updates in this repository.

### Building an SDK

This BSP also supports building a Software Development Kit (SDK) for the Poky
distribution. To use kas to build the SDK, run the following command in the
top directory of this repository:

    kas build kas/bbe-sdk-poky.yml

## Support

Issues and Pull Requests for this BSP layer may be opened on our primary
GitHub repository at https://github.com/SanCloudLtd/meta-sancloud.

For further support enquiries please contact us via email to yocto@sancloud.com.
