import shlex
import subprocess

from util import getHttpProxy, ProxyHandler

class GitHandler(ProxyHandler):
    def __init__(self, location):
        super(GitHandler, self).__init__(location)
    
    def handle(self):
        proxy = getHttpProxy()
        old_proxy = subprocess.check_output(shlex.split("git config --global http.proxy")).strip()
        if proxy:
            if proxy != old_proxy:
                for cmd in ["git config --global http.proxy " + proxy,
                            "git config --global credential.github.com.httpProxy " + proxy]:
                    subprocess.call(shlex.split(cmd))
        else:
            for cmd in ["git config --global http.proxy " + proxy,
                        "git config --global credential.github.com.httpProxy " + proxy]:
                subprocess.call(shlex.split(cmd))
    
    def handleLinux(self):
        pass

    def handleWindows(self):
        pass
