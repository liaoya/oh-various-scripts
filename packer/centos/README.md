# Quick Build Guide

Use the following command to build CentOS 7.3.1611 for virtualbox-iso

    packer build -only virtualbox-iso -var-file conf/c7-1611-minimal.json -var "iso_path=/home/tshen/Downloads" -var "kickstart=c7-sata-ks.cfg" centos.json

Use the following command to build CentOS 7.3.1611 for qemu

    packer build -only virtualbox-iso -var-file conf/c7-1611-minimal.json -var "kickstart=c7-kvm-ks.cfg" centos.json
