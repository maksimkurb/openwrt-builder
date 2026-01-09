#!/bin/bash

set -e -x

# Install custom feed
cat /home/me/openwrt/feeds.conf.default > /home/me/openwrt/feeds.conf
cat /home/me/openwrt/owrt-packages/packages.feed >> /home/me/openwrt/feeds.conf

# Copy configuration files
cp /home/me/openwrt/router.config /home/me/openwrt/.config

# Update feeds
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds uninstall -a
./scripts/feeds install bzip2
./scripts/feeds install -a -p custom -d m

make defconfig

# Add other package compilation instructions below
# make -j$(nproc) package/compile
