# Прохождение [курса Docker](https://stepik.org/course/123300) от Stepik

## Общая информация

> Контейнер живет, пока внутри него выполняется процесс.

У контейнера могут быть следующие состояния: 
(The Docker Remote API defines the following states:)

- ```created``` A container that has been created (e.g. with docker create) but not started
- ```restarting``` A container that is in the process of being restarted
- ```running``` A currently running container
- ```paused``` A container whose processes have been paused
- ```exited``` A container that ran and completed ("stopped" in other contexts, although a created container is technically also "stopped")
- ```dead``` A container that the daemon tried and failed to stop (usually due to a busy device or resource used by the container)

У каждого контейнера есть свой <u>IP-адрес</u>. Доступный внутри локальной сети. 

У каждого контейнера своя собственная <u>изолированная файловая система</u>. 

## Подготовка среды
Виртуальное окружение: 
```
sudo apt update
sudo apt install python3.10-venv
python3 -m venv .venv
```

Активация виртуального окружения: 
```
source .venv/bin/activate
```


Установка докера была выполнена заранее.

## Проверка

0. Try it out (из официальной документации)
```
docker run -d -p 8080:80 docker/welcome-to-docker
```


1. Запуск докер-кита: 
```
sudo docker pull carolynvs/whalesayd # обязательно использовать относительно свежий образ
docker run carolynvs/whalesayd cowsay Hi, darling!
```

Есть круче: 
```
docker pull docker/surprise
docker run -it --rm docker/surprise 
```

2. Работа с тегами

```
docker run alpine cat /etc/*rel*
```
Output:

> Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
c6a83fedfae6: Pull complete 
Digest: sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5
Status: Downloaded newer image for alpine:latest
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.20.2
PRETTY_NAME="Alpine Linux v3.20"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
cat: can't open '/etc/lsb-release': No such file or directory


```
docker run alpine:3.14 cat /etc/*rel*
```
Output:
>Unable to find image 'alpine:3.14' locally
3.14: Pulling from library/alpine
f7dab3ab2d6e: Pull complete 
Digest: sha256:0f2d5c38dd7a4f4f733e688e3a6733cb5ab1ac6e3cb4603a5dd564e5bfb80eed
Status: Downloaded newer image for alpine:3.14
cat: can't open '/etc/lsb-release': No such file or directory
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.14.10
PRETTY_NAME="Alpine Linux v3.14"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://bugs.alpinelinux.org/"
irina@irina-virtual-machine:~$ 

3. Запуск контейнера, без "захода" в него (остается host-консоль)

```
docker run -d alpine sleep 1000 
# docker run -d --name boop alpine:3.16 sleep 100;
```
Без флага -d не получится выполнить ни одну команду в консоли.