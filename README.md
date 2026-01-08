# OpenWRT Docker Build and Publish

This project provides a GitHub Actions workflow that builds OpenWRT into Docker image to build your own OPKG packages.

## Docker Images
Docker images will be published to GitHub Packages under `ghcr.io/maksimkurb/openwrt-builder:<arch>`.

## Supported Architectures
- aarch64_cortex-a53 (GL.iNet Flint 2 / MT6000)

You can edit files in [.github/workflows/](.github/workflows/build-ci.yml) to add your own architectures. Also you will need to add config file to the [configs/](configs/) folder. See existing configs for reference how to create them.

## Supported OpenWRT versions
- 24.10
- 25.12

You can edit files in [.github/workflows/](.github/workflows/build-ci.yml) to add your own OpenWRT versions.

## Compiled packages
This repo compiles the following packages:
1. CUPS / Common UNIX Printing System (I've found p910nd unreliable with my HP LaserJet M1005 printer)

## License
This project is licensed under the GNU General Public License v2.0 - see the [LICENSE](LICENSE) file for details.
