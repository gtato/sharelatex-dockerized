#!/bin/bash

mongod --config /etc/mongod.conf&
service nginx start&
export SHARELATEX_CONFIG=/etc/sharelatex/settings.coffee
npm run start

