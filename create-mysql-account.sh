MYSQL_ROOT_PASSWORD='mysql_pass'
MYSQL_ADMIN_PASSWORD='mysql_pass'
MYSQL_BACKUP_PASSWORD='mysql_pass'
MYSQL_BOOTSTRAP_PASSWORD='mysql_pass'
MYSQL_REPLICATOR_PASSWORD='mysql_pass'

MYSQL_SERVER_ADDRESS='127.0.0.1'

# create accounts
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "create user admin@'%' identified by $MYSQL_ADMIN_PASSWORD"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "create user backuper@'127.0.0.1' identified by $MYSQL_BACKUP_PASSWORD"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "create user bootstrap@'%' identified by $MYSQL_BOOTSTRAP_PASSWORD"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "create user replicator@'%' identified by $MYSQL_REPLICATOR_PASSWORD"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "create user readiness@'127.0.0.1' identified by readiness"

# grant group replication privileges for amdin
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT, RELOAD, SHUTDOWN, PROCESS, FILE, SUPER, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE USER ON *.* TO `admin`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT BACKUP_ADMIN,CLONE_ADMIN,PERSIST_RO_VARIABLES_ADMIN,SYSTEM_VARIABLES_ADMIN ON *.* TO `admin`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT INSERT, UPDATE, DELETE ON `mysql`.* TO `admin`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `mysql_innodb_cluster_metadata`.* TO `admin`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `mysql_innodb_cluster_metadata_bkp`.* TO `admin`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `mysql_innodb_cluster_metadata_previous`.* TO `admin`@`%` WITH GRANT OPTION"

# grant privileges for backup
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT RELOAD, PROCESS, LOCK TABLES, REPLICATION CLIENT ON *.* TO `backuper`@`127.0.0.1`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT BACKUP_ADMIN ON *.* TO `backuper`@`127.0.0.1`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT ON `performance_schema`.`log_status` TO `backuper`@`127.0.0.1`"

# grant privileges for bootstrap
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT CREATE USER ON *.* TO `bootstraper`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, EXECUTE ON `mysql_innodb_cluster_metadata`.* TO `bootstraper`@`%` WITH GRANT OPTION"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT REFERENCES ON `mysql_innodb_cluster_metadata_bkp`.* TO `bootstraper`@`%`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT REFERENCES ON `mysql_innodb_cluster_metadata_previous`.* TO `bootstraper`@`%`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT ON `mysql`.`user` TO `bootstraper`@`%`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT ON `performance_schema`.`global_variables` TO `bootstraper`@`%`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT ON `performance_schema`.`replication_group_member_stats` TO `bootstraper`@`%`"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT SELECT ON `performance_schema`.`replication_group_members` TO `bootstraper`@`%`"

# grant privileges for replicator
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h $MYSQL_SERVER_ADDRESS -e "GRANT REPLICATION SLAVE ON *.* TO `replicator`@`%`"