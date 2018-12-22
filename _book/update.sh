#!/bin/sh
gitbook build
git add *
git commit -m "update new passage"
git push
ssh root@123.207.143.168 << remotessh
cd /var/www/gitbook-algorithms
git pull origin master
exit
remotessh
cd ../../limengting
hexo g && hexo d
