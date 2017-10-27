
## 1.首先创建两个文件my-m.cnf（主库配置） 、my-s.cnf（从库配置） 

## 2.启动mysql master容器 
   docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql-master -v /root/local_conf/mysql_conf/my-m.cnf:/etc/mysql/my.cnf -p 3308:3306 mysql:5.7.20

## 3.启动mysql slave容器
   docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql-slave -v /root/local_conf/mysql_conf/my-s.cnf:/etc/mysql/my.cnf -p 3309:3306 mysql:5.7.20

## 4.连接主库，创建一个用户用来同步数据 *.*
   GRANT REPLICATION SLAVE ON \*.\* to 'backup'@'%' identified by '123456';

## 5.查看主库状态
   show master status;
   
## 6.连接到从库，设置主库链接
   change master to master_host='47.90.125.13',master_user='backup',master_password='123456',master_log_file='mysql-bin.000003',master_log_pos=431,master_port=3308;

## 7.启动同步
   start slave;
   
## 8.查看同步状态
   show slave status
