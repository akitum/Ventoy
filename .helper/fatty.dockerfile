FROM centos:7

RUN echo "download container env 1 / 4 (@see: ./Dockerfile)" \
    && yum -y -q install \
        libXpm net-tools bzip2 wget vim gcc gcc-c++ samba dos2unix glibc-devel glibc.i686 glibc-devel.i686 \
        mpfr.i686 mpfr-devel.i686 rsync autogen autoconf automake libtool gettext* bison binutils \
        flex device-mapper-devel SDL libpciaccess libusb freetype freetype-devel gnu-free-* qemu-* virt-* \
        libvirt* vte* NetworkManager-bluetooth brlapi fuse-devel dejavu* gnu-efi* pesign shim \
        iscsi-initiator-utils grub2-tools zip nasm acpica-tools glibc-static zlib-static xorriso lz4 squashfs-tools

ADD ./DOC/installdietlibc.sh /installdietlibc.sh
RUN set -eu \
    && echo "download container env 2 / 4 (@see: INSTALL/docker_ci_build.sh)" \
    && wget -q -P / https://github.com/ventoy/vtoytoolchain/releases/download/1.0/dietlibc-0.34.tar.xz \
    && chmod +x /installdietlibc.sh \
    && /installdietlibc.sh \
    && rm /dietlibc-0.34.tar.xz \
    && rm /installdietlibc.sh \
    && wget -q -P /opt/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz \
    && wget -q -P /opt/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/aarch64--uclibc--stable-2020.08-1.tar.bz2 \
    && wget -q -P /opt/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/mips-loongson-gcc7.3-2019.06-29-linux-gnu.tar.gz \
    && echo "download container env 3 / 4 (@see: DOC/prepare_env.sh)" \
    && tar xf /opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz  -C /opt \
    && tar xf /opt/aarch64--uclibc--stable-2020.08-1.tar.bz2  -C /opt \
    && tar xf /opt/mips-loongson-gcc7.3-2019.06-29-linux-gnu.tar.gz  -C /opt \
    && echo "download container env 4 / 4 (@see: DOC/BuildVentoyFromSource.txt)" \
    && wget -q -P /opt/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/musl-1.2.1.tar.gz \
    && tar xf /opt/musl-1.2.1.tar.gz -C /opt \
    && cd /opt/musl-1.2.1 \
    && ./configure && make install \
    && wget -q -P /opt/ https://github.com/ventoy/musl-cross-make/releases/download/latest/output.tar.bz2 \
    && tar xf /opt/output.tar.bz2 -C /opt \
    && mv /opt/output /opt/mips64el-linux-musl-gcc730

ENV PATH=$PATH:/opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin:/opt/aarch64--uclibc--stable-2020.08-1/bin:/opt/mips-loongson-gcc7.3-linux-gnu/2019.06-29/bin/:/opt/mips64el-linux-musl-gcc730/bin/
