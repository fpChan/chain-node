#!/bin/bash

function aws_nvme1n1() {
   #cgdisk /dev/nvme1n1
    mkdir /data
    mkfs -t ext4 /dev/nvme1n1
    
    sed -i '$a  \/dev\/nvme1n1  \/data  ext4  defaults  0  2' /etc/fstab
    mount /data
}

function us() {
    mkdir /data
    mkfs -t mkfs.ext4 /dev/md0
    sed -i '$a  \/dev\/md0  \/data  ext4  defaults  0  0' /etc/fstab
}

lsblk
df -HT
