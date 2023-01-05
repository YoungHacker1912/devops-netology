### Задача 1

https://hub.docker.com/repository/docker/younghacker/devops-netology

### Задача 2

Высоконагруженное монолитное java веб-приложение (виртуальная машина, противоречит микросервисной архитектуре контейнеров);
Nodejs веб-приложение (контейнеры, легкое, не требует больших ресурсов);
Мобильное приложение c версиями для Android и iOS (контейнеры);
Шина данных на базе Apache Kafka (физическая машина, так как требуется много ресурсов, высокая производительность и низкие задержки);
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana (контейнеры, проще организовать кластер);
Мониторинг-стек на базе Prometheus и Grafana (контейнеры, легко разворачивать);
MongoDB, как основное хранилище данных для java-приложения (вм, так бд требует постоянного хранилища);
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry (контейнеры, отказоустойчивость, легко разворачивать).

### Задача 3

[root@5b8acdd60cbb data]# ls -lah

total 16K

drwxr-xr-x 2 root root 4.0K Jan  5 14:33 .

drwxr-xr-x 1 root root 4.0K Jan  5 14:08 ..

-rw-r--r-- 1 root root   28 Jan  5 14:32 test.txt

-rw-r--r-- 1 root root   29 Jan  5 14:33 test2.txt

[root@5b8acdd60cbb data]# cat test.txt 

This is the first test file

[root@5b8acdd60cbb data]# cat test2.txt

This is the second test file

Мне удалось создать оббщий volume между хостовой машиной и двумя контейнерами


