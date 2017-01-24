#! /bin/env python

# Find the real different in two accurev workspace or stream, it only query the server

import os
import os.path
import sys
import filecmp
import tempfile
import subprocess,shlex
import threading
import logging

from optparse import OptionParser

def trace(message = None, ll = ()):
    if logging.getLogger().getEffectiveLevel() <= logging.DEBUG:
        logging.debug("%s:\n%s", message, "\n".join(ll))

def existAccurev(stream, element):
    cmd = "accurev stat -s %s %s" % (stream, element)
    logging.debug(cmd)
    lines = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE).communicate()[0].split("\n")[:-1]
    logging.debug("Check %s in stream %s and return '%s'", element, stream, lines[0])
    if lines[0].find("(no such elem)") >= 0 or lines[0].find("(defunct)") >= 0:
        return False
    else:
        return True

def verspecAccurev(stream, element):
    cmd = "accurev stat -s %s %s" % (stream, element)
    logging.debug(cmd)
    lines = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE).communicate()[0].split("\n")[:-1]
    logging.debug("Check %s in stream %s and return '%s'", element, stream, lines[0])
    if lines[0].find("(no such elem)") > 0:
        return None
    else:
        return lines[0].split()[1]

def catAccurev(verspec, element):
    (fid, filename) = tempfile.mkstemp(prefix = os.path.basename(element) + "-")
    cmd = "accurev cat -v %s %s" % (verspec, element)
    logging.debug("Run as: %s > %s", cmd, filename)
    subprocess.Popen(shlex.split(cmd), stdout=fid).communicate()
    os.close(fid)
    return filename

def findDefaultGroup(stream):
    cmd = "accurev stat -s %s -a -d" % (stream, )
    logging.info(cmd)
    lines = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE).communicate()[0].split("\n")[:-1]
    logging.info("Find %d elements in stream %s", len(lines), stream)
    trace("Default Group in stream %s" % (stream, ), lines)
    return lines

class CmpThread(threading.Thread):
    def __init__(self, child, parent, elements):
        self.__child = child
        self.__parent = parent
        self.__elements = elements
        self.same = []
        self.diff = []
        threading.Thread.__init__(self)
    def run(self):
        for elem in self.__elements:
            filename, childver = elem.split()[:2]
            status = "".join(elem.split()[3:])
            if status.find("(defunct)") >= 0:
                logging.info("Element %s is defuncted in stream %s and its status is %s", filename, self.__child, status)
                if existAccurev(self.__parent, filename):
                    self.diff.append(filename)
                continue
            parentver = verspecAccurev(self.__parent, filename)
            if parentver is None:
                logging.debug("There's no element named %s in stream %s", filename, self.__parent)
                self.diff.append(elem)
                continue
            file1 = catAccurev(childver, filename)
            file2 = catAccurev(parentver, filename)
            if filecmp.cmp(file1, file2):
                logging.debug("The element %s is the same between %s and %s", filename, self.__child, self.__parent)
                self.same.append(elem)
            else:
                logging.debug("The element %s is different between %s and %s", filename, self.__child, self.__parent)
                self.diff.append(elem)
            os.remove(file1)
            os.remove(file2)        

def main(child, parent, threadnum, same, diff):
    elements = findDefaultGroup(child)
    threads = []
    step = len(elements)/threadnum
    for i in range(threadnum):
        start = i*step;
        end = (i+1)*step if i < threadnum-1 else len(elements)
        thread = CmpThread(child, parent, elements[start:end])
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()

    ll = []
    for thread in threads:
        ll.extend(thread.same)
    if same is None:
        if len(ll) > 0:
            print "The following files are same between %s and %s:" % (child, parent)
        for elem in ll:
            print elem
    else:
        with open(same, "w") as fout:
            print >> fout, "\n".join([elem[3:] for elem in ll])

    ll = []
    for thread in threads:
        ll.extend(thread.diff)
    if same is None:
        if len(ll) > 0:
            print "The following files are different between %s and %s:" % (child, parent)
        for elem in ll:
            print elem
    else:
        with open(diff, "w") as fout:
            print >> fout, "\n".join([elem[3:] for elem in ll])
    
if __name__ == "__main__":
    parser = OptionParser(usage = "Usage: %prog [options] <child stream> <parent stream>.", version = "%prog 0.1")
    parser.add_option("-s", "--same", dest = "same", default = None, help = "The output file for same files only")
    parser.add_option("-d", "--diff", dest = "diff", default = None, help = "The output file for diff files only")
    parser.add_option("-t", "--thread", dest = "thread", default = 4, type = "int", help = "Thread number for accurev cat")
    parser.add_option("-V", "--verbose", action = "store_true", dest = "verbose", default = False, 
                      help = "Print more information, [default: %default]")
    parser.add_option("-D", "--debug", action = "store_true", dest = "debug", default = False, 
                      help = "Print much more information, [default: %default]")
    (options, args) = parser.parse_args()

    if options.verbose:
        logging.getLogger().setLevel(logging.INFO)

    if options.debug:
        logging.getLogger().setLevel(logging.DEBUG)

    if options.same is None:
        options.same = "same-%s-%s.filelist" % (args[0], args[1])
    if options.diff is None:
        options.diff = "diff-%s-%s.filelist" % (args[0], args[1])

    logging.info("Options:" + str(options))
    logging.info("Args:" + str(args))

    if len(args) != 2:
        parser.print_usage()
        sys.exit(1)

    main(args[0], args[1], options.thread, options.same, options.diff)
