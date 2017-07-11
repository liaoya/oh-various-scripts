# Introduction #

This folder contains various file for msys2

    sed -i "/^Server =.*ustc.*/d" /etc/pacman.d/mirrorlist.*
    sed -i "0,/^Server/s//Server = http:\/\/mirrors\.ustc\.edu\.cn\/msys2\/msys\/\$arch\n&/" /etc/pacman.d/mirrorlist.msys
    sed -i "0,/^Server/s//Server = http:\/\/mirrors\.ustc\.edu\.cn\/msys2\/mingw\/x86_64\n&/" /etc/pacman.d/mirrorlist.mingw64
    sed -i "0,/^Server/s//Server = http:\/\/mirrors\.ustc\.edu\.cn\/msys2\/mingw\/i686\n&/" /etc/pacman.d/mirrorlist.mingw32