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
