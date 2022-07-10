# Задание 1
Создадим docker-compose file
```
version: "2"
services:
  mysql:
    image: mysql/mysql-server:latest
    environment:
      MYSQL_DATABASE: "netology"
      MYSQL_USER: "netologyuser"
      MYSQL_PASSWORD: "netologypass"
      MYSQL_ONETIME_PASSWORD: "netologypass"
    volumes:
      - ./mysql:/var/lib/mysql
    ports:
      - "3306:3306"
```
Восстановим базе из резервной копии
```
mysql -p
mysql> create database test_db;
exit
mysql -p test_db < test_dump.sql 
```
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.  
```
mysql> status
--------------
Server version:         8.0.29 MySQL Community Server - GPL
```
Подключитесь к восстановленной БД и получите список таблиц из этой БД.  
```
mysql> USE test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
Приведите в ответе количество записей с price > 300.  
```
mysql> select * from orders where price > 300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
```
# Задача 2
Создадим пользователя и выдадим права  
```
CREATE USER 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test-pass' PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3;
ALTER USER 'test'@'%' WITH MAX_QUERIES_PER_HOUR 100;
ALTER USER 'test'@'%' ATTRIBUTE '{"name": "James", "surname": "Pretty"}';
GRANT SELECT ON test_db.* to 'test'@'%';
```
Статистика по пользователю test
```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+------+----------------------------------------+
| USER | HOST | ATTRIBUTE                              |
+------+------+----------------------------------------+
| test | %    | {"name": "James", "surname": "Pretty"} |
+------+------+----------------------------------------+
1 row in set (0.00 sec)

mysql>
```

# Задача 3
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.  
```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00011825 | SET profiling = 1 |
+----------+------------+-------------------+
1 row in set, 1 warning (0.00 sec)
```
SHOW PROFILES отображает список самых последних инструкций, отправленных на сервер. Последний выполненный запрос был 'SET profiling = 1' длительность запроса 0.00011825  

Запросим engine для таблицы orders
```
mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)
```
Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:  
```
mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
В вывод команды SHOW PROFILES добавилось время выполнения новых запросов
```
mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                   |
+----------+------------+-----------------------------------------------------------------------------------------+
|        8 | 0.03650775 | ALTER TABLE orders ENGINE = MyISAM                                                      |
+----------+------------+-----------------------------------------------------------------------------------------+
```
```
mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                   |
+----------+------------+-----------------------------------------------------------------------------------------+
|        9 | 0.05074500 | ALTER TABLE orders ENGINE = InnoDB                                                      |
+----------+------------+-----------------------------------------------------------------------------------------+
9 rows in set, 1 warning (0.00 sec)
```

# Задача 4
Измените его согласно ТЗ (движок InnoDB):  
```
[mysqld]
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid

# Скорость IO важнее сохранности данных
innodb_flush_log_at_trx_commit = 0

#Нужна компрессия таблиц для экономии места на диске
# Можно использовать Barracuda - формат файла с сжатием
#innodb_file_format=Barracuda

#Размер буффера с незакомиченными транзакциями 1 Мб
innodb_log_buffer_size  = 1M

#Буффер кеширования 30% от ОЗУ
key_buffer_size = 11G

#Размер файла логов операций 100 Мб
max_binlog_size = 100M
```
