#!/bin/bash

mongod --config /etc/mongod.conf&
node /app/app.js

