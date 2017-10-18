
## 下载zookeeper镜像
  docker pull zookeeper

## 0.开始zookeeper 服务实例
  docker run --name some-zookeeper --restart always -d zookeeper

## 1.运行zookeeper容器
  docker run --name some-app --link some-zookeeper:zookeeper -d application-that-uses-zookeeper

## 2.连接 zookeeper 服务
  docker run -it --rm --link some-zookeeper:zookeeper zookeeper zkCli.sh -server zookeeper
  
## 默认配置文件 zoo_sample.cfg
  
## 修改使用配置文件 zoo.cfg  
  
