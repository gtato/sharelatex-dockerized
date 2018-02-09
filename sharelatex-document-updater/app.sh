#!/bin/bash

mongod --config /etc/mongod.conf&

forever -w --watchDirectory app/js/  app.js
#nodemon app.js