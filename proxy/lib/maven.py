import logging
import os

from util import getHttpProxy, javaNoProxy, parseProxy, load_properties, makeParent, Location, LocationHandler

maven_ali = """<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>
	<mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf> 
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    </mirror>
  </mirrors>
  
</settings>
"""

maven_office = """<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <proxies>
    <proxy>
      <active>true</active>
      <protocol>http</protocol>
      <host>%(server)s</host>
      <port>%(port)s</port>
      <nonProxyHosts>%(noproxy)s</nonProxyHosts>
   </proxy>
  </proxies>
  <mirrors>
    <mirror>
      <id>cnnan-nexus-central</id>
      <url>http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/central</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
  </mirrors>  
</settings>
"""

class MavenHandler(LocationHandler):
    def __init__(self, location):
        super(MavenHandler, self).__init__(location)

    def handle(self):
        settings = os.path.join(os.path.expanduser("~"), ".m2", "settings.xml")
        makeParent(settings)
        proxy = getHttpProxy()
        if self._localtion == Location.China:
            with open(settings, "w") as fp:
                print(maven_ali, file=fp)
        elif self._localtion == Location.Office:
            assert proxy, "Proxy must be set for %s" % (self._localtion.name, )
            _, server, port = parseProxy(proxy)
            mm = {"server": server, "port":port, "noproxy":javaNoProxy()}
            with open(settings, "w") as fp:
                print(maven_office % mm, file=fp)

    def handleWindows(self):
        pass

    def handleLinux(self):
        pass

if __name__ == "__main__":
    handler = MavenHandler(Location.China)
    handler.handle()
