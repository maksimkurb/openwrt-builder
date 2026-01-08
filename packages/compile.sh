#!/bin/bash

set -e -x

# Copy configuration files
cp /home/me/openwrt/router.config /home/me/openwrt/.config
cat /home/me/openwrt/owrt-packages/packages.config >> /home/me/openwrt/.config
cat /home/me/openwrt/owrt-packages/packages.feed >> /home/me/openwrt/feeds.conf.default

# Update feeds
./scripts/feeds update custom
./scripts/feeds install -a -p custom

# Update config based on config diffs
make defconfig

# Add other package compilation instructions below
make -j$(nproc) V=s package/cups/compile
