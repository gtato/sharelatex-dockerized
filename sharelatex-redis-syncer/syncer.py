import redis
import time
import os
import sys
from threading import Thread

#DON'T FORGET TO: config set "notify-keyspace-events" "K$g" on each redis instance

rips = []
redises = {}

class RedisHandler():
    def __init__(self, ip):
        self.ip = ip

    def my_handler(self, message):
        key = message['channel'].split('__:')[1]
        if message['data'] == 'set':
            val = redises[self.ip].get(key)
        for rip in rips:
            if rip == self.ip:
                continue

            if message['data'] == 'del':
                redises[rip].delete(key)

            if message['data'] == 'set':
                cv = redises[rip].get(key)
                if cv != val:
                    redises[rip].set(key, val)
                pass

        # print key
        print 'handler %s' % message

def listener(p):
    for message in p.listen():
        print 'listen %s' % message

        
def main():
    redis_hosts = os.environ.get('REDIS_HOSTS')
    if redis_hosts is None:
        redis_hosts='192.168.56.1,192.168.56.100'
    down = []

    ctimeout = os.environ.get('REDIS_TIMEOUT')
    timeout = ctimeout if ctimeout is not None else 30
    
    t = 0

    redis_split = redis_hosts.split(',')
    for r in redis_split:
        rips.append(r.strip())
        down.append(r.strip())

    while len(down) > 0:
        up=[]
        for d in down:
            response = os.popen("redis-cli -h %s PING" % d).read()
            if response == 'PONG\n':
                up.append(d)
        for u in up:
            down.remove(u)

        if len(down) == 0:
            break
        print('instances: %s are still not running' % down)
        time.sleep(2)
        t+=1
        if t == timeout:
            sys.exit(1)

    for r in rips:
        response = os.popen('redis-cli -h %s config set "notify-keyspace-events" "Kg\$"' % r).read()
        print('%s: %s' % (r, response))        

    ps = {}
    ts = {}
    handlers = {}
    for rip in rips:
        redises[rip] = redis.StrictRedis(host=rip, port=6379, db=0)
        handlers[rip] = RedisHandler(rip)
        ps[rip] = redises[rip].pubsub()
        ps[rip].psubscribe(**{'__keyspace@0__:sess*': handlers[rip].my_handler})

        ts[rip] = Thread(target=listener, args=(ps[rip],))
        ts[rip].daemon=True
        ts[rip].start()

    while True:
        time.sleep(1)

if __name__ == "__main__":
    main()



