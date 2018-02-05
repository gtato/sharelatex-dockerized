#!/bin/bash

mongod --config /etc/mongod.conf&

touch .foreverignore
forever -w app.js
