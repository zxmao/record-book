### 容器:

#### I.新建容器

  > 1. 使用 docker create 新建的容器处于停止状态

  - 使用 docker start 命令启动
  - docker create -it ubuntu:latest
  - b5aa272e4af73e48e117bc9bdbb9ea50ce64530f3d77933c813fa8c49df2e52e
  - docker ps
  - docker start b5aa272e4af7

 > 2. 新建并启动容器

  - 使用 docker run
  - docker run ubuntu /bin/echo 'hello world'
  - docker run -t -i ubuntu:14.04 /bin/bash
  - -t 选项让 docker 分配一个伪终端(pseudo-tty)
  - -i 让容器的标准输入保持打开
  - 对于所创建的bash容器,使用exit命令退出后,该容器自动处于终止状态.

 > 3. 守护态运行
  - -d(Daemonized) 参数实现
  - docker run -d ubuntu /bin/sh -c "while true;do echo hello word; sleep 1;done"
  - 0708051ade80e76fff00f24d49f05038c50a42270c839465c4aebd17e1cb7b6b
  - docker logs 0708051ade80

#### II .终止容器

  > docker stop 终止运行中的容器

  > docker stop [-t|--time[=10]] 默认10秒后终止

  - 1.发送SIGTERM信号
  - 2.发送SIGKILL信号终止

  - docker stop 0708051ade80
  - docker ps -a -q 查看终止状态的容器ID信息
  - docker ps -a 查看所有状态的容器ID信息
  - docker start 0708051ade80     启动停止的容器
  - docker restart 0708051ade80   重启正在运行的容器

#### III. 进入容器

  > 使用-d参数,容器会进入后台,用户无法看到容器中的信息

  > 进入方法:

  - 1.docker attach
  - 2.docker exec
  - 3.nsenter工具

  > 1. attach 命令 不建议,exit会停止容器

  - docker attach 是 docker 自带的命令
  - 不便:多个窗口同时 attach 到同一个容器,窗口会同步显示,某个窗口因命令阻塞时,其他窗口也无法执行操作

  - docker run -idt ubuntu
  - docker ps
  - docker attach nostalgic_hypatia

  > 2. exec 命令 建议,exit不会停止容器

  - docker 1.3版本提供了exec
  - docker exec -ti [containerid] /bin/bash

  > 3.nsenter 工具

  >  util-linux 包2.23版本后包含

  >  如果没有,源码安装:

  - cd /tmp; curl https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz | tar -zxf-; cd util-linux-2.24;
  - ./configure --without-ncurses
  - make nsenter && sudo cp nsenter /usr/local/bin

  > nsenter连接容器,需要找到容器进程PID

  -  PID=$(docker inspect --format "{{.State.Pid}}" <contaniner>)

  > 通过PID连接这个容器

  - nsenter --target $PID --mount --uts --ipc --net --PID

  >  example:

  - docker run -idt ubuntu
  - docker ps
  - PID=$(docker-pid <contaniner>)
  - sudo nsenter --target ${PID} --mount --uts --ipc --net --pid

  - docker run -idt ubuntu
  - docker ps
  - 0708051ade80
  - docker inspect --format "{{.State.Pid}}" 0708051ade80
  - sudo nsenter --target 22864 --mount --uts --ipc --net --pid

#### IV. 删除容器

  > docker rm 命令删除处于终止状态的容器

  > docker rm [OPTIONS] CONTAINER [CONTAINER...] 支持的选项包括

  - -f, --force=false     强行终止并删除一个运行中的容器
  - -l, --link=false      删除容器的连接,但保留容器
  - -v, --volumes=false   删除容器挂载的数据卷

  > 1.删除停止的容器

  - docker ps
  - docker rm 0708051ade80

  > 2.删除运行中的容器

  - docker ps
  - docker rm -f 0708051ade80

#### V.导入和导出容器

  > 1. 导出容器 docker export CONTAINER ,导出一个已经创建的容器到一个文件,不管此时这个容器是否处于运行状态

  - docker ps -a
  - docker export 0708051ade80 >test_for_run.tar
  - ls
  - test_for_run.tar
  - docker export f681dc734c0f >test_for_stop.tar
  - 可将这些文件传输到其他机器上,在其他机器上通过导入命令实现容器的迁移

 > 2. 导入容器 docker import 命令导入

  - cat test_for_run.tar | docker import - test/ubuntu:v1.0
  - docker images

  - docker import 和docker load 区别
  - docker load 命令导入镜像存储文件到本地的镜像库. 镜像文件保存完整记录,体积大
  - docker import 命令导入一个容器快照到本地镜像库. 容器快照文件将丢弃所有的历史记录和元数据信息
