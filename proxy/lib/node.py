import logging
import os
import shlex
import subprocess

from util import Location, LocationHandler

mirrorMap = {
    Location.China : "https://registry.npm.taobao.org",
    Location.Office: "https://registry.npmjs.org"
}

class NodeHandler(LocationHandler):
    def __init__(self, location):
        super(NodeHandler, self).__init__(location)

    def handleLinux(self):
        node_tmp = os.path.join(os.path.expanduser("~"), ".node-tmp")
        os.makedirs(node_tmp, exist_ok=True)
        subprocess.call(shlex.split("npm config set tmp %s" % (node_tmp, )))
        subprocess.call(shlex.split("npm config set registry %s" % (mirrorMap[self._location], )))

    def handleWindows(self):
        subprocess.call(shlex.split("npm.cmd config set registry %s" % (mirrorMap[self._location], )))
