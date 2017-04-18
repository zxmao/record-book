 ## CentOS 7关闭图形桌面开启文本界面
 
### 1，第一种方法
    
    按照 /etc/inittab 内部说明做如下改动

- mv /etc/systemd/system/default.target /etc/systemd/system/default.target.bak         (改名备份)
- ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target      (重新软连接文本界面为启动默认值界面)
- systemctl reboot                                                                                                               (重启) 

### 恢复图形界面
- rm -rf  /etc/systemd/system/default.target                                                                      (移除当前配置链接)
- mv  /etc/systemd/system/default.target.bak /etc/systemd/system/default.target       (恢复备份配置链接)
- systemctl reboot                                                                                                               (重启)


### 2,第二种方法,
  
  手动敲那么多不累么？仅2条命令

#### 1，命令模式

- systemctl set-default multi-user.target

#### 2,图形模式

- systemctl set-default graphical.target 
