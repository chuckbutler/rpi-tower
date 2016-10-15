#!/bin/bash

set -e

# Treat the RPI cluster like an embedded system, Strip all non-essentials

# Create a file /etc/dpkg/dpkg.cfg.d/01_nodoc which specifies the desired filters. Example:

if [ ! -f /etc/dpkg/dpkg.cfg.d/01_nodoc ]
then
cat << EOF > /etc/dpkg/dpkg.cfg.d/01_nodoc
path-exclude /usr/share/doc/*
# we need to keep copyright files for legal reasons
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
# lintian stuff is small, but really unnecessary
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
EOF
fi

apt update
apt upgrade -y

apt install -y htop vim git ntp tmux lshw
