### 通过 yum 安装mysql

### http://www.centoscn.com/mysql/2016/0315/6844.html

### mysql 常用命令

- rpm -qi mysql-community-server.x86_64 0:5.6.24-3.el7

- whereis mysql

- 启动 MySQL Server
  systemctl start  mysqld
  
- 查看 MySQL Server 状态
  systemctl status  mysqld
  
- 关闭 MySQL Server
  systemctl stop mysqld
  
- vi /etc/sysconfig/iptables #开放端口

- -A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 3306 -j ACCEPT

- -A RH-Firewall-1-INPUT -m state –state NEW -m udp -p udp –dport 3306 -j ACCEPT

- service iptables restart

### 方式2：firewall-cmd（推荐）
执行

- firewall-cmd --permanent --zone=public --add-port=3306/tcp
- firewall-cmd --permanent --zone=public --add-port=3306/udp
这样就开放了相应的端口。

### 执行

- firewall-cmd --reload 
使最新的防火墙设置规则生效。

- mysql_secure_installation;

创建普通用户
- CREATE USER 'Christopher'@'%' IDENTIFIED BY 'some_pass'; 

给这个用户授予 SELECT,INSERT,UPDATE,DELETE 的远程访问的权限，这个账号一般用于提供给实施的系统访问
- GRANT SELECT,INSERT,UPDATE,DELETE  ON *.* TO 'Christopher'@'%';  

创建一个管理员用户 admin 账号 ，密码是 some_pass
- CREATE USER 'admin'@'%' IDENTIFIED BY 'some_pass';

给这个用户授予所有的远程访问的权限。这个用户主要用于管理整个数据库、备份、还原等操作。
- GRANT ALL  ON *.* TO 'admin'@'%';


### 其他常用配置配置
调整 MySQL 运行参数，修改 /etc/my.cnf 文件，常用配置如下：

[mysqld]   
basedir      = path          # 使用给定目录作为根目录(安装目录)。
datadir      = path          # 从给定目录读取数据库文件。
pid-file     = filename      # 为mysqld程序指定一个存放进程ID的文件(仅适用于UNIX/Linux系统);


socket = /tmp/mysql.sock     # 为MySQL客户程序与服务器之间的本地通信指定一个套接字文件(Linux下默认是/var/lib/mysql/mysql.sock文件)
port             = 3306      # 指定MsSQL侦听的端口
key_buffer       = 384M      # key_buffer是用于索引块的缓冲区大小，增加它可得到更好处理的索引(对所有读和多重写)。
                               索引块是缓冲的并且被所有的线程共享，key_buffer的大小视内存大小而定。
table_cache      = 512       # 为所有线程打开表的数量。增加该值能增加mysqld要求的文件描述符的数量。可以避免频繁的打开数据表产生的开销
sort_buffer_size = 2M        # 每个需要进行排序的线程分配该大小的一个缓冲区。增加这值加速ORDER BY或GROUP BY操作。
                               注意：该参数对应的分配内存是每连接独占！如果有100个连接，那么实际分配的总共排序缓冲区大小为100×6=600MB
read_buffer_size = 2M        # 读查询操作所能使用的缓冲区大小。和sort_buffer_size一样，该参数对应的分配内存也是每连接独享。
query_cache_size = 32M       # 指定MySQL查询结果缓冲区的大小
read_rnd_buffer_size    = 8M # 改参数在使用行指针排序之后，随机读用的。
myisam_sort_buffer_size =64M # MyISAM表发生变化时重新排序所需的缓冲
thread_concurrency      = 8 # 最大并发线程数，取值为服务器逻辑CPU数量×2，如果CPU支持H.T超线程，再×2
thread_cache            = 8 # #缓存可重用的线程数
skip-locking                 # 避免MySQL的外部锁定，减少出错几率增强稳定性。
[mysqldump]
max_allowed_packet      =16M # 服务器和客户端之间最大能发送的可能信息包

[myisamchk]
key_buffer   = 256M
sort_buffer = 256M
read_buffer = 2M
write_buffer = 2M




