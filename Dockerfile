# https://github.com/openwrt/buildbot/blob/master/docker/buildworker/Dockerfile

FROM debian:13
LABEL maintainer="Maxim Kurbatov"

ARG	DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y \
	asciidoc \
	bison \
	build-essential \
	ccache \
	clang \
	curl \
	file \
	flex \
	gawk \
	g++-multilib \
	gcc-multilib \
	genisoimage \
	gettext \
	git-core \
	gosu \
	help2man \
	intltool \
	libdw-dev \
	libelf-dev \
	libncurses5-dev \
	libssl-dev \
	libxslt1-dev \
	locales \
	make \
	mc \
	patch \
	perl-modules \
	pv \
	pwgen \
	python-is-python3 \
	python3 \
	python3-dev \
	python3-setuptools \
	qemu-utils \
	rsync \
	signify-openbsd \
	subversion \
	sudo \
	swig \
	time \
	unzip \
	wget \
	xsltproc \
	zlib1g-dev \
	zstd && \
  apt-get clean && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

ARG OPENWRT_VERSION_GIT_REF openwrt-24.10
ARG ROUTER_CONFIG glinet-mt6000

# Clone and build OpenWrt
RUN git clone --depth 1 --branch ${OPENWRT_VERSION_GIT_REF} https://github.com/openwrt/openwrt.git /root/openwrt \
    && cd /root/openwrt \
    && make package/symlinks

# Copy router config
COPY configs/${ROUTER_CONFIG}.config /root/openwrt/.config

WORKDIR /root/openwrt

RUN cd /root/openwrt \
    && ./scripts/feeds update -a \
    && ./scripts/feeds install -a \
    && make defconfig \
		&& make -j$(nproc) tools/install \
		&& make -j$(nproc) toolchain/install

ENTRYPOINT ["/bin/bash"]
