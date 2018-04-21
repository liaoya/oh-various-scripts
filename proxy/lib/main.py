#!/usr/bin/env python3

import argparse

from docker import DockerHandler
from git import GitHandler
from gradle import GradleHandler
from maven import MavenHandler
from node import NodeHandler
from python import PythonHandler
from util import Location
from vscode import VSCodeHandler

def main(location):
    for handler in [DockerHandler(location), GitHandler(location), GradleHandler(location), 
                    MavenHandler(location), NodeHandler(location), PythonHandler(location),
                    VSCodeHandler(location)]:
        handler.handle()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="This program will setup correct mirror for China")
    parser.add_argument("-l", "--location", dest="location", choices=[item.name for item in list(Location) ], default=Location.Office)
    args = parser.parse_args()

    main(Location[args.location])
