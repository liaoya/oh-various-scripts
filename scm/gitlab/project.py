#!/usr/bin/env python

from __future__ import print_function

import requests

TOKEN = "oxULdqRTAKNgPDbasjhL"
URL1 = "http://usmar-gitlab01.us.oracle.com:81/api/v3/groups?all_available=true"
URL2 = "http://usmar-gitlab01.us.oracle.com:81/api/v3/groups/%s/projects"

def main():
    headers = {"PRIVATE-TOKEN":TOKEN}
    for group in requests.get(URL1, headers=headers).json():
        for project in requests.get(URL2%(group["id"]), headers=headers).json():
            param = {"group":group["name"], "prject":project["name"], "url":project["ssh_url_to_repo"]}
            print("mkdir -p %s/%s" % (group["name"], project["name"]),
                "cd %s/%s" % (group["name"], project["name"]),
                "git clone %s" % project["ssh_url_to_repo"],
                "cd ../..",
                sep="; ")
            
        


if __name__ == "__main__":
    main()