镜像

1.获取镜像
  1.1 获取镜像
    docker pull ubuntu
  1.2 指定版本获取
    docker pull ubuntu:14.04
  1.3 指定注册服务器仓库下载
    docker pull registry.hub.docker.com/unbutu:14.04
    docker pull dl.dockerpool.com:5000/unbutu:14.04
  1.4 创建容器,运行bash
    docker run -t -i ubuntu /bin/bash

2.查看镜像信息
  2.1 列出本地主机上已有的镜像
    docker images
  2.2 添加新的镜像标签
    docker tag dl.dockerpool.com:5000/ubuntu:latest ubuntu:latest
  2.3 获取镜像详细信息
    docker inspect [IMAGE ID]
  2.4 获取镜像详细信息 某一行
    docker inspect [IMAGE ID] -f {{".Architecture"}}

3.搜寻镜像 默认搜索Docker Hub官方仓库中的镜像
  3.1 docker search TERM 支持参数包括:
    --automated=false 仅显示自动创建的镜像
    --no-trunc=false  输出信息不截断显示
    -s, --stars=0     指定仅显示评价为指定星级以上的镜像

  3.2 docker search mysql
    返回信息包含: 镜像名称,描述,星级,是否官方创建,是否自动创建

4.删除镜像
  4.1 使用镜像标签删除镜像,IMAGE可以为标签或ID
    docker rmi [IMAGE ID]
    docker rmi dl.dockerpool.com:5000/ubuntu
    注意:当镜像中只剩下一个标签的时候,再次执行docker rmi命令会彻底删除该镜像
    当删除镜像有创建的容器时,镜像文件默认无法删除
    使用 docker ps -a 查看本机上存在的所有容器
  4.2 强行删除镜像,使用 -f 参数:
    docker rmi [IMAGE] -f ubuntu
    注意:不建议强制删除,使用docker images查看本地镜像,会发现标签为<none>的临时镜像
  4.3 正确删除镜像,先删除该镜像的所有容器,再删除镜像. [CONTAINER ID]为容器ID
    docker rm [CONTAINER ID]
    docker rmi [IMAGE ID]

5.创建镜像
  创建镜像的方法有三种:
    I.    基于已有镜像的容器创建
    II.   基于本地模板导入
    III.  基于Dockerfile创建

  5.0 基于已有镜像的容器创建
    docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]] 主要选项包括:
      -a, --authoer=""    作者信息
      -m, --message=""    提交信息
      -p, --pause=true    提交时暂停容器运行
  5.1 演示-基于已有镜像的容器创建
    1. docker run -ti ubuntu:14.04 /bin/bash
    2. touch test
    3. exit
    4. docker commit -m "添加一个测试文件test" -a "Christopher" 8448b61d4d26 christopher/test
       sha256:c06c012b32aca8c7153c35eb8f4be21dd2e62fa4bb821982dc83163e6b123ad2
    5. docker run christopher/test echo 'hello! I am new images for test!'
       hello! I am new images for test!
  5.2 基于本地模板导入
      可以直接从一个操作系统模板文件导入一个镜像
      这里使用OpenVZ提供的模板创建,OpenVZ模板下载地址 http://openvz.org/Download/templates/precreated
  5.3 演示-基于本地模板导入
    0. wget https://download.openvz.org/template/precreated/ubuntu-14.04-x86_64-minimal.tar.gz
    1. cat ubuntu-14.04-x86_64-minimal.tar.gz |docker import - templates/ubuntu:14.04
    2. docker images

6.存出和载入镜像
  6.0 使用docker save和 docker load
  6.1 存出镜像 docker save -o [存出文件名字] [镜像名称]
      docker save -o ubuntu_14.04.tar christopher/test
  6.2 导入镜像 docker load --input [存出文件名字],docker load < [存出文件名字]
      docker load --input ubuntu_14.04.tar
      docker load < ubuntu_14.04.tar

7.上传镜像
  7.0 使用 docker push 默认上传到DockerHub官方仓库 需要登录 docker push NAME[:TAG]
      用户user
      演示-
    1. 添加新的镜像标签
        docker tag test:latest user/test:latest
    2. 上传镜像
      docker push user/test:latest
