#!/usr/bin/env python3
"""This program will setup correct mirror for China"""

import argparse
import configparser
import os
import platform
import shlex
import subprocess
import sys


def isWindows():
    return platform.system() == "Windows"


def doNpm(flag):
    if flag:
        cmd = "npm config set registry https://registry.npm.taobao.org"
    else:
        cmd = "npm config set registry https://registry.npmjs.org/"
    subprocess.call(shlex.split(cmd))


def doPython():
"""Change per user pip, setuptools configuration file"""
    if isWindows():
        pip_path = os.path.expandvars("%APPDATA%/pip/pip.ini")
    else:
        pip_path = os.path.expandvars("$HOME/.config/pip/pip.conf")

    if os.path.isdir(os.path.split(pip_path)):
        os.makedirs(os.path.split(pip_path))
    config = configparser.ConfigParser()
    if os.path.exists(pip_path):
        config.read(pip_path)
     
    if "global" not in config:
        config.add_section("global")
    config.set("global", "format", "columns")
    config.set("global", "index-url", "http://d.pypi.python.org/simple")
    with open(pip_path, "w") as fp:
        config.write(fp)

    

def main():
    pass

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="This program will setup correct mirror for China")
    parser.add_argument("--on", dest="", action="store_true", default=False)
    main()
