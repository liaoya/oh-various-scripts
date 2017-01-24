#! /bin/env python

# Find the file diff in two folder based on the first folder

import os
import os.path
import filecmp
import logging

from optparse import OptionParser

def main(dir1, dir2):
    adds, modifies, removes = [], [], []
    for dirpath, dirnames, filenames in os.walk(dir1):
        # Find files added
        for item in dirnames:
            item1 = os.path.join(dirpath, item)
            item2 = os.path.join(dir2, item1[len(dir1)+1:])
            if not os.path.exists(item2):
                adds.append(item1[len(dir1)+1:])
                
        for item in filenames:
            item1 = os.path.join(dirpath, item)
            item2 = os.path.join(dir2, item1[len(dir1)+1:])
            if not os.path.exists(item2):
                adds.append(item1[len(dir1)+1:])
            if os.path.exists(item2) and not filecmp.cmp(item1, item2):
                modifies.append(item1[len(dir1)+1:])

    # Find files removed
    for dirpath, dirnames, filenames in os.walk(dir2):
        for item in dirnames:
            item1 = os.path.join(dirpath, item)
            item2 = os.path.join(dir1, item1[len(dir2)+1:])
            if not os.path.exists(item2):
                removes.append(item1[len(dir2)+1:])
    
        for item in filenames:
            item1 = os.path.join(dirpath, item)
            item2 = os.path.join(dir1, item1[len(dir2)+1:])
            if not os.path.exists(item2):
                removes.append(item1[len(dir2)+1:])

    adds.sort()
    with open("add-%s-%s.filelist" % (os.path.basename(dir1), os.path.basename(dir2)), "w") as f:
        for item in adds:
            print >>f, item

    modifies.sort()
    with open("modify-%s-%s.filelist" % (os.path.basename(dir1), os.path.basename(dir2)), "w") as f:
        for item in modifies:
            print >>f, item

    removes.sort()
    with open("remove-%s-%s.filelist" % (os.path.basename(dir1), os.path.basename(dir2)), "w") as f:
        for item in removes:
            print >>f, item

if __name__ == "__main__" :
    parser = OptionParser(usage = "Usage: %prog [options] <folder 1> <folder 2>", version = "%prog 0.1")
    parser.add_option("-V", "--verbose", action = "store_true", dest = "verbose", default = False,
                      help = "Print more information, [default: %default]")
    parser.add_option("-D", "--debug", action = "store_true", dest = "debug", default = False,
                      help = "Print much more information, [default: %default]")

    (options, args) = parser.parse_args()
    if len(args) != 2:
        parser.print_usage()
        sys.exit(1)

    if options.verbose:
        logging.getLogger().setLevel(logging.INFO)
    if options.debug:
        logging.getLogger().setLevel(logging.DEBUG)

    logging.info("Options:" + str(options))
    logging.info("Args:" + str(args))

    main(args[0], args[1])
