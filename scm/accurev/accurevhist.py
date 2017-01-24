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
        return "<transaction %d, %s, %s, %s>" % (self.id, self.type, time.strftime(DEFAULT_TIMEFMT, time.localtime(self.time)), self.user)

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


def main(stream, timespec, detail):
    logging.info("%s, %s", stream, timespec)
    cmd = "accurev hist -s %s -a -f x" % (stream)
    if timespec:
        cmd += ' -t "%s"' % (timespec,)
    try:
        logging.info("Run %s", cmd)
        output = subprocess.check_output(shlex.split(cmd))
        records  = []
        ll = []
        for element in et.fromstring(output).iter("transaction"):
            rec = AccureHistRecord.create(element)
            records.append(rec)
        files = set()
        for rec in records:
            if detail == 0:
                info = "\n".join(rec.comment)
            if detail >= 1:
                info = "%s fixes at '%s'\n\t%s" % (rec.user, time.strftime(DEFAULT_TIMEFMT, time.localtime(rec.time)), "\n\t".join(rec.comment))
            if detail >= 2:
                info = "%s\n\t%s" % (info, "\n\t".join(rec.files))
            print info
    except subprocess.CalledProcessError:
        logging.error("Fail to run %s", cmd)
        return -1

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.',
                                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-V", "--verbose", action="count", default=0, help="Increase output verbosity")
    parser.add_argument("-s", "--stream", required=True, help="The accurev stream name")
    helpmsg = "The time spec, the same as -t in 'accurev hist', e.g. '2015/06/12 14:55:52-2015/06/03 10:59:50.10'"
    parser.add_argument("-t", "--timespec", help=helpmsg)
    parser.add_argument("-u", "--user", help="The accurev username")
    parser.add_argument("-p", "--password", help="The accurev password")
    helpmsg = "0 for comments, 1 add the user, 2 add files"
    parser.add_argument("-d", "--detail", action="count", default=0, help=helpmsg)

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
        sys.exit(main(args.stream, args.timespec, args.detail))