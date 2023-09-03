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

postgres=# CREATE TABLE clients (id SERIAL PRIMARY KEY, фамилия VARCHAR, страна VARCHAR, заказ SERIAL, FOREIGN KEY (заказ) REFERENCES orders (id));
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

![image](https://github.com/YoungHacker1912/devops-netology/assets/93939433/74e22ed9-01e5-4ac8-988a-9993155a8aa1)

  
- описание таблиц (describe)

![image](https://github.com/YoungHacker1912/devops-netology/assets/93939433/2a8190ac-9979-4dd6-a5a5-7fe4b0c5e51e)

  
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

![image](https://github.com/YoungHacker1912/devops-netology/assets/93939433/d061b520-61a2-440d-9198-85b383020f6a)


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
 
Подсказк - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
