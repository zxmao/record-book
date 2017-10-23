### 查看所有镜像
    docker images

### 正在运行容器
    docker ps

### 查看docker容器
    docker ps -a

### 启动tomcat:7镜像
    docker run -p 8080:8080 tomcat:7

### 以后台守护进程的方式启动
    docker run -d tomcat:7

### 停止一个容器
    docker stop b840db1d182b

### 进入一个容器
    docker attach d48b21a7e439

### 进入正在运行容器并以命令行交互
    docker exec -it e9410ee182bd /bin/sh

### 以交互的方式运行
    docker run -i -t -p 8081:8080 tomcat:7 /bin/bash
 
## Docker容器和本机之间的文件传输。
    http://blog.csdn.net/leafage_m/article/details/72082011
