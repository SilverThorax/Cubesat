#!/bin/sh

# Start Mongo database server...
mongod --smallfiles --noprealloc --dbpath database/ &

sleep 10

# Start Aspen development server
aspen -a 0.0.0.0:80 -p ./ -w ./www
