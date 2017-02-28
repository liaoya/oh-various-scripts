#!/usr/bin/env python

import os
import sys
import logging
import shutil
import filecmp
import argparse


def getKeys(dest, length):
    """"return a map the value is the folder"""
    dest = os.path.normpath(dest)
    ignore = set(("8", "Access", "App", "Application", "Applications", "AS",
        "Build",
        "C", "Configuration Management",
        "Dynamic", "Internet", "Mining", "Misc", "Pattern",
        "Science", "Scientific", "Script", "Scripts", "Security", "Software", "SQL",
        "Testing", "Theory",
        "Web"))
    mm = {}
    ss = set()
    for root, dirs, __ in os.walk(dest):
        for item in dirs:
            if item in ignore:
                continue
            if len(item) <= length:
                logging.info("%s is too short", item)
                continue
            if item in ss:
                logging.debug("%s is in duplicate set", item)
                continue
            if item in mm:
                logging.debug("%s exist", item)
                mm.pop(item)
                ss.add(item)
            else:
                mm[item] = os.path.join(root, item)[len(dest)+1:]
    if logging.getLogger().getEffectiveLevel() == logging.INFO:
        for k, v in mm.iteritems():
            logging.info("%s -> %s", k, v)
    return mm


def main(src, dest, length):
    """"""
    mm = getKeys(dest, length)
    keys = [k for k in mm.iterkeys()]
    keys.sort(cmp=lambda x, y: len(x) - len(y), reverse=True)
    src = os.path.normpath(src)
    ll = []
    for root, dirs, files in os.walk(src):
        for item in files:
            for k in keys:
                idx = item.find(k)
                if idx >= 0:
                    ll.append((os.path.join(root, item), mm[k]))
                    if not os.path.exists(os.path.join(dest, mm[k], item)):
                        shutil.move(os.path.join(root, item), os.path.join(dest, mm[k]))
                    else:
                        if filecmp.cmp(os.path.join(root, item), os.path.join(dest, mm[k], item)):
                            os.remove(os.path.join(root, item))
                        else:
                            logging.warning("%s and %s are different", os.path.join(root, item), os.path.join(dest, mm[k], item))
                    break
#            else:
#                print "Can't handle %s" % (os.path.join(root, item), )

    ll.sort(key=lambda x : x[1])
    for k, v in ll:
        print "Move %s to %s" % (k, v)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.',
                                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-V", "--verbose", action="count", default=0, help="Increase output verbosity")
    parser.add_argument("-s", "--src", required=True, help="The directory for ebook downloaded")
    parser.add_argument("-d", "--dest", required=True, help="The directory for ebook classified")
    parser.add_argument("-l", "--length", type=int, default=2, help="The minimum length of key")

    args = parser.parse_args()

    logging.getLogger().handlers = []
    FORMAT = '%(asctime)-15s %(levelname)-7s %(message)s'
    if args.verbose >= 2:
        logging.basicConfig(level=logging.DEBUG, format=FORMAT)
    if args.verbose >= 1:
        logging.basicConfig(level=logging.INFO, format=FORMAT)
    else:
        logging.basicConfig(format=FORMAT)
    logging.info(args)

    sys.exit(main(args.src, args.dest, args.length))