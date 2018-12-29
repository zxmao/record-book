### 仓库

  - 仓库(Repository)
  - 集中存放镜像的地方

#### I. Docker Hub

  > 官方维护的公共仓库https://hub.docker.com

  - docker login
  - docker tag gaomd/ikev2-vpn-server:0.3.0 junxiongz/ikev2-vpn-server:0.3.0
  - docker push junxiongz/ikev2-vpn-server:0.3.0

#### II. Docker Pool(http://dockerpool.com)

  > 国内专业的Docker技术社区

  > 查看镜像

  - http://www.dockerpool.com/downloads

  > 下载镜像

  - docker pull
  - 在镜像名称前添加注册服务器的具体地址dl.dockerpool.com:5000
  - docker pull dl.dockerpool.com:5000/ubuntu:12.04
  - docker images

#### III. 创建和使用私有仓库

  > 使用registry镜像创建私有仓库

  - docker run -d -p 5000:5000 registry

  > 默认情况 在容器/tmp/registry 目录下

  > 通过-v 参数将镜像文件存放在本地的指定路径上

  - -v /opt/data/registry 本地路径
  - :/tmp/registry      容器路径
  - docker run -d -p 5000:5000 -v /opt/data/registry:/tmp/registry registry
  - docker tag gaomd/ikev2-vpn-server:0.3.0 150.109.61.190:5000/ikev2-vpn-server:0.3.0
  - docker push 150.109.61.190:5000/ikev2-vpn-server:0.3.0
  - http: server gave HTTP response to HTTPS client
  - 出现这问题的原因是：Docker自从1.3.X之后docker registry交互默认使用的是HTTPS，但是搭建私有镜像默认使用的是HTTP服务，所以与私有镜像交时出现以上错误
  - 解决方法:网上搜索
  - curl http://150.109.61.190:5000/v1/search
