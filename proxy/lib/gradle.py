import logging
import os

from util import getHttpProxy, javaNoProxy, parseProxy, load_properties, makeParent, Location, LocationHandler

init_script_ali = """allprojects {
    buildscript {
        repositories {
            maven { url 'http://maven.aliyun.com/nexus/content/repositories/jcenter' }
            maven { url 'http://maven.aliyun.com/nexus/content/repositories/central' }
            maven { url 'http://maven.aliyun.com/nexus/content/repositories/gradle-plugin' }
        }
    }
    repositories {
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/central' }
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/gradle-plugin' }
    }
}
"""

init_script_office = """allprojects {
    buildscript {
        repositories {
            maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/jcenter' }
            maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/central' }
            maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/gradle-plugin' }
        }
    }
    repositories {
        maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/jcenter' }
        maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/central' }
        maven { url 'http://cnnan-nexus.cn.oracle.com/nexus/content/repositories/gradle-plugin' }
    }
}
"""

class GradleHandler(LocationHandler):
    def __init__(self, location):
        super(GradleHandler, self).__init__(location)

    def handle(self):
        prop_file = os.path.join(os.path.expanduser("~"), ".gradle", "gradle.properties")
        makeParent(prop_file)
        props = {}
        if os.path.exists(prop_file):
            props = load_properties(prop_file)
        if "systemProp.location" in props and props["systemProp.location"] == self._location.name:
            logging.info("The same location")
            return
        props["systemProp.location"] = self._location.name
        for key in ("systemProp.http.proxyHost", "systemProp.http.proxyPort", "systemProp.http.nonProxyHosts",
                    "systemProp.https.proxyHost", "systemProp.https.proxyPort", "systemProp.https.nonProxyHosts"):
            props.pop(key, "")
        proxy = getHttpProxy()
        if proxy is not None:
            _, server, port = parseProxy(proxy)
            props["systemProp.http.proxyHost"] = server
            props["systemProp.http.proxyPort"] = port
            props["systemProp.https.proxyHost"] = server
            props["systemProp.https.proxyPort"] = port
            props["systemProp.http.nonProxyHosts"] = javaNoProxy()
            props["systemProp.https.nonProxyHosts"] = javaNoProxy()
        with open(prop_file, "w") as fp:
            for key in sorted(list(props.keys())):
                print("%s=%s" % (key, props[key]), file=fp)
        
        nexus_gradle = os.path.join(os.path.expanduser("~"), ".gradle", "init.d", "nexus.gradle")
        makeParent(nexus_gradle)
        if self._location == Location.China:
            with open(nexus_gradle, "w") as fp:
                print(init_script_ali, file=fp)
        elif self._location == Location.Office:
            with open(nexus_gradle, "w") as fp:
                print(init_script_office, file=fp)            

    def handleWindows(self):
        pass

    def handleLinux(self):
        pass

if __name__ == "__main__":
    handler = GradleHandler(Location.China)
    handler.handle()
