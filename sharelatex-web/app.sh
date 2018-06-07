#!/bin/bash

# [ "$(ip address show | grep 172 | cut -d '.' -f 2)" = "19" ] && core=0 || core=1

# if [ "$core" = 0 ] ; then
#     SHARELATEX_REAL_TIME_URL="http://real-time-core:3026"
# else
#     SHARELATEX_REAL_TIME_URL="http://real-time-edge:3026"
# fi

[ -z "$NGINX_CONFIG" ] && NGINX_CONFIG="DEFAULT"
[ -z "$SHARELATEX_REAL_TIME_URL" ] && SHARELATEX_REAL_TIME_URL="http://real-time:3026"
[ -z "$SHARELATEX_WEB_URL" ] && SHARELATEX_WEB_URL="http://web:80"


if [ "$NGINX_CONFIG" = "KOALA" ]
then 
cp /app/sharelatex_koala.conf /etc/nginx/sites-enabled/sharelatex.conf
else
cp /app/sharelatex_def.conf /etc/nginx/sites-enabled/sharelatex.conf
fi


sed -i 's@SHARELATEX_REAL_TIME_URL@'"$SHARELATEX_REAL_TIME_URL"'@g' /etc/nginx/sites-enabled/sharelatex.conf
sed -i 's@SHARELATEX_WEB_URL@'"$SHARELATEX_WEB_URL"'@g' /etc/nginx/sites-enabled/sharelatex.conf

mongod --config /etc/mongod.conf&
service nginx start&
nodemon 
# npm run start

