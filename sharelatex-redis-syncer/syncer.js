const express = require('express')
const bodyParser   = require('body-parser')
var redis = require('redis');


const app = express()
app.use(bodyParser.urlencoded());
app.use(bodyParser.json());

var ptrn = 'sess*'
var redisClients = {}
var sessions={}


// addRedis('192.168.56.1', '6379')
// addRedis('192.168.56.100', '6379')

app.post('/add_redis', function (req, res) {
    host = req.body.host
    port = req.body.port
    addRedis(host, port)
    res.send('OK')
  
})

function addRedis(host, port){
  rc = redis.createClient(port, host);
    
  rc.on("error", function(err) { 
    onConnectionFail(rc, err);
  });

  rc.on('connect', function() {
    onConnect(rc)
  });
}

function onConnectionFail(rc, err){
  console.error("Error connecting to redis"); 
  rc.quit()
}

function onConnect(rc){
    rc.config("SET", "notify-keyspace-events", "Kg\$");
    rc.keys(ptrn, function(err, replies){
      keys = replies
      rc.mget(replies, function(err, replies){
        initalSync(rc, keys, replies)
      });
    })
    
}

function initalSync(rc, keys, vals){
  console.log('initial sync for %s', rc.address);
  kval = []

  for(sess in sessions){
    if (keys.indexOf(sess) == -1){
      kval.push(sess)
      kval.push(sessions[sess])
    }
  }

  if (kval.length > 0) rc.mset(kval);  

  kval = []
  if (keys != null){
    for(var i = 0; i < keys.length; i++){
      if (!(keys[i] in sessions)){
        kval.push(keys[i])
        kval.push(vals[i])
        sessions[keys[i]] = vals[i]
      }
    }
  }

  if (kval.length > 0) {
    for(addr in redisClients){
      if(addr == rc.address) continue
      readc = redis.createClient('redis://'+addr);
      readc.mset(kval);  
    }
  }

  rc.psubscribe('__keyspace@0__:'+ptrn);
  rc.on('pmessage', function(pattern, channel, message) {
      onKeyUpdated(rc, pattern, channel, message)
  });
  redisClients[rc.address] = rc
  console.log('%s connected successfully', rc.address);
}

last_set = ''
last_del = ''
function onKeyUpdated(rc, pattern, channel, message){
   key = channel.split('__:')[1]
   if (message == 'set'){
      last_set = key
      readc = redis.createClient('redis://'+rc.address);
      readc.get(key, function(err, reply){onSetKey(rc, key, err, reply)});
   }
   if (message == 'del'){
      last_del = key
      onDelKey(rc, key)
   }
}


function onSetKey(crc, ckey, err, reply){
  cval = reply
  key = last_set //ckey gets confused 
  if(key in sessions && sessions[key] == cval) return 
  sessions[key]=cval
  for(rcaddress in redisClients){
    if (rcaddress == crc.address) continue
    readc = redis.createClient('redis://'+rcaddress);
    readc.set(key, cval);  
    // readc.get(key, function(err, reply){onGetOldKey(readc, key, cval, err, reply)});  
  }
}

// function onGetOldKey(rc, key, cval, err, reply){
//   if(cval != reply)
//     readc.set(key, cval);  
// }

function onDelKey(crc, ckey){
  key = last_del  
  if (!(key in sessions)) return
  delete sessions[key]
  for(rcaddress in redisClients){
    if (rcaddress == crc.address) continue
    readc = redis.createClient('redis://'+rcaddress);
    readc.del(key);  
  }
}

app.get('/*', function (req, res) {
    sesstxt = 'Sessions:<br>'
    for(k in sessions){
        sesstxt += k + ' => ' + sessions[k]+'<br>' 
    } 

    redistxt = 'Redises:<br>'
    for(addr in redisClients)
      redistxt += addr + '<br>' 

    res.send('<h1>Welcome to Redis syncer !</h1><br>'+redistxt+'<br>'+sesstxt)
})


port = 8006
app.listen(port, () => console.log('Syncer listening on port:' + port))



