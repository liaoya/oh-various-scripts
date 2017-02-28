#!/usr/bin/env python

import os
import sys
import shutil
import logging

import argparse

def main(rootdir):
    for root, dirs, files in os.walk(rootdir):
        if root == rootdir:
            continue
        for item in files:
            src = os.path.join(root, item)
            dest = os.path.join(rootdir, item)
            if not os.path.exists(dest):
                shutil.move(src, dest)
            else:
                logging.warning("Can't move %s", src)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-V", "--verbose", action="count", default=0, help="Increase output verbosity")
    parser.add_argument("-d", "--directory", required=True, help="The root directory")

    args = parser.parse_args()
    FORMAT = '%(asctime)-15s %(levelname)-7s %(message)s'
    if args.verbose >= 2:
        logging.basicConfig(level=logging.DEBUG, format=FORMAT)
    elif args.verbose >= 1:
        logging.basicConfig(level=logging.INFO, format=FORMAT)
    else:
        logging.basicConfig(format=FORMAT)
    logging.info(args)

    sys.exit(main(args.directory))