# k8s-mysql-cluster

[![Join the chat at https://gitter.im/k8s-mysql-cluster/community](https://badges.gitter.im/k8s-mysql-cluster/community.svg)](https://gitter.im/k8s-mysql-cluster/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

各大云厂商都推出了RDS服务器，主要特点提供Mysql集群，保证高可用性，额外提供备份功能，但对于初创公司来说，价格有些贵。而单机mysql虽然不能保证高可用，但是其本身也提供了准备复制(Master Slave Replication)、主复制(Group Replication)，甚至提供了Mysql Innodb Cluster，一个利用mysql-shell, mysql group replication和mysql-router搭建集群的方案，这些功能社区版都是提供的，因此，自建mysql集群是初创公司高性价比的方案之一。

## 关于本项目
本项目提供了一些脚本，可以在Kubernetes集群上快速搭建好mysql集群，利用备份+构建的方法加快了创建的过程，包括主Master Slave Cluster和Mysql Innodb Cluster，可以根据实际情况选择合适的集群，脚本主要包括
* create-mysql-account.sh 创建mysql账号，默认密码是'mysql_pass',可以自行修改
* mysql-master-slave.sh 创建Master Slave Cluster的脚本
* mysql-innodb-cluster.sh 创建Master Innodb Cluster

## 创建Master Slave Cluster

### 前置条件
* 需要包含若干节点的K8s集群，其中必须有一个Master节点和若干Slave节点，Master节点必须加上'mysql=master'标签，Slave节点必须加上'mysql-slave'标签
* mysql镜像，可以使用docker hub上的官方mysql镜像，或者使用percona-mysql镜像，percona-mysql提供了mysql商业版才有的一些功能
* percona-xtrabackup镜像，percona-xtraback是一个用于mysql备份的工具，版本必须与mysql版本对齐，否则备份过程中可能会出现问题
* k8s集成上创建data的命名空间，或者修改脚本中的namespace

### 创建过程
1. 首相创建mysql账号
```Shell
sh create-mysql-account.sh
```

2. 其次使用k8s命名进行部署
```Shell
sh create-master-slave.sh
```

## 创建Mysql Innodb Cluster

### 前置条件
* 需要包含若干节点的K8s集群，其中必须至少有一个Master节点和若干Slave节点，Master节点必须加上'mysql=master'标签，Slave节点必须加上'mysql-slave'标签
* mysql镜像，可以使用docker hub上的官方mysql镜像，或者使用percona-mysql镜像，percona-mysql提供了mysql商业版才有的一些功能
* percona-xtrabackup镜像，percona-xtraback是一个用于mysql备份的工具，版本必须与mysql版本对齐，否则备份过程中可能会出现问题
* percona-xtrabackup镜像中必须安装mysql-shell，用于创建集群
* k8s集成上创建data的命名空间，或者修改脚本中的namespace

### 创建过程
1. 首相创建mysql账号
```Shell
sh create-mysql-account.sh
```

2. 其次使用k8s命名进行部署
```
sh create-innodb-cluster.sh
```