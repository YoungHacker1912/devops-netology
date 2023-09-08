# Домашнее задание к занятию "3. MySQL"

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

```
version: '3.1'

services:
  mysql_db:
    image: mysql:8
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: mysql-database
      MYSQL_USER: anna
      MYSQL_PASSWORD: secret2
    volumes:
      - ./dbdata:/var/lib/mysql/
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

```
bash-4.4# mysql -u root -p
mysql> CREATE DATABASE test_db DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
bash-4.4# mysql -u root -p test_db < /var/lib/mysql/test_dump.sql
```

Используя команду `\h` получите список управляющих команд.

```
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'
```

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

```
mysql> \s
--------------
mysql  Ver 8.1.0 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		16
Current database:	test_db
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.1.0 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb3
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			30 min 35 sec

Threads: 2  Questions: 48  Slow queries: 0  Opens: 144  Flush tables: 3  Open tables: 63  Queries per second avg: 0.026
--------------
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

```
mysql> use test_db;
mysql> SHOW TABLES FROM test_db;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
```

**Приведите в ответе** количество записей с `price` > 300.

```
mysql> SELECT COUNT(*) FROM test_db.orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
Ответ: 1

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

```
CREATE USER 'test'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'test-pass'
WITH MAX_CONNECTIONS_PER_HOUR 100
PASSWORD EXPIRE INTERVAL 180 DAY
FAILED_LOGIN_ATTEMPTS 3
ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
```

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

```
GRANT SELECT ON `test_db`.* TO 'test'@'localhost';
FLUSH PRIVILEGES;
```
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

```
mysql> set profiling=1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> select count(*) from orders;
+----------+
| count(*) |
+----------+
|        5 |
+----------+
1 row in set (0.01 sec)

mysql> SHOW PROFILES;
+----------+------------+------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                |
+----------+------------+------------------------------------------------------------------------------------------------------+
|        1 | 0.00636475 | SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = DATABASE() |
|        2 | 0.00051150 | select count(*) from orders                                                                   
                                                                      |
+----------+------------+------------------------------------------------------------------------------------------------------+

10 rows in set, 1 warning (0.00 sec)
```
Все выполненные запросы за сессию с временем выполнения.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

```
mysql> SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = DATABASE();
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| test_db      | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.01 sec)
```

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.07 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.12 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+---------+------------+------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                |
+----------+------------+------------------------------------------------------------------------------------------------------+                                                                                |
|       1 | 0.07411425 | ALTER TABLE orders ENGINE = MyISAM                                                                   |
|       2 | 0.11438225 | ALTER TABLE orders ENGINE = InnoDB                                                                   |
+----------+------------+------------------------------------------------------------------------------------------------------+

14 rows in set, 1 warning (0.00 sec)
```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

```
root@anna-VirtualBox:/home/anna/DevOps/devops-netology/virtd-homeworks/06-db-03-mysql# docker cp ./test_data/my.cnf 06-db-03-mysql-mysql_db-1:/etc/my.cnf
root@anna-VirtualBox:/home/anna/DevOps/devops-netology/virtd-homeworks/06-db-03-mysql# docker exec -it dfc4431d0de3 /bin/bash

bash-4.4# cat /etc/my.cnf
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid

#Set IO Speed
# 0 - скорость
# 1 - сохранность
# 2 - универсальный параметр
innodb_flush_log_at_trx_commit = 0

#Set compression
# Barracuda - формат файла с сжатием
innodb_file_format=Barracuda

#Set buffer
innodb_log_buffer_size  = 1M

#Set Cache size
key_buffer_size = 307М

#Set log size
max_binlog_size = 100M

[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/
```
