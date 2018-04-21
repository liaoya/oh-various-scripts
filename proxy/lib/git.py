import shlex
import subprocess

from util import getHttpProxy, LocationHandler

class GitHandler(LocationHandler):
    def __init__(self, location):
        super(GitHandler, self).__init__(location)

    def handle(self):
        proxy = getHttpProxy()
        old_proxy = subprocess.run(shlex.split("git config --global http.proxy")).stdout
        if proxy:
            if old_proxy is None or proxy != old_proxy:
                for cmd in ["git config --global http.proxy " + proxy,
                            "git config --global credential.github.com.httpProxy " + proxy]:
                    subprocess.call(shlex.split(cmd))
        else:
            if old_proxy is not None:
                for cmd in ["git config --global --unset http.proxy",
                            "git config --global --unset credential.github.com.httpProxy"]:
                    subprocess.call(shlex.split(cmd))
    
    def handleLinux(self):
        pass

    def handleWindows(self):
        pass
