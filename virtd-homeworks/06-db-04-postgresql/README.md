# Домашнее задание к занятию "4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

```
version: "3.9"

services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_DB: "postredb"
      POSTGRES_USER: "postgreuser"
      POSTGRES_PASSWORD: "postgrepass"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - ./postgredb-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
```

Подключитесь к БД PostgreSQL используя `psql`.

```
root@1d21f7a3cb3b:/# psql postredb --username postgreuser
psql (13.12 (Debian 13.12-1.pgdg120+1))
Type "help" for help.

postredb=# 
```

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

```
- вывода списка БД - \l
- подключения к БД - SELECT * FROM pg_stat_activity;
- вывода списка таблиц - \dS
- вывода описания содержимого таблиц - \dS+
- выхода из psql - exit
```

## Задача 2

Используя `psql` создайте БД `test_database`.

```
postredb=# CREATE DATABASE test_database;
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

```
psql -U postgreuser test_database < /var/lib/postgresql/data/test_dump.sql

```

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

```
test_database=# SELECT tablename, attname, avg_width FROM pg_stats WHERE tablename='orders' ORDER BY avg_width DESC LIMIT 1;
 tablename | attname | avg_width 
-----------+---------+-----------
 orders    | title   |        16
(1 row)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```
CREATE TABLE orders1 (CHECK (price < 499)) INHERITS (orders);
CREATE TABLE orders2 (CHECK (price > 499)) INHERITS (orders);

INSERT INTO orders1 SELECT * FROM orders WHERE price < 499;
DELETE FROM only orders WHERE price < 499;

INSERT INTO orders2 SELECT * FROM orders WHERE price >= 499;
DELETE FROM only orders WHERE price >= 499;
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
Можно было бы сделать разделение 

```
CREATE TABLE public.orders (
id integer NOT NULL,
title character varying(80) NOT NULL,
price integer DEFAULT 0
)
PARTITION BY RANGE (price);

CREATE TABLE orders_1 PARTITION OF orders_new FOR VALUES FROM ('0') TO ('499');
CREATE TABLE orders_2 PARTITION OF orders_new FOR VALUES FROM ('499') TO ('10000000');
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```
root@ca44c06b8576:/# pg_dump -U postgreuser test_database > /var/lib/postgresql/data/test_database.dump
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Добавить UNIQUE
```
title character varying(80) UNIQUE NOT NULL;
```

