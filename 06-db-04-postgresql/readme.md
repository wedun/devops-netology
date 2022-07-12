# Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
docker-compose.yaml
```
version: "2"
services:
  postgres:
    image: postgres:12
    environment:
      POSTGRES_DB: "netology"
      POSTGRES_USER: "netologyuser"
      POSTGRES_PASSWORD: "netologypass"
    volumes:
      - ./postgres_data:/var/lib/postgresql/data/
      - ./postgres_backup:/usr/local/pgsql/data/
    ports:
      - "5432:5432"
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
root@53b504f821a4:/# psql -h localhost test_database -U netologyuser -f /usr/local/pgsql/data/test_dump.sql
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
Выполним команду ANALYZE для просмотра статистики по таблице orders;
```
test_database=# ANALYZE VERBOSE orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=#
```
Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
```
test_database=# select avg_width from pg_stats where tablename= 'orders';
 avg_width
-----------
         4
         4
        16
(3 rows)

test_database=#
```

# Задача 3
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).  
```
begin;
    create table orders_new (
        id integer NOT NULL,
        title varchar(80) NOT NULL,
        price integer) partition by range(price);
    create table orders_1 partition of orders_new for values from (0) to (499);
    create table orders_2 partition of orders_new for values from (499) to (99999);
    insert into orders_new (id, title, price) select * from orders;
commit;
```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?  
Да, для этого необходимо было изначаль создать таблицу с типом partitioned table. 

# Задание 4
Используя утилиту pg_dump создайте бекап БД test_database.  
```
root@53b504f821a4:/# pg_dump -U netologyuser -d test_database > /usr/local/pgsql/data/test_database_dump.sql
root@53b504f821a4:/# ls -l /usr/local/pgsql/data/
total 8
-rw-r--r-- 1 root root 3569 Jul 12 15:50 test_database_dump.sql
-rw-r--r-- 1 root root 2084 Jul 11 17:01 test_dump.sql
root@53b504f821a4:/#
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?   
Для уникальности столбца title можно добавить индекс  
```
test_database=# CREATE INDEX ON orders ((lower(title)));
CREATE INDEX
test_database=#
```
