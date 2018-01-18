#!/bin/bash

mongod --config /etc/mongod.conf&
service nginx start&
npm run start

