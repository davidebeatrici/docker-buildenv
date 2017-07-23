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

# Install packages
RUN apt install -y -o Dpkg::Options::="--force-overwrite" "mxe-i686-w64-mingw32.shared*" "mxe-i686-w64-mingw32.static*"
