#!/bin/bash

echo "Installing GlusterFS server and utilities"

apt install -y glusterfs-server xfsprogs

lshw -c disk

echo "Now make an XFS volume on the listed volume above"
echo "mkfs.xfs /dev/sdx"

