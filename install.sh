#!/usr/bin/bash
export DEBIAN_FRONTEND=noninteractive
           apt update -y
            apt install bc \
            binutils-dev \
            bison \
            build-essential \
            ca-certificates \
            ccache \
            clang \
            cmake \
            curl \
            file \
            flex \
            git \
            libelf-dev \
            libssl-dev \
            lld \
            make \
            ninja-build \
            python3-dev \
            texinfo \
            u-boot-tools \
            xz-utils \
            llvm \
            patchelf \
            zlib1g-dev -y
