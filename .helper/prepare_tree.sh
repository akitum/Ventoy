echo "download additional deps into tree (@see: INSTALL/docker_ci_build.sh)" ] \
    && VTOY_PATH=/ventoy \
    && wget -q -P $VTOY_PATH/DOC/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/dietlibc-0.34.tar.xz \
    && wget -q -P $VTOY_PATH/DOC/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/musl-1.2.1.tar.gz \
    && wget -q -P $VTOY_PATH/GRUB2/ https://github.com/ventoy/vtoytoolchain/releases/download/1.0/grub-2.04.tar.xz \
    && wget -q -O $VTOY_PATH/EDK2/edk2-edk2-stable201911.zip https://codeload.github.com/tianocore/edk2/zip/edk2-stable201911
