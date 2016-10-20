#!/bin/bash

docker rm -f mysql-proxy 2>/dev/null
docker run --name mysql-proxy \
-p 3306:3306 \
--link master:master \
--link slave:slave \
-d pataquets/mysql-proxy \
-r slave:3306 \
-b master:3306 \
--user=root \
--admin-username=root \
--admin-password=root \
--keepalive=true \
--admin-lua-script=/usr/share/mysql-proxy/admin.lua \
--proxy-lua-script=/usr/share/mysql-proxy/rw-splitting.lua 
#--log-level=debug \
#--log-file=/opt/mysql-proxy/log/mysql-proxy.log \
#mysql -uroot -proot -P4041 -h127.0.0.1
