# Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
docker-compose.yaml
```
```
Выполним подключение к серверу
```
root@53b504f821a4:/# psql -h localhost netology -U netologyuser
psql (12.11 (Debian 12.11-1.pgdg110+1))
Type "help" for help.

netology=#
```
Управляющие команды для:  

* вывода списка БД - \l
* подключения к БД - \c
* вывода списка таблиц - \d
* вывода описания содержимого таблиц - \dt
* выхода из psql - \q  

Создадим базу и восстановим резервную копию
```
netology=# create database test_database;
CREATE DATABASE
netology=# exit
root@53b504f821a4:/# psql -h localhost test_database -U netologyuser -l -f /usr/local/pgsql/data/test_dump.sql
                                         List of databases
     Name      |    Owner     | Encoding |  Collate   |   Ctype    |       Access privileges
---------------+--------------+----------+------------+------------+-------------------------------
 netology      | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres      | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/netologyuser              +
               |              |          |            |            | netologyuser=CTc/netologyuser
 template1     | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/netologyuser              +
               |              |          |            |            | netologyuser=CTc/netologyuser
 test_database | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 |
(5 rows)

root@53b504f821a4:/#
```

