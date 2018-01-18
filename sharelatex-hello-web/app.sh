#!/bin/bash

mongod --config /etc/mongod.conf&
service nginx start&
node app.js

