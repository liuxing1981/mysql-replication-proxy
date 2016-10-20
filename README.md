mysql replication and proxy


This is just the startup shell srcips which include three main files:
master.sh: start a mysql service as master.
slave.sh: start a mysql service as slave.
mysql-proxy.sh: start a mysql-proxy service as proxy.

1. You should install docker first.
https://docs.docker.com/engine/installation/

2. Pull the nessesary docker images use the command as below:
	docker pull mysql:5.5
	docker pull pataquets/mysql-proxy

3. Run the master.sh.Then a file named master_slave.conf be created.
	./master.sh

4. Run the slave.sh with argument master_slave.conf.If you run the slave.sh in another computer,
   should copy the master_slave.conf from the master manually with scp command.
	./slave.sh master_slave.conf

5. Run the mysql-proxy.sh.
	./mysql-proxy.sh

All the mysql server username is root,and password is root.
master port: 33306
slave port : 33307
proxy port: 3306

You can access the server:
master:	mysql -uroot -proot -P33306
slave : mysql -uroot -proot -P33307
proxy:  mysql -uroot -proot 

If you have any question,email this xing.liu@centling.com.

