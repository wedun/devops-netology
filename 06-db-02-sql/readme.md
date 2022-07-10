# Задача 1
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

volumes:
  postgres_data:
  postgres_backup:
```

# Задача 2
## создайте пользователя test-admin-user и БД test_db
```
CREATE USER "test-admin-user" WITH ENCRYPTED PASSWORD 'qqq';
CREATE DATABASE test_db WITH ENCODING = 'UTF8';
GRANT ALL ON ALL TABLES IN SCHEMA public TO "test-admin-user";
CREATE USER "test-simple-user" WITH ENCRYPTED PASSWORD 'bbb';
grant SELECT,INSERT,UPDATE,DELETE on all tables in schema public to "test-simple-user";
```
```
CREATE TABLE IF NOT EXISTS orders
(
	id serial primary key,
	name varchar,
	price Integer	
);
```
```
CREATE TABLE IF NOT EXISTS clients
(
        id serial primary key,
        lastname varchar,
	country varchar,
        order_id Integer references orders(id)
);
```
```
create index country_index on clients (country);
```
Список баз данных:
```
test_db=# \l
                                         List of databases
   Name    |    Owner     | Encoding |  Collate   |   Ctype    |         Access privileges
-----------+--------------+----------+------------+------------+------------------------------------
 netology  | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/netologyuser                   +
           |              |          |            |            | netologyuser=CTc/netologyuser
 template1 | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/netologyuser                   +
           |              |          |            |            | netologyuser=CTc/netologyuser
 test_db   | netologyuser | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/netologyuser                  +
           |              |          |            |            | netologyuser=CTc/netologyuser     +
           |              |          |            |            | "test-admin-user"=CTc/netologyuser
(5 rows)
```
Описание таблиц:
```
test_db=# \d orders
                                 Table "public.orders"
 Column |       Type        | Collation | Nullable |              Default
--------+-------------------+-----------+----------+------------------------------------
 id     | integer           |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying |           |          |
 price  | integer           |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)
```
```
test_db=# \d clients
                                  Table "public.clients"
  Column  |       Type        | Collation | Nullable |               Default
----------+-------------------+-----------+----------+-------------------------------------
 id       | integer           |           | not null | nextval('clients_id_seq'::regclass)
 lastname | character varying |           |          |
 country  | character varying |           |          |
 order_id | integer           |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_index" btree (country)
Foreign-key constraints:
    "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)
```
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db  
```
SELECT grantee, privilege_type, table_name
FROM information_schema.role_table_grants 
WHERE table_name IN ('orders', 'clients') AND grantee IN ('test-admin-user', 'test-simple-user');
```
список пользователей с правами над таблицами test_db  
```
"test-admin-user"	"INSERT"	"orders"
"test-admin-user"	"SELECT"	"orders"
"test-admin-user"	"UPDATE"	"orders"
"test-admin-user"	"DELETE"	"orders"
"test-admin-user"	"TRUNCATE"	"orders"
"test-admin-user"	"REFERENCES"	"orders"
"test-admin-user"	"TRIGGER"	"orders"
"test-simple-user"	"INSERT"	"orders"
"test-simple-user"	"SELECT"	"orders"
"test-simple-user"	"UPDATE"	"orders"
"test-simple-user"	"DELETE"	"orders"
"test-admin-user"	"INSERT"	"clients"
"test-admin-user"	"SELECT"	"clients"
"test-admin-user"	"UPDATE"	"clients"
"test-admin-user"	"DELETE"	"clients"
"test-admin-user"	"TRUNCATE"	"clients"
"test-admin-user"	"REFERENCES"	"clients"
"test-admin-user"	"TRIGGER"	"clients"
"test-simple-user"	"INSERT"	"clients"
"test-simple-user"	"SELECT"	"clients"
"test-simple-user"	"UPDATE"	"clients"
"test-simple-user"	"DELETE"	"clients"
```

# Задача 3
```
INSERT INTO orders
(
	name,
	price
)
VALUES
('Шоколад', 10),
('Принтер',	3000),
('Книга', 500),
('Монитор', 7000),
('Гитара', 4000)
```
```
INSERT INTO clients
(
	lastname,
	country
)
VALUES
('Иванов Иван Иванович', 'USA'),
('Петров Петр Петрович', 'Canada'),
('Иоганн Себастьян Бах', 'Japan'),
('Ронни Джеймс Дио', 'Russia'),
('Ritchie Blackmore', 'Russia')
```
Результат
```
test_db=# select count (*) from orders;
 count
-------
     5
(1 row)


test_db=# select count (*) from clients;
 count
-------
     5
(1 row)
```

# Задача 4
Приведите SQL-запросы для выполнения данных операций.
```
UPDATE clients SET order_id=3 WHERE id=1;
UPDATE clients SET order_id=4 WHERE id=2;
UPDATE clients SET order_id=5 WHERE id=3;
```
Вывод
```
SELECT * FROM clients
WHERE order_id IS NOT NULL;
1	"Иванов Иван Иванович"	"USA"		3
2	"Петров Петр Петрович"	"Canada"	4
3	"Иоганн Себастьян Бах"	"Japan"		5
```
# Задача 5
## Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).
```
- Plan: 
    Node Type: "Seq Scan"
    Parallel Aware: false
    Relation Name: "clients"
    Alias: "clients"
    Startup Cost: 0.00
    Total Cost: 18.10
    Plan Rows: 806
    Plan Width: 72
    Filter: "(order_id IS NOT NULL)"
```
Описание:
EXPLAIN позволяет получить статистику выполнения запросов. Мы видим, что запрос выполнялся над таблицей clients.  
Startup Cost - Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных.  
Total Cost: - Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки.  
Plan Rows - Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.  
Plan Width - Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).  

# Задача 6
Создадим бекап:  
pg_dump -U netologyuser test_db > /usr/local/pgsql/data/test_db.dump
Остановим контейнер:
docker-compose down
Запустим новый инстанс postgresql с подключенный volume с резервными копиями и отключенный data volume
psql -U netologyuser -d test_db -f /usr/local/pgsql/data/test_db.dump
Статистика
laykomdn@rubius180:~/devops-netology/06-db-02-sql$ docker exec -it 06-db-02-sql_postgres2_1 bash
root@cde6f273cb95:/# psql -U netologyuser -d test_db
psql (12.11 (Debian 12.11-1.pgdg110+1))
Type "help" for help.

test_db=# \d
                 List of relations
 Schema |      Name      |   Type   |    Owner
--------+----------------+----------+--------------
 public | clients        | table    | netologyuser
 public | clients_id_seq | sequence | netologyuser
 public | orders         | table    | netologyuser
 public | orders_id_seq  | sequence | netologyuser
(4 rows)

test_db=#
