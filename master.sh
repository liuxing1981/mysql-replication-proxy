docker rm -f master 2>/dev/null 
MASTER=$(docker run --name master \
-v /home/docker/master:/var/lib/mysql \
-p 33306:3306 \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:5.5 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci \
--server-id=1 \
--log-bin=mysql-bin \
--log-slave-updates=1)
sleep 2

MASTER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $MASTER)

docker exec master mysql -uroot -proot -e "GRANT REPLICATION SLAVE ON *.* to 'slave'@'%' identified by 'centling';flush privileges;"

POS=$(docker exec master mysql -uroot -proot  -e "show master status \G" | grep Position | awk '{print $2}')
FILE=$(docker exec master mysql -uroot -proot  -e "show master status \G" | grep File | awk '{print $2}')

CONF_FILE=master_slave.conf

touch $CONF_FILE
>$CONF_FILE
echo $MASTER_IP >> $CONF_FILE
echo $POS >> $CONF_FILE
echo $FILE >> $CONF_FILE
cat $CONF_FILE





#docker exec master /etc/init.d/mysqld restart


