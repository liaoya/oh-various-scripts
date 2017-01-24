#! /usr/bin/env python

import os
import shutil
import subprocess, shlex
import logging
from optparse import OptionParser

def trace(message = None, ll = ()):
    if logging.getLogger().getEffectiveLevel() <= logging.DEBUG:
        logging.debug("%s:\n%s", message, "\n".join(ll))

def catAccurev(dest, element, verspec):
    filename = os.path.join(dest, element[3:])
    dirname = os.path.split(filename)[0]
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    cmd = "accurev cat -v %s %s > %s" % (verspec, element, filename)
    print cmd
    os.system(cmd)

def findDefaultGroup(stream):
    cmd = "accurev stat -s %s -a -d" % (stream, )
    logging.info(cmd)
    lines = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE).communicate()[0].split("\n")[:-1]
    logging.info("Find %d elements in stream %s", len(lines), stream)
    trace("Default Group in stream %s" % (stream, ), lines)
    return lines

def main(stream, dest, force):
    if os.path.exists(dest):
        if not force:
            logging.error("% exists", dest)
            return 1
        shutil.rmtree(dest)
    os.makedirs(dest)
    for line in findDefaultGroup(stream):
        ll = line.split()
        if ll[-1].find("defunct") >= 0:
            continue
        catAccurev(dest, ll[0], ll[1])

if __name__ == '__main__':
    parser = OptionParser(usage = "Usage: %prog [options] projects", version = "%prog 0.1")
    parser.add_option("-s", "--stream", dest = "stream", help = "The accurev stream")
    parser.add_option("-d", "--dest", dest = "dest", help = "The dest folder")
    parser.add_option("-f", "--force", dest = "force", action = "store_true", help = "Destroy the old if it exists")
    parser.add_option("-V", "--verbose", action = "store_true", dest = "verbose", default=False,
                      help="Print more help information in log")
    (options, args) = parser.parse_args()

    logging.basicConfig(format = "%(asctime)-15s %(levelname)-7s %(message)s")
    main("SHIRLEY_SpeedBuild", r"d:\temp\shirley", True)
