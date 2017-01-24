#!/usr/bin/env python

import argparse
import getpass
import logging
import shlex
import subprocess
import sys
import time

import xml.etree.ElementTree as et

DEFAULT_TIMEFMT = "%Y/%m/%d %H:%M:%S"

class AccureHistRecord:
    def __init__(self):
        self.id = 0 # transaction id
        self.type = None
        self.time = None
        self.user = None
        self.comment = []
        self.files = []

    def __str__(self):
        return "<transaction %d, %s, %s, %s>" % (self.id, self.type, time.asctime(time.localtime(self.time)), self.user)

    @staticmethod
    def create(element):
        record = AccureHistRecord()
        record.id = int(element.get("id"))
        record.type = element.get("type")
        record.time = float(element.get("time"))
        record.user = element.get("user")

        for item in element.iter("comment"):
            for line in item.text.splitlines():
                record.comment.append(line.strip())

        for item in element.iter("version"):
            record.files.append(item.get("path"))

        return record

def accurevLogin(user, password):
    if not user:
        logging.info("There's no accurev user provided and return")
        return True
    if user and not password:
        prompt = "Please input the password for Accurev user %s: " % (user,)
        password = getpass.getpass(prompt)
    cmd = "accurev login %s %s" % (user, password)
    try:
        subprocess.check_call(shlex.split(cmd))
        return True
    except subprocess.CalledProcessError:
        logging.error("Fail to login %s", user)
        return False


def include(rec, start, end):
    if ((start is not None and (type(start) == float and rec.time < start) or (type(start) == int and rec.id < start))
        or (end is not None and (type(end) == float and rec.time > end) or (type(end) == int and rec.id > end))):
            return False
    else:
        return True


def main(stream, format, start, end, detail):
    logging.info("%s, %s, %d, %d", stream, format, start, end)
    cmd = "accurev hist -s %s -a -f x" % (stream)
    try:
        logging.info("Run %s", cmd)
        output = subprocess.check_output(shlex.split(cmd))
        records  = []
        ll = []
        for element in et.fromstring(output).iter("transaction"):
            rec = AccureHistRecord.create(element)
            if include(rec, start, end): records.append(rec)
        files = set()
        for rec in records:
            print "%s (%s, %s)\n\t%s" % (rec.id, rec.user, time.strftime(format, time.localtime(rec.time)), "\n\t".join(rec.comment))
            for item in rec.files:
                files.add(item)
        if detail and files:
            print "The following files are touched\n\t%s" % ("\n\t".join(sorted(files)))
    except subprocess.CalledProcessError:
        logging.error("Fail to run ")
        return -1

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.',
                                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-V", "--verbose", action="count", default=0, help="Increase output verbosity")
    parser.add_argument("-s", "--stream", required=True, help="The accurev stream name")
    parser.add_argument("-f", "--format", default=DEFAULT_TIMEFMT, help="")
    parser.add_argument("-S", "--start", help="The start time or transaction id")
    parser.add_argument("-E", "--end", help="The end time or transaction id")
    parser.add_argument("-u", "--user", help="The accurev username")
    parser.add_argument("-p", "--password", help="The accurev password")
    parser.add_argument("-D", "--detail", action="count", default=0, help="Print the files changed")

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

    if accurevLogin(args.user, args.password):
        start = args.start; end = args.end
        if start:
            try:
                start = int(start)
            except ValueError:
                start = time.mktime(time.strptime(start, args.format))
        if end:
            try:
                end = int(end)
            except ValueError:
                end = time.mktime(time.strptime(end, args.format))
        if start is None: start = 0
        if end is None: end = sys.maxint

        sys.exit(main(args.stream, args.format, start, end, args.detail))