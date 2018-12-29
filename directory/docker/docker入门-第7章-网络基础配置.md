### 网络基础配置

  - 映射容器端口到宿主主机
  - 容器互联机制

#### I.端口映射实现访问容器

  > 1.从外部访问容器应用

  - 通过 -P 或 -p 参数来指定端口映射
  - 使用 -P Docker会随机映射一个49000 ~ 49900的端口至容器内部开放的网络端口
  - docker run -d -P training/webapp python app.py
  - docker ps -l
  - 0.0.0.0:32768->5000/tcp
  - docker logs -f epic_rosalind 命令查看应用信息
  - -p(小写)则可以指定要映射的端口,并且,在一个指定端口上只可以绑定一个容器. 支持格式 ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort

  > 2.映射所有接口地址

  - 使用hostPort:containerPort格式将本地的5000端口映射到容器的5000端口
  - docker run -d -p 5000:5000 trainning/webapp python app.py
  - 多次使用 -p 标记可以绑定多个端口
  - docker run -d -p 5000:5000 -p 3000:80 trainning/webapp python app.py

  > 3.映射到指定地址的指定端口

  - 使用ip:hostPort:contaninerPort格式指定映射使用一个特定地址
  - docker run -d -p 127.0.0.1:5000:5000 trainning/webapp python app.py

  > 4.映射到指定地址的任意端口

  - 使用ip:contaninerPort绑定localhost的任意端口到容器的5000端口,本地主机会自动分配一个端口
  - docker run -d -p 127.0.0.1::5000 trainning/webapp python app.py
  - 可以使用udp标记来指定udp端口
  - docker run -d -p 127.0.0.1::5000/udp trainning/webapp python app.py

  > 5.查看映射端口配置

  - 使用docker port来查看当前映射的端口配置,也可以查看到绑定的地址:
  - docker port epic_rosalind
  - 5000/tcp -> 0.0.0.0:32768

#### II.容器互联实现容器间通信

  > 1.自定义容器命名

  - --name 标记可以为容器自定义命名
  - docker run -d -P --name web training/webapp python app.py
  - docker ps
  - docker inspect -f "{{.Name}}" 0114142b5f0d

  - 执行 docker run 的时候如果添加 --rm标记,会在容器终止后立刻删除, --rm 和 -d参数同时使用

  > 2.容器互联

  - 使用 --link 参数可以让容器之间安全的进行交互
  - docker run -d --name db training/postgres
  - docker rm -f web
  - docker run -d -P --name web --link db:db training/webapp python app.py
  - --link参数的格式为--link name:alias
  - docker ps
  - Docker在两个互联的容器之间创建了一个安全隧道,而且不用映射他们的端口到宿主主机上.在启动容器的时候没有使用-P和-p 标记,从而避免了暴露数据库端口到外部网络上

  > docker 通过两种方式为容器公开连接信息:

  - 环境变量
  - 更新/etc/hosts 文件

  > 使用 env 命令来查看 web 容器的环境变量:

  - docker run --rm --name web2 --link db:db training/webapp env
  - PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  - HOSTNAME=56170b0261e4
  - DB_PORT=tcp://172.17.0.4:5432
  - DB_PORT_5432_TCP=tcp://172.17.0.4:5432
  - DB_PORT_5432_TCP_ADDR=172.17.0.4
  - DB_PORT_5432_TCP_PORT=5432
  - DB_PORT_5432_TCP_PROTO=tcp
  - DB_NAME=/web2/db
  - DB_ENV_GOSU_VERSION=1.10
  - DB_ENV_LANG=en_US.utf8
  - DB_ENV_PG_MAJOR=10
  - DB_ENV_PG_VERSION=10.4-2.pgdg90+1
  - DB_ENV_PGDATA=/var/lib/postgresql/data
  - HOME=/root

  >  cat exec -ti web /bin/bash

  - 127.0.0.1	localhost
  - ::1	localhost ip6-localhost ip6-loopback
  - fe00::0	ip6-localnet
  - ff00::0	ip6-mcastprefix
  - ff02::1	ip6-allnodes
  - ff02::2	ip6-allrouters
  - 172.17.0.4	db 05643893354e
  - 172.17.0.5	1c0cd9b13be6

  - 在web容器中安装 ping 命令来测试跟 db 容器的连通,包括容器中使用apt-get安装各种需要的工具
  - cat exec -ti web /bin/bash
  - apt-get install -yqq inetutils-ping
  - ping db
  - apt-get install vim
  - apt-get install telnet
  - apt-get install net-tools
  - apt-get update
