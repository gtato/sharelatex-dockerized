#!/usr/bin/env python
import urllib2
import time
import sys
import os

def main():
    for i in range(2):
        try:
            contents = urllib2.urlopen("http://localhost:8008/").read()
            if 'No services registered yet' not in contents:
                sys.exit(0)
        except:
            print 'koala is not up yet'
        time.sleep(2)

    print 'restarting registrator'
    os.popen('docker-compose -f docker-compose-koala-core.yml restart registrator')  

if __name__ == "__main__":
    main()
