#! /bin/env python

import logging
import os
import subprocess
import shlex

excludes = ("mingw-w64-x86_64-ogre3d", "mingw-w64-x86_64-blender", "mingw-w64-x86_64-OpenSceneGraph", "mingw-w64-x86_64-qt5", "mingw-w64-x86_64-qt5-static")
pkgdir = "/var/cache/pacman/pkg"


"""This script can only be run under msys2 environment"""


def main():
    cmd = "pacman -Sy"
    subprocess.check_call(shlex.split(cmd))
    cmd = "pacman -Sl"
    ss = set()
    for line in subprocess.check_output(shlex.split(cmd)).split("\n"):
        ll = line.split()
        if len(ll) >= 3 and ll[0] != "mingw32":
            ss.add("%s-%s" % (ll[1], ll[2]))
            if not (os.path.exists(os.path.join(pkgdir, ll[1]+"-"+ll[2]+"-x86_64.pkg.tar.xz"))
		or os.path.exists(os.path.join(pkgdir, ll[1]+"-"+ll[2]+"-any.pkg.tar.xz"))):
                if ll[1] not in excludes:
                    logging.info("Download %s", ll[1])
                    cmd = "pacman -S -q -w --nodeps --noprogressbar --noconfirm " + ll[1]
                    subprocess.check_call(shlex.split(cmd))

    for item in os.listdir(pkgdir):
        idx = item.find("-x86_64.pkg.tar.xz")
        if idx < 0 : idx = item.find("-any.pkg.tar.xz")
        if idx < 0:
            logging.warn("Can not find %s", item)
            continue
        if item[:idx] not in ss:
            logging.warn("%s is old", item)
            os.remove(os.path.join(pkgdir, item))

if __name__ == '__main__':
    main()
