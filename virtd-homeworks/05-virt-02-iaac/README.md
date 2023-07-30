# Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

## Задача 1

- Опишите основные преимущества применения на практике IaaC-паттернов.
  Ответ: ускорение производства и вывода продукта на рынок; стабильность среды, устранение дрейфа конфигурации; более быстрая и эффективная разработка.
- Какой из принципов IaaC является основополагающим?
  Ответ: основополагающий принцип-идемпотентность, т.е св-во объекта или операции при повторном выполнении котороц мы получем результат идентичный предыдущему и всем последующим.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
  Ответ: ансибл прост в понимании, не требует установки агентов на целевые хосты, быстрый, расширяемый, использует декларативный и императивный подход, использует SSH инфраструктуру, написан на языке Python, что делает его нативным для Linux и MacOS.
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?
  Ответ: pull, на мой взгляд подобный процесс более безопасен, так как ни у одного внешнего клиента нет доступа к правам администратора кластера.


## Задача 3

Установите на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/),
- [Vagrant](https://github.com/netology-code/devops-materials),
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md),
- Ansible.

        anna@MSI:~$ vboxmanage --version
        6.1.38_Ubuntur153438

        root@MSI:/mnt/c/VirtualBoxHomeDir# vagrant --version
        Vagrant 2.3.7

        anna@MSI:~$ ./terraform --version
        Terraform v1.5.4
        on linux_amd64

        root@MSI:/mnt/c/VirtualBoxHomeDir# ansible --version
        ansible [core 2.15.2]

## Задача 4 

Воспроизведите практическую часть лекции самостоятельно.

- Создайте виртуальную машину.

![image](https://github.com/YoungHacker1912/devops-netology/assets/93939433/0758c0bc-41a7-4ca5-8e5a-d770bfe1245b)

![vagrant provision](https://github.com/YoungHacker1912/devops-netology/assets/93939433/2702c7ba-a1de-4c8f-98b1-5d5a7cb281d0)

- Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды

![docker ps](https://github.com/YoungHacker1912/devops-netology/assets/93939433/f9ce0f4a-8254-4acb-aa8d-21eae34ae4a9)
