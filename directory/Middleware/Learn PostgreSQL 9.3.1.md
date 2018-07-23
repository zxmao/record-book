## docker 安装

  docker run --name start-postgres -e POSTGRES_PASSWORD=${PASSWORD} -d postgres

## 常用命令
  
  docker run -it --rm --link some-postgres:postgres postgres psql -h postgres -U postgres [连接数据库]
