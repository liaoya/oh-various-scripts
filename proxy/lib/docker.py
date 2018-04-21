import json

from util import Location, LocationHandler


class DockerHandler(LocationHandler):
    def __init__(self, location):
        super(DockerHandler, self).__init__(location)

    def handleWindows(self):
        pass

    def handleLinux(self):
        with open("/etc/docker/daemon.json") as fp:
            config = json.load(fp)
            old_mirror = config["registry-mirrors"]
            insecure_registries = set(config["insecure-registries"])
            if self._location == Location.China:
                mirror = ["https://registry.docker-cn.com"]
            elif self._location == Location.Office:
                mirror = ["http://cnnan-nexus.cn.oracle.com:5000"]
            for server in old_mirror:
                for schema in ["http://", "https://"]:
                    if server.find(schema):
                        server = server[len(schema)]
                if server in insecure_registries:
                    insecure_registries.remove(server)

            if mirror:
                config["registry-mirrors"] = mirror
                for server in mirror:
                    for schema in ["http://", "https://"]:
                        if server.find(schema):
                            server = server[len(schema)]
                    if server not in insecure_registries:
                        insecure_registries.add(server)
                config["insecure-registries"] = list(insecure_registries)
            else:
                config.pop("registry-mirrors")

        with open("/etc/docker/daemon.json", "w") as fp:
            json.dump(fp, config)
