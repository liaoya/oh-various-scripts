#!/bin/env python

import argparse
import logging
import sys

KNOWN_USER_PASSWORD = {
    "admusr": ("Dukw1@m?"),
    "root": ("fib%yel5", "NextGen", "camiant", "policies", "vagrant", "packer"),
    "vagrant": ("vagrant")
}

def sshlogin(user, password, server, port):
    if password is None:
        if user not in KNOWN_USER_PASSWORD:
            logging.error("The password for %s must provide", user)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="This program use sshpass")
    parser.add_argument("-u", "--user", dest="user", default="root")
    parser.add_argument("-p", "--password", dest="password")
    parser.add_argument("-s", "--server", dest="server", default="localhost")
    parser.add_argument("-P", "--port", dest="port", default=22, type=int)
    parser.add_argument("-o", "--operation", dest="operation", default="login", choices=("login", "copy-id"))
    args = parser.parse_args()