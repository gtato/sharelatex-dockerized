#!/bin/bash

mongod --config /etc/mongod.conf&
nodemon /app/app.js

