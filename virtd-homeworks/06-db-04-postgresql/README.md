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
      - postgredb-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  postgredb-data:
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

```

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
