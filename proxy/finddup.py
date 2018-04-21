#! /usr/bin/env python

import os

def main(ll):
    mm = {}
    for rootdir in ll:
        for root, _, files in os.walk(rootdir):
            for item in files:
                if ((item.find("IMG") == 0 and os.path.splitext(item)[1] == ".jpg")
                    or (item.find("VID") == 0 and os.path.splitext(item)[1] == ".mp4")):
                    if item not in mm:
                        mm[item] = os.path.join(root, item)
                    else:
                        print("%s exists" % os.path.join(root, item))

if __name__ == "__main__":
    main([])
