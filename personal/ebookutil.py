#!/usr/bin/env python

import os
import heapq
import logging
import filecmp

import argparse

"""
python -c "with open(r'd:\temp\ebook.txt') as fp: print '\n'.join(['del \"%s\"' % (item.strip()) for item in fp.readlines()])"
"""

MONTH = {"Jan":1, "Feb":2, "Mar":3, "Apr":4, "May":5, "Jun":6, "Jul":7, "Aug":8, "Sep":9, "Oct":10, "Nov":11, "Dec":12}
SUPPORT_EBOOKS = set((".pdf", ".epub", ".mobi", ".zip", ".rar"))

class EBook(object):
    def __init__(self):
        self.filename = None
        self.size = None
        self.version = None
        self.year = None
        self.month = None

    @classmethod
    def makeEBook(cls, filename):
        if not os.path.exists(filename) or not os.path.isfile(filename):
            return None
        if not os.path.splitext(filename)[1] in SUPPORT_EBOOKS:
            return None
        rv = EBook()
        rv.filename = filename
        rv.size = os.path.getsize(filename)

        filename = os.path.splitext(os.path.basename(filename))[0]
        idx1 = filename.rfind("-")
        if idx1 >= 0:
            str = filename[idx1+1:]
            if str.isdigit():
                rv.year = str
            else:
                idx2 = str.find(".")
                if idx2 >= 0:
                    if str[idx2+1:].isdigit():
                        rv.year = int(str[idx2+1:])
                    if idx2 > 0 and str[:idx2] in MONTH:
                        rv.month = str[:idx2]
        str = filename[:idx1]
        idx2 = str.rfind("-")
        if idx2 > 0:
            str = str[idx2+1:]
            if str.find("ed") == len(str)-2:
                version = str[:str.find("ed")]
                if version.isdigit():
                    rv.version = int(version)

        return rv

    @property
    def ext(self):
        return os.path.splitext(self.filename)[1]

    @property
    def basename(self):
        return os.path.basename(self.filename)

    def __str__(self):
        return "<file:%s, size:%d, version:%s, year:%d, month:%s>" % (self.filename,
            self.size, self.version, self.year, self.month)

    def __cmp__(self, other):
        if self.ext != other.ext:
            if self.ext < other.ext:
                return -1
            else:
                return 1
        else:
            return self.size - other.size

def find_duplicate(ll):
    heap = []

    for top in ll:
        top = os.path.normpath(top)
        if not os.path.exists(top) or not os.path.isdir(top):
            continue
        for root, dirs, files in os.walk(top):
            for filename in files:
                item = EBook.makeEBook(os.path.join(root, filename))
                if item is not None:
                    heapq.heappush(heap, item)
    if heap:
        logging.info("We have %d ebooks", len(heap))
        previous = heapq.heappop(heap)

    ss = set()
    while heap:
        current = heapq.heappop(heap)
        if current.size == previous.size and filecmp.cmp(previous.filename, current.filename, True):
            ss.add(previous.filename)
            ss.add(current.filename)
        previous = current
    ss = list(ss)
    ss.sort(cmp=lambda x, y : cmp(os.path.split(x)[1], os.path.split(y)[1]))
    for item in ss:
        print item

def synchfolder(ordir, newdir):
    ordir = os.path.normpath(ordir); newdir = os.path.normpath(newdir)
    for root, dirs, files in os.walk(ordir):
        for item in dirs:
            folder = os.path.join(root, item)
            folder = os.path.join(newdir, folder[len(ordir)+1:])
            if not os.path.isdir(folder):
                os.makedirs(folder)

def fix(folder):
    for root, dirs, files in os.walk(os.path.normpath(folder)):
        for item in files:
            idx = item.find(str)
            if idx >= 0:
                newitem = item[:idx] + "'s" + item[idx+len(str):]
                os.rename(os.path.join(root, item), os.path.join(root, newitem))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='',
                                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-V", "--verbose", action="count", default=0, help="Increase output verbosity")
    parser.add_argument("-d", "--duplicate", action='append', help="Find duplicate file in all directory")
    parser.add_argument("-s", "--sync", nargs = 2, help="Sync one directory structure to another directory")
    parser.add_argument("-f", "--fix", help="Fix the name in local folder")

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

    if args.duplicate:
        find_duplicate(args.duplicate)
    if args.sync:
        synchfolder(args.sync[0], args.sync[1])
