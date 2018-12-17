#!/usr/bin/env python
import urllib2
import time
import sys
import os
import json


def main():
    cont_imgs = os.popen('docker ps --format "{{.Image}}"').read()
    imgs_lines = cont_imgs.split('\n')
    shl_services = []
    for img in imgs_lines:
        if 'sharelatex' in img and 'redis-syncer' not in img:
            img_clean = img.replace('gtato/', '')
            if img_clean == 'sharelatex-web':
                img_clean = 'sharelatex-web-80'
            shl_services.append(img_clean )
        if 'redis' in img and 'redis-syncer' not in img:
            shl_services.append(img)
    print shl_services

    contents = []
    for i in range(5):
        time.sleep(1)
        try:
            contents = json.loads(urllib2.urlopen("http://localhost:8008/api/list/local").read())
            if len(contents) == 0:
                print 'services not registered yet'
            else:
                break
        except:
            print 'koala is not up yet'

    # ok now what is there is there
    registered = []
    for s in contents:
        registered.append(s['name'])

    nr_not_registered = 0
    for n in shl_services:
        if n not in registered:
            nr_not_registered += 1

    if nr_not_registered > 0:
        print 'restarting registrator'
        os.popen('docker-compose -f docker-compose-koala-core.yml restart registrator')

if __name__ == "__main__":
    main()
