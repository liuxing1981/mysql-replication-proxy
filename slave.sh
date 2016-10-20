if [ -n "$1" ];then
	k=0
	for line in $(cat $1);do 
		arr[k]=$line
		k=$k+1
	done
fi

docker rm -f slave 2>/dev/null 
SLAVE=$(docker run --name slave \
-v /home/docker/slave:/var/lib/mysql \
-p 33307:3306 \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:5.5 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci \
--server-id=2 \
--log-bin=mysql-bin \
--log-slave-updates=1 \
--auto_increment_increment=2 \
--auto_increment_offset=2)
sleep 2

MYSQL02_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $SLAVE)

docker exec $SLAVE mysql -uroot -proot -e "
reset slave;
CHANGE MASTER TO master_host='${arr[0]}',
master_port=3306,
master_user='slave',
master_password='centling',
master_log_pos=${arr[1]},
master_log_file='${arr[2]}';
start slave;
show slave status;
"

#docker exec master /etc/init.d/mysqld restart


