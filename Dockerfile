FROM debian:latest

# Upgrade packages
RUN apt update && apt dist-upgrade -y

# Install "apt-utils", to get rid of "debconf: delaying package configuration, since apt-utils is not installed"
RUN apt install -y apt-utils

# Install "gnupg" package, for MXE's repository key
RUN apt install -y gnupg

# Add MXE repository - http://pkg.mxe.cc
RUN echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt/sources.list.d/mxeapt.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB

# Update packages list
RUN apt update

# Install shared packages
RUN apt-cache --names-only search ^mxe-x86-64-w64-mingw32.shared* | awk '{ print $1 }' | grep -v mxe-x86-64-w64-mingw32.shared-qt > packages_shared.txt

RUN xargs -a packages_shared.txt apt install -y -o Dpkg::Options::="--force-overwrite"

# Install static packages
RUN apt-cache --names-only search ^mxe-x86-64-w64-mingw32.static* | awk '{ print $1 }' | grep -v mxe-x86-64-w64-mingw32.static-qt > packages_static.txt

RUN xargs -a packages_static.txt apt install -y -o Dpkg::Options::="--force-overwrite"
