# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | сохраняется значение после = в формате текста |
| `d`  | 1+2  | подставляется именно значение переменной, но все еще в текстовом формате |
| `e`  | 3  | сначала подставляется значение переменных, затем значения в скобках преобразуется в числа, затем подставляется в качестве переменной   |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
while (( 1==1 ));
do
	curl https://localhost:4757
	if (( $? != 0 ));
	then
		date >> curl.log
	else
		break
	fi
done
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
IP=("192.168.0.1" "173.194.222.113" "87.250.250.242")
for i in ${IP[@]};do
for ((c=0; c<5; c++));do
	nc -z $i 80
	if [ $? == 0 ]; then
	result="$i is reachable by 80 port"
else
	result="$i is unreachable by 80 port"
	fi
	echo $result >> script2.log
done
done
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
IP=("192.168.0.1" "173.194.222.113" "87.250.250.242")
for i in ${IP[@]};do
	nc -z $i 80
	if [ $? != 0 ]; then
	result="$i is unreachable by 80 port"
	echo $result >> error.log
	break
	fi
done
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:
```bash
???
```
