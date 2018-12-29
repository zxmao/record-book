### 使用Dockerfile创建镜像

#### I.基本结构

  > 分四部分:

  - 基础镜像信息
  - 维护者信息
  - 镜像操作指令
  - 容器启动时指令

  - 第一行必须制定基于的基础镜像
  - FROM ubuntu

  - 维护者信息
  - MAINTAINER docker_user junxiongz@163.com

  - 镜像操作指令
  - RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
  - RUN apt-get update && apt-get install -y nginx
  - RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

  - 容器启动时执行命令
  - CMD /user/sbin/nginx

#### II.指令

  > 指令的一般格式为INSTRUCTION arguments,指令包括FROM,MAINTAINER,RUN等

  > 1.FROM

    - 格式为<image>或FROM<image>:<tag>
    - 第一条指令必须为FROM指令. 并且,如果在同一个Dockerfile中创建多个镜像时,可以使用多个FROM指令(每个镜像一次)

  > 2.MAINTAINER

    - 格式为MAINTAINER <name>,指定维护者信息

  > 3.RUN

    - 格式为RUN <command> 或 RUN ["executable","param1","param2"]

  > 4.CMD

    - CMD ["executable","param1","param2"]使用 exec 执行,推荐方式
    - CMD command param1 param2 在/bin/sh 中执行,提供给需要交互的应用
    - CMD ["param1","param2"] 提供给ENTRYPOINT的默认参数
    - 指定启动容器时执行的命令,每个Dockerfile 只能有一条CMD命令,如果指定多条,会执行最后一条.
    - 如果用户启动容器时候指定了运行的命令,则会覆盖掉CMD指定的命令

  > 5.EXPOSE

    - 格式为EXPOSE <port> [<port> ...]
    - EXPOSE 22 80 8443
    - 告诉Docker 服务端容器暴露的端口号.

  > 6.ENV

    - 格式为ENV <key> <value> 指定一个环境变量,会被后续RUN指令使用,并在容器运行时保持
    - ENV PG_MAJOR 9.3
    - ENV PG_VERSION 9.3.4
    - RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && ...
    - ENV PATH /usr/local/postgres-$PG_MAJOR/bin:$PATH

  > 7.ADD

    - 格式为ADD <src> <dest>
