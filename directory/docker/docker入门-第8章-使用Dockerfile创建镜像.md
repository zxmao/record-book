### 使用Dockerfile创建镜像

#### I.基本结构

  > 分四部分:

  - 基础镜像信息
  - 维护者信息
  - 镜像操作指令
  - 容器启动时指令

  - # 第一行必须制定基于的基础镜像
  - FROM ubuntu

  - # 维护者信息
  - MAINTAINER docker_user junxiongz@163.com

  - # 镜像操作指令
  - RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
  - RUN apt-get update && apt-get install -y nginx
  - RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

  - # 容器启动时执行命令
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
    - 改命令将复制指定的<src>到容器中的<dest>
    - <src>可以是Dockerfile所在目录的一个相对路径,也可以是一个URL,还可以是一个 tar 文件

  > 8.COPY

    - 格式为COPY <src> <dest>
    - 复制本地主机的<src>为容器中的<dest>,如果目标路径不存在,会自动创建.
    - 当使用本地目录为源目录时,推荐使用COPY

  > 9.ENTRYPOINT

    - 有两种格式:
    - ENTRYPOINT ["exectable","param1","param2"]
    - ENTRYPOINT command param1 param2 (shell 中执行)
    - 配置容器启动后执行的命令,并且不可被 docker run 提供的参数覆盖
    - 每个Dockerfile 中只有一个ENTRYPOINT,当指定多个时,只有最后一个生效.

  > 10.VOLUME

    - 格式为VOLUME ["/data"]
    - 创建一个可以从本地主机或其他容器挂载的挂载点,一般用来存放数据库和需要保持的数据等.

  > 11.USER

    - 格式为USER daemon
    - 指定运行容器时的用户名或者UID,后续的RUN也会只用指定用户
    - 当服务不需要管理员权限时,可以通过该命令指定运行用户. 并且可以在之前创建所需要的用户
    - RUN groupadd -r postgres && useradd -r -g postgres postgres
    - 要临时获取管理员权限可以使用gosu,不推荐sudo

 > 12.WORKDIR

    - 格式为WORKDIR /path/to/workdir
    - 为后续的RUN,CMD,ENTRYPOINT 指令配置工作目录
    - WORKDIR /a
    - WORKDIR b
    - WORKDIR c
    - RUN pwd

 > 13.ONBUILD

    - 格式为 ONBUILD [INSTRUCTION]
    - 配置当所创建的镜像作为其他新创建镜像的基础镜像时,所执行的操作指令.
    - 例如,Dockerfile 使用如下内容创建了镜像 image-A
    - [...]
    - ONBUILD ADD . /app/src
    - ONBUILD RUN /user/local/bin/python-build --dir /app/src
    - [...]
    - 如果基于 image-A 创建新的镜像时,新的Dockerfile中使用FROM image-A 指定基础镜像时,会自动执行ONBUILD指令内容,等价于在后面添加了两条指令
    - FROM image-A
    - automatically run the following 注释
    - ADD . /app/src
    - RUN /usr/local/bin/python-build --dir /app/src
    - 使用ONBUILD指令的镜像,推荐在标签中注明,例如 ruby:1.9-onbuild

#### III.创建镜像

  - 1.编写完成Dockerfile之后,可以通过 docker build 命令来创建镜像
  - 2.基本的格式为 docker build[选项]路径,改命令将读取指定路径下的Dockerfile,并将改路径下所有内容发送给Docker服务端,由服务端来创建镜像
  - 3.因此一般建议放置Dockerfile的目录为空目录
  - 4.可以通过 .dockerignore 文件 让 docker 忽略路径下的目录和文件
  - 5.要制定镜像标签信息,可通过-t选项
  - sudo docker build -t build_repo/frist_image /tmp/docker_builder/
