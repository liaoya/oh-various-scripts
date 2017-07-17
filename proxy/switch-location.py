#!/usr/bin/env python3
# pylint: disable=line-too-long,unused-argument
"""This program will setup correct mirror for China"""

import argparse
import configparser
import os
import platform
import shlex
import shutil
import subprocess
import sys

# Steal from https://stackoverflow.com/questions/3595363/properties-file-in-python-similar-to-java-properties
def load_properties(filepath, sep='=', comment_char='#'):
    """
    Read the file passed as parameter as a properties file.
    """
    props = {}
    with open(filepath, "rt") as fp:
        for line in fp:
            ll = line.strip()
            if ll and not ll.startswith(comment_char):
                key_value = ll.split(sep)
                key = key_value[0].strip()
                value = sep.join(key_value[1:]).strip().strip('"')
                props[key] = value
    return props

def isWindows():
    return platform.system() == "Windows"


def getAbsoluteDir():
    return os.path.dirname(os.path.abspath(__file__))


def makeParent(filename):
    if not os.path.exists(os.path.dirname(filename)):
        os.makedirs(os.path.dirname(filename))


def getProxy():
    proxy = os.getenv("http_proxy")
    if proxy is None:
        proxy = os.getenv("HTTP_PROXY")
    if proxy is not None:
        proxy = proxy.replace('"', '')
    return proxy


def getNoProxy():
    noproxy = os.getenv("no_proxy")
    if noproxy is None:
        noproxy = os.getenv("NO_PROXY")
    if noproxy is not None:
        noproxy = noproxy.replace('"', '')
    return noproxy


def parseProxy():
    proxy = getProxy()
    if proxy is not None:
        idx1 = proxy.find(":") + 3
        idx2 = proxy.find(":", idx1) + 1
        return (proxy[idx1:idx2], proxy[idx2:])


def parseNoProxy():
    noproxy = getNoProxy()
    if noproxy is not None:
        noproxy = [item if item[0] != '.' else "*"+item for item in getNoProxy().split(",")]
        noproxy.append("10.*")
        return noproxy


def doGit(location):
    proxy = getProxy()
    if proxy is None:
        for cmd in ["git config --local --unset http.proxy",
                    "git config --local --unset credential.github.com.httpProxy"]:
            subprocess.call(shlex.split(cmd))
    else:
        for cmd in ["git config --local http.proxy " + proxy,
                    "git config --local credential.github.com.httpProxy " + proxy]:
            subprocess.call(shlex.split(cmd))


def doGradle(location):
    prop_file = os.path.join(os.path.expanduser("~"), ".gradle", "gradle.properties")
    makeParent(prop_file)
    props = {}
    if os.path.exists(prop_file):
        props = load_properties(prop_file)
    for key in ("systemProp.http.proxyHost", "systemProp.http.proxyPort", "systemProp.http.nonProxyHosts",
                "systemProp.https.proxyHost", "systemProp.https.proxyPort", "systemProp.https.nonProxyHosts"):
        props.pop(key, "")
    if getProxy() is not None:
        server, port = parseProxy()
        props["systemProp.http.proxyHost"] = server
        props["systemProp.http.proxyPort"] = port
        props["systemProp.https.proxyHost"] = server
        props["systemProp.https.proxyPort"] = port
        props["systemProp.http.nonProxyHosts"] = "|".join(parseNoProxy())
        props["systemProp.https.nonProxyHosts"] = "|".join(parseNoProxy())
    if props:
        with open(prop_file, "w") as fp:
            for key in sorted(list(props.keys())):
                print("%s=%s" % (key, props[key]), file=fp)


def doMaven(location):
    settings = os.path.join(os.path.expanduser("~"), ".m2", "settings.xml")
    makeParent(settings)
    if getProxy() is not None:
        server, port = parseProxy()
        src = os.path.join(getAbsoluteDir(), "maven-proxy.xml")
        with open(src) as fp:
            contents = fp.readlines()
        mm = {"server":server, "port":port, "noproxy":"|".join(parseNoProxy())}
        with open(settings, "w") as fp:
            print("".join(contents) % mm, file=fp)
    else:
        src = os.path.join(getAbsoluteDir(), "maven-ali.xml")
        shutil.copyfile(src, settings)


def doNpm(location):
    if isWindows():
        cmd = "npm.cmd "
    else:
        cmd = "npm "
    if location == "cn":
        cmd += "config set registry https://registry.npm.taobao.org"
    else:
        cmd += "config set registry https://registry.npmjs.org/"
    subprocess.call(shlex.split(cmd))


def doPython(location):
    """Change per user pip, setuptools configuration file"""
    if isWindows():
        pip_path = os.path.expandvars("%APPDATA%/pip/pip.ini")
    else:
        pip_path = os.path.expandvars("$HOME/.config/pip/pip.conf")

    makeParent(pip_path)
    config = configparser.ConfigParser()
    if os.path.exists(pip_path):
        config.read(pip_path)

    if "global" not in config:
        config.add_section("global")
    config.set("global", "format", "columns")
    if location == "cn":
        config.set("global", "index-url", "http://mirrors.aliyun.com/pypi/simple")
        config.set("global", "trusted-host", "mirrors.aliyun.com")
    with open(pip_path, "w") as fp:
        config.write(fp)
    

def main(location):
#    doGit(location)
    doGradle(location)
    doMaven(location)
    doNpm(location)
    doPython(location)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="This program will setup correct mirror for China")
    parser.add_argument("-l", "--location", dest="location", choices=["cn", "jp"], default="jp")
    args = parser.parse_args()

    main(args.location)
