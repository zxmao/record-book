## PS:如果第一种方式不行,可以使用这种方式

## 1.创建master/slave配置文件目录及文件

####  -- master

      mkdir /usr/local/mysqlData/master/cnf
      mkdir /usr/local/mysqlData/master/data
      vim /usr/loal/mysqlData/master/cnf/mysql.cnf

#### --slave

      mkdir /usr/local/mysqlData/slave/cnf
      mkdir /usr/local/mysqlData/slave/data
      vim /usr/loal/mysqlData/slave/cnf/mysql.cnf
      
## 2.启动master容器

    docker run -itd -p 3306:3306 --name master -v /usr/local/mysqlData/master/cnf:/etc/mysql/conf.d -v /usr/local/mysqlData/master/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7.20
   
## 3.进入master容器,复制master用户

    docker exec -it ${容器ID} /bin/bash
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
    GRANT REPLICATION SLAVE ON *.* to 'reader'@'%' identified by '123456';
    FLUSH PRIVILEGES;
    
## 4.启动slave容器
    
    docker run -itd -p 3307:3306 --name master -v /usr/local/mysqlData/slave/cnf:/etc/mysql/conf.d -v /usr/local/mysqlData/slave/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7.20
    
## 5.创建远程连接用户，并赋予查询数据库，以及查询的权限，可以用于读写分离    

    docker exec -it ${容器ID} /bin/bash
    mysql -uroot -p123456
    grant SHOW DATABASES,SELECT on *.* to 'slave'@'%' identified by '123456';
    FLUSH PRIVILEGES;
    
## 6.进入master,查看binlog是否开启

    show master status;
    +------------------+----------+--------------+------------------+-------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
    +------------------+----------+--------------+------------------+-------------------+
    | mysql-bin.000003 |      675 |              |                  |                   |
    +------------------+----------+--------------+------------------+-------------------+
    
    show variables like 'log_%';
    
    +----------------------------------------+---------------------------------------+
    | Variable_name                          | Value                                 |
    +----------------------------------------+---------------------------------------+
    | log_bin                                | ON                                    | ------> ON表示已经开启binlog日志
    | log_bin_basename                       | /usr/local/mysql/data/mysql-bin       |
    | log_bin_index                          | /usr/local/mysql/data/mysql-bin.index |
    | log_bin_trust_function_creators        | OFF                                   |
    | log_bin_use_v1_row_events              | OFF                                   |
    | log_error                              | /usr/local/mysql/data/martin.err      |
    | log_output                             | FILE                                  |
    | log_queries_not_using_indexes          | OFF                                   |
    | log_slave_updates                      | OFF                                   |
    | log_slow_admin_statements              | OFF                                   |
    | log_slow_slave_statements              | OFF                                   |
    | log_throttle_queries_not_using_indexes | 0                                     |
    | log_warnings                           | 1                                     |
    +----------------------------------------+---------------------------------------+
    
## 7.进入slave,同步master指定binlog日志版本
      
    change master to master_host='ip',master_user='reader',master_password='123456',master_log_file='mysql-bin.000003',master_log_pos=675;
    
    show slave status\G
    *************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.9
                  Master_User: reader
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000007
          Read_Master_Log_Pos: 501
               Relay_Log_File: 0b763a8d1ddd-relay-bin.000002
                Relay_Log_Pos: 320
        Relay_Master_Log_File: mysql-bin.000007
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
    
 ## 8.测试同步数据
 
    --进入master
    create database slavetest;
    
    --进入slave
    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | mysql              |
    | performance_schema |
    | slavetest          |
    | sys                |
    +--------------------+
    5 rows in set (0.00 sec)
    
    
    
