#!/bin/sh
gitbook build
git add *
git commit -m "update new passage"
git push
server2
cd /var/www/gitbook-algorithms
git pull origin master
