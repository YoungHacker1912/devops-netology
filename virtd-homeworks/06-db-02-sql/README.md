# Домашнее задание к занятию "2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```
version: "3.9"

services:
  db:
    image: postgres:12
    container_name: postgres
    hostname: postgres
    ports:
      - 5432:5432
    restart: unless-stopped
    volumes:
      - $HOME/docker/volumes/postgres/data:/var/lib/postgresql/data
      - $HOME/docker/volumes/postgres/bckp:/var/lib/postgresql/bckp
    environment:
      - POSTGRES_PASSWORD=BlaBla12345
    networks:
      - default

  adminer:
    image: dpage/pgadmin4:7.2
    restart: unless-stopped
    ports:
      - 8080:8080
    depends_on:
      - db

networks:
  default:
    ipam:
      driver: default
      config:
        - subnet: 172.16.0.0/16
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

```
postgres=# CREATE USER "test-admin-user";
CREATE ROLE

postgres=# CREATE DATABASE test_db;
CREATE DATABASE

postgres=# CREATE TABLE orders (id SERIAL PRIMARY KEY, наименование VARCHAR, цена INTEGER);
CREATE TABLE

postgres=# CREATE TABLE clients (id SERIAL PRIMARY KEY, фамилия VARCHAR, страна VARCHAR, id_заказа SERIAL NOT NULL, FOREIGN KEY (id_заказа) REFERENCES orders (id));
CREATE TABLE

postgres=# CREATE INDEX country_id ON clients (страна);
CREATE INDEX

postgres=# GRANT ALL ON orders, clients TO "test-admin-user";
GRANT

postgres=# CREATE USER "test-simple-user";
CREATE ROLE

postgres=# GRANT SELECT,INSERT,UPDATE,DELETE ON orders, clients to "test-simple-user";
GRANT
```

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)
```

- описание таблиц (describe)

```
postgres=# \l+
                                                                   List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |    
            Description                 
-----------+----------+----------+------------+------------+-----------------------+---------+------------+----
----------------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 8193 kB | pg_default | def
ault administrative connection database
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7833 kB | pg_default | unm
odifiable empty database
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7833 kB | pg_default | def
ault template for new databases
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7833 kB | pg_default | 
(4 rows)
```
  
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

```
SELECT table_name,grantee,privilege_type 
FROM information_schema.table_privileges
WHERE table_schema NOT IN ('information_schema','pg_catalog');
```
  
- список пользователей с правами над таблицами test_db

```
table_name |     grantee      | privilege_type 
------------+------------------+----------------
 orders     | postgres         | INSERT
 orders     | postgres         | SELECT
 orders     | postgres         | UPDATE
 orders     | postgres         | DELETE
 orders     | postgres         | TRUNCATE
 orders     | postgres         | REFERENCES
 orders     | postgres         | TRIGGER
 clients    | postgres         | INSERT
 clients    | postgres         | SELECT
 clients    | postgres         | UPDATE
 clients    | postgres         | DELETE
 clients    | postgres         | TRUNCATE
 clients    | postgres         | REFERENCES
 clients    | postgres         | TRIGGER
 orders     | test-admin-user  | INSERT
 orders     | test-admin-user  | SELECT
 orders     | test-admin-user  | UPDATE
 orders     | test-admin-user  | DELETE
 orders     | test-admin-user  | TRUNCATE
 orders     | test-admin-user  | REFERENCES
 orders     | test-admin-user  | TRIGGER
 clients    | test-admin-user  | INSERT
 clients    | test-admin-user  | SELECT
 clients    | test-admin-user  | UPDATE
 clients    | test-admin-user  | DELETE
 clients    | test-admin-user  | TRUNCATE
 clients    | test-admin-user  | REFERENCES
 clients    | test-admin-user  | TRIGGER
 orders     | test-simple-user | INSERT
 orders     | test-simple-user | SELECT
 orders     | test-simple-user | UPDATE
 orders     | test-simple-user | DELETE
 clients    | test-simple-user | INSERT
 clients    | test-simple-user | SELECT
 clients    | test-simple-user | UPDATE
 clients    | test-simple-user | DELETE
(36 rows)
```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```
postgres=# INSERT INTO orders (наименование,цена) VALUES
('Шоколад',10),
('Принтер',3000),
('Книга',500),
('Монитор',7000),
('Гитара',4000);
INSERT 0 5

postgres=# ALTER TABLE clients ALTER COLUMN id_заказа DROP NOT NULL;
ALTER TABLE

postgres=# INSERT INTO clients (фамилия,страна,id_заказа) VALUES
('Иванов Иван Иванович','USA',NULL),
('Петров Петр Петрович','Canada',NULL),
('Иоганн Себастьян Бах','Japan',NULL),
('Ронни Джеймс Дио','Russia',NULL),
('Ritchie Blackmore','Russia',NULL);
INSERT 0 5
```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
```
postgres=# UPDATE clients SET id_заказа = (SELECT id FROM orders WHERE наименование = 'Книга' LIMIT 1) WHERE фамилия = 'Иванов Иван Иванович';
UPDATE 1

postgres=# UPDATE clients SET id_заказа = (SELECT id FROM orders WHERE наименование = 'Монитор' LIMIT 1) WHERE фамилия = 'Петров Петр Петрович';
UPDATE 1

postgres=# UPDATE clients SET id_заказа = (SELECT id FROM orders WHERE наименование = 'Гитара' LIMIT 1) WHERE фамилия = 'Иоганн Себастьян Бах';
UPDATE 1

postgres=# select * from clients;
 id |       фамилия        | страна | id_заказа 
----+----------------------+--------+-----------
  5 | Ронни Джеймс Дио     | Russia |          
  6 | Ritchie Blackmore    | Russia |          
  2 | Иванов Иван Иванович | USA    |         3
  3 | Петров Петр Петрович | Canada |         4
  4 | Иоганн Себастьян Бах | Japan  |         5
(5 rows)

postgres=# select * from orders;
 id | наименование | цена 
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
  6 | Шоколад      |   10
  7 | Принтер      | 3000
  8 | Книга        |  500
  9 | Монитор      | 7000
 10 | Гитара       | 4000
(10 rows)
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).
Приведите получившийся результат и объясните что значат полученные значения.

```
postgres=# EXPLAIN select * from clients;
                        QUERY PLAN                         
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=810 width=72)
(1 row)
```

Seq Scan - последовательное чтение данных
Cost - оценка затратности операции
Rows - примерное количество строк, которые будут возвращены
Width - сколько байт в среднем в одной строке вывода такой операции

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

```
postgres@postgres:/$ pg_dump -U postgres -W -h 172.16.0.1 test_db > /var/lib/postgresql/data/test_db.dump
Password:
```

Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
root@anna-VirtualBox:/home/anna/DevOps/devops-netology/virtd-homeworks/06-db-02-sql# docker stop postgres
postgres
```
Поднимите новый пустой контейнер с PostgreSQL.

```
root@anna-VirtualBox:/home/anna/DevOps/devops-netology/virtd-homeworks/06-db-02-sql# docker-compose up -d
```
Восстановите БД test_db в новом контейнере.

```'
postgres=# CREATE DATABASE test_db WITH ENCODING='UTF-8';
postgres@postgres2:/$ pg_restore -U postgres -W -h 172.16.0.1 -d test_db /var/lib/postgresql/data/test_db.dump
```

