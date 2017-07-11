#

More boot time is required for virtualbox-iso.

The following information is required for build

* DNS nameserver
* Proxy for apk

## Build ova or qcow2 file

The following command for build virtualbox-iso, iso_path is provide at last so that is will overwrite that in conf/3.6.2.json

    export http_proxy=http://cnnan-nexus:3128
    packer build -only virtualbox-iso -var-file conf/3.6.2.json -var "nameserver=10.182.244.34" -var "iso_path=/home/tshen/Downloads" alpine.json

The following command for build qemu

    export http_proxy=http://10.113.69.79:3128
    packer build -only qemu -var-file conf/3.6.2.json -var-file "nameserver=10.182.244.34" alpine.json

## Build vagrant box

The following command for build virtualbox-iso, iso_path is provide at last so that is will overwrite that in conf/3.6.2.json

    export http_proxy=http://cnnan-nexus:3128
    packer build -only virtualbox-iso -var-file conf/3.6.2.json -var "nameserver=10.182.244.34" -var "iso_path=/home/tshen/Downloads" alpine-vagrant.json

The following command for build qemu

    export http_proxy=http://10.113.69.79:3128
    packer build -only qemu -var-file conf/3.6.2.json -var-file "nameserver=10.182.244.34" alpine-vagrant.json

The following command is used for

    setup-apkrepos http://dl-cdn.alpinelinux.org/alpine/v3.6/main http://dl-cdn.alpinelinux.org/alpine/v3.6/community