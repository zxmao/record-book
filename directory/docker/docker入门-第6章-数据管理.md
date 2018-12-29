### 数据管理

  - 数据卷(Data Volumes)
  - 数据卷容器(Data Volume Dontainers)

#### I. 数据卷

  > 数据卷是一个可供容器使用的特殊目录,它绕过文件系统,可以提供多种特性:

  - 数据卷可以在容器之间共享和重用
  - 对数据卷的修改会立马生效
  - 对数据卷的更新,不会影响镜像
  - 卷会一直存在,直到没有容器使用

  > 1.在容器内创建一个数据卷 -v

  - 在用docker run命令的时候,使用-v标记可以在容器内创建一个数据卷. 多次使用-v 标记可以创建多个数据卷
  - example
  - docker run -d -P --name web -v /webapp training/webapp python app.py
  - -P 是允许外部访问容器需要暴露的端口

  > 2.挂载一个主机目录作为数据卷 -v

  - docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py
  - 加载主机的/src/webapp 挂载到容器的/opt/webapp目录

  - Docker 挂载数据卷默认权限是读写(rw),用户可以通过 ro 指定为只读,不可修改
  - docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py


  > 3.挂载一个本地主机文件作为数据卷 -v

  - docker run --rm -it -v ~/.bash_history:/.bash_history ubuntu /bin/bash

#### II. 数据卷容器 --volumes-from  PS:使用 --volumes-from参数所挂载数据卷的容器本身并不需要保持在运行状态

  > 容器之间共享持续更新的数据,最简单的方式是使用数据卷容器

  > 1.创建数据卷容器 dbdata,并在其中创建一个数据卷挂载到/dbdata

  - docker run -it -v /dbdata --name dbdata ubuntu
  - 在其他容器中使用--volumes-from来挂载dbdata容器中的数据卷
  - docker run it --volumes-from dbdata --name db1 ubuntu
  - docker run it --volumes-from dbdata --name db2 ubuntu
  - 此时容器db1和容器db2都懂 dbdata 容器挂载数据卷,三个容器任何一方在该目录下的写入,其他容器都可以看到

  - 删除了挂载的容器(包括dbdata,db1,db2)数据卷并不会自动删除.
  - 必须在删除最后一个还挂载着它的容器时显示的使用 docker rm -v 命令来指定同时删除关联的容器

#### III.利用数据卷容器迁移数据

  > 备份: 使用下面的命令来备份dbdata数据卷

  - docker run --volumess-from dbdata -v $(pwd):/backup --name worker ubuntu
  - tar cvf /backup/backup.tar /dbdata

  - 恢复: 恢复数据到一个容器,下面操作
  - docker run -v /dbdata --name dbdata2 ubuntu /bin/bash
  - docker run --volumes-from dbdata2 -v $(pwd):/backup busybox tar xvf /backup/backup.tar
