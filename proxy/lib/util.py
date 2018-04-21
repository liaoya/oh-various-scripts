import os
import platform

from abc import ABCMeta, abstractmethod
from enum import Enum

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


def getHttpProxy():
    proxy = os.getenv("http_proxy")
    if proxy is None:
        proxy = os.getenv("HTTP_PROXY")
    if proxy is not None:
        proxy = proxy.replace('"', '')
    return proxy


def getHttpsProxy():
    proxy = os.getenv("https_proxy")
    if proxy is None:
        proxy = os.getenv("HTTPS_PROXY")
    if proxy is not None:
        proxy = proxy.replace('"', '')
    return proxy


def getNoProxy():
    noproxy = os.getenv("no_proxy")
    if noproxy is None:
        noproxy = os.getenv("NO_PROXY")
    if noproxy is not None:
        noproxy = noproxy.replace('"', '')
    else:
        noproxy = []
    return noproxy


def parseProxy(proxy):
    """Return http schema, host and port"""
    if proxy is not None:
        idx1 = proxy.find(":") + 3
        idx2 = proxy.find(":", idx1)
        return (proxy[0:idx1], proxy[idx1:idx2], proxy[idx2+1:])


def javaNoProxy():
    noproxy = getNoProxy()
    if noproxy is not None:
        noproxy = ".".join([item if item[0] != '.' else "*"+item for item in getNoProxy().split(",")])
        return noproxy


class Location(Enum):
    China = 1
    Office = 2


class ProxyHandler(metaclass = ABCMeta):
    @abstractmethod
    def handleWindows(self):
        """Handle Tool's configuration according to location"""
        pass

    @abstractmethod
    def handleLinux(self):
        """Handle Tool's configuration according to location"""
        pass

    def handle(self):
        if isWindows():
            self.handleWindows()
        else:
            self.handleLinux()  


class LocationHandler(metaclass = ABCMeta):
    def __init__(self, location):
        self._location = location

    @abstractmethod
    def handleWindows(self):
        """Handle Tool's configuration according to location"""
        pass

    @abstractmethod
    def handleLinux(self):
        """Handle Tool's configuration according to location"""
        pass

    def handle(self):
        if isWindows():
            self.handleWindows()
        else:
            self.handleLinux()
