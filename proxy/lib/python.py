import configparser
import logging
import os
import shlex
import subprocess

from util import makeParent, Location, LocationHandler

class PythonHandler(LocationHandler):
    def __init__(self, location):
        super(PythonHandler, self).__init__(location)

    def _handlePip(self, pip_path):
        makeParent(pip_path)
        config = configparser.ConfigParser()
        if os.path.exists(pip_path):
            config.read(pip_path)

        if "global" not in config:
            config.add_section("global")
        config.set("global", "format", "columns")
        if self._location == Location.China:
            config.set("global", "index-url", "http://mirrors.aliyun.com/pypi/simple")
            config.set("global", "trusted-host", "mirrors.aliyun.com")
        elif self._location == Location.Office:
            config.remove_option("global", "index-url")
            config.remove_option("global", "trusted-host")
        with open(pip_path, "w") as fp:
            config.write(fp)
    
    def handleLinux(self):
        pip_path = os.path.expandvars("$HOME/.config/pip/pip.conf")
        self._handlePip(pip_path)

    def handleWindows(self):
        pip_path = os.path.expandvars("%APPDATA%/pip/pip.ini")
        self._handlePip(pip_path)
