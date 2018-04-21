import json
import os

from util import getHttpProxy, makeParent, LocationHandler

class VSCodeHandler(LocationHandler):
    def __init__(self, location):
        super(VSCodeHandler, self).__init__(location)

    def _handle(self, conf_file):
        makeParent(conf_file)
        proxy = getHttpProxy()
        changed = False
        with open(conf_file) as fp:
            config = json.load(fp)
        if proxy:
            if ("http.proxy" not in config) or ("http.proxy" in config and config["http.proxy"] != proxy):
                config["http.proxy"] = proxy
                changed = True
        if not proxy and "http.proxy" in config:
            config.pop("http.proxy")
            changed = True
        if changed:
            with open(conf_file, "w") as fp:
                json.dump(config, fp)


    def handleLinux(self):
        self._handle(os.path.join(os.path.expandvars("%APPDATA%"), "Code", "User", "settings.json"))

    def handleWindows(self):
        self._handle(os.path.expandvars("$HOME/.config/Code/User/settings.json"))
