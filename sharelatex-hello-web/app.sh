#!/bin/bash

mongod --config /etc/mongod.conf&
service nginx start&
nodemon app.js

