# docker-memo

- [docker-memo](#docker-memo)
  - [sample](#sample)
  - [基礎コマンド](#基礎コマンド)
    - [イメージのリストを表示](#イメージのリストを表示)
    - [イメージ取得(pull)](#イメージ取得pull)
    - [イメージ取得(pull),tag指定)](#イメージ取得pulltag指定)
    - [同じイメージの確認](#同じイメージの確認)
    - [イメージ詳細](#イメージ詳細)
    - [イメージ詳細情報](#イメージ詳細情報)
    - [イメージの削除(イメージ名)](#イメージの削除イメージ名)
    - [イメージの削除(イメージID)](#イメージの削除イメージid)
    - [コマンドの確認](#コマンドの確認)
  - [コンテナ](#コンテナ)
    - [コンテナを作成(名前をつけるよ)](#コンテナを作成名前をつけるよ)
    - [コンテナの作成を確認(-a:全ての状態を表示)](#コンテナの作成を確認-a全ての状態を表示)
    - [コンテナを起動する](#コンテナを起動する)
      - [コンテナを起動し対話型で操作してみる](#コンテナを起動し対話型で操作してみる)
    - [コンテナを停止する](#コンテナを停止する)
    - [コンテナを削除する](#コンテナを削除する)
    - [runコマンド](#runコマンド)
    - [オプション](#オプション)
      - [バックグランドで実行(-d)](#バックグランドで実行-d)
      - [対話モード(-it)](#対話モード-it)
    - [実行中のコンテナに入る](#実行中のコンテナに入る)
    - [portを公開](#portを公開)
    - [バックグラウンドで実行](#バックグラウンドで実行)
    - [ログを監視](#ログを監視)
    - [対話モード(it)](#対話モードit)
    - [環境変数を設定](#環境変数を設定)
    - [ファイルの共有(コンテナとホスト)](#ファイルの共有コンテナとホスト)

## sample

> docker container run hello-world

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## 基礎コマンド

### イメージのリストを表示

> docker image ls

```
IMAGE                   ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest      05813aedc15f       25.9kB         9.52kB    U
my-fastapi-app:latest   329b1df79a03        225MB         54.5MB    U
```

### イメージ取得(pull)

> docker image pull alpine

```
Using default tag: latest
latest: Pulling from library/alpine
1074353eec0d: Pull complete
644afed44dca: Download complete
5c1f58ba4e0d: Download complete
Digest: sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
```

### イメージ取得(pull),tag指定)

> docker image pull alpine:3.18

```
3.18: Pulling from library/alpine
44cf07d57ee4: Pull complete
54d130656ede: Download complete
431d356fe850: Download complete
Digest: sha256:de0eb0b3f2a47ba1eb89389859a9bd88b28e82f5826b6969ad604979713c2d4f
Status: Downloaded newer image for alpine:3.18
docker.io/library/alpine:3.18
```

### 同じイメージの確認

> docker image ls alpine

```
IMAGE           ID             DISK USAGE   CONTENT SIZE   EXTRA
alpine:3.18     de0eb0b3f2a4       11.5MB          3.5MB
alpine:latest   865b95f46d98       13.1MB         3.95MB
```

### イメージ詳細

> docker image history alpine:latest

```
IMAGE          CREATED       CREATED BY                                       SIZE      COMMENT
865b95f46d98   4 weeks ago   CMD ["/bin/sh"]                                  0B        buildkit.dockerfile.v0
<missing>      4 weeks ago   ADD alpine-minirootfs-3.23.2-x86_64.tar.gz /…   9.11MB    buildkit.dockerfile.v0
```

### イメージ詳細情報

> docker image inspect alpine

````
[
    {
        "Id": "sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62",
        "RepoTags": [
            "alpine:latest"
        ],
        "RepoDigests": [
            "alpine@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62"
        ],
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2025-12-18T00:12:29.242464453Z",
        "Config": {
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh"
            ],
            "WorkingDir": "/"
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 3870955,
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:7bb20cf5ef67526cb843d264145241ce4dde09a337b5be1be42ba464de9a672d"
            ]
        },
        "Metadata": {
            "LastTagTime": "2026-01-18T02:21:15.869526423Z"
        },
        "Descriptor": {
            "mediaType": "application/vnd.oci.image.index.v1+json",
            "digest": "sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62",
            "size": 9218
        }
    }
]```
````

### イメージの削除(イメージ名)

> docker image rm helle-world

> docker image rm -f hello-world

```
Untagged: hello-world:latest
Deleted: sha256:05813aedc15fb7b4d732e1be879d3252c1c9c25d885824f6295cab4538cb85cd
```

### イメージの削除(イメージID)

> docker image rm 05813aedc15f

```
Untagged: hello-world:latest
Deleted: sha256:05813aedc15fb7b4d732e1be879d3252c1c9c25d885824f6295cab4538cb85cd
```

### コマンドの確認

> docker image --help

```
Usage:  docker image COMMAND

Manage images

Commands:
  build       Build an image from a Dockerfile
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Display detailed information on one or more images
  load        Load an image from a tar archive or STDIN
  ls          List images
  prune       Remove unused images
  pull        Download an image from a registry
  push        Upload an image to a registry
  rm          Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE

Run 'docker image COMMAND --help' for more information on a command.
```

## コンテナ

### コンテナを作成(名前をつけるよ)

> docker container create --name my-alpine alpine

```
0b4d21e2b229484b82781c86c42ce718881faaa9b5640d7fb8a629a591a4aaf3
```

### コンテナの作成を確認(-a:全ての状態を表示)

> docker container ls -a

```
CONTAINER ID   IMAGE     COMMAND     CREATED         STATUS    PORTS     NAMES
0b4d21e2b229   alpine    "/bin/sh"   2 minutes ago   Created             my-alpine
```

### コンテナを起動する

> docker contaier start my-alpine

```
my-alpine
```

> docker contaier ls -a

```
CONTAINER ID   IMAGE     COMMAND     CREATED          STATUS                      PORTS     NAMES
0b4d21e2b229   alpine    "/bin/sh"   18 minutes ago   Exited (0) 54 seconds ago             my-alpine
```

alpineイメージはデフォルトコマンドとして "/bin/sh" 起動して終了しています。
これを確認するには以下のコマンドを実行します。

> docker image inspect alpine --format '{{.Config.Cmd}}'

```
[/bin/sh]
```

#### コンテナを起動し対話型で操作してみる

> docker container run -it --name my-alpine3 alpine

コンテナ内でコマンドを操作できます。

```
/ #
```

STATUS が Up である事を確認。

```
CONTAINER ID   IMAGE     COMMAND     CREATED          STATUS                     PORTS     NAMES
c7f7bf9f99da   alpine    "/bin/sh"   2 minutes ago    Up 2 minutes                         my-alpine3
0a4d920bc00f   alpine    "ls /"      15 minutes ago   Exited (0) 3 minutes ago             alpine2
0b4d21e2b229   alpine    "/bin/sh"   52 minutes ago   Exited (0) 9 minutes ago             my-alpine
```

### コンテナを停止する

以下を起動します。(STATUSはUp)

> docker container run --name my-nginx nginx

```
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
500799c30424: Pull complete
eaf8753feae0: Pull complete
d989100b8a84: Pull complete
10b68cfefee1: Pull complete
57f0dd1befe2: Pull complete
700146c8ad64: Pull complete
e2dd2dbe6277: Download complete
785250c9bf9e: Download complete
Digest: sha256:c881927c4077710ac4b1da63b83aa163937fb47457950c267d92f7e4dedf4aec
Status: Downloaded newer image for nginx:latest
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/01/18 04:24:39 [notice] 1#1: using the "epoll" event method
2026/01/18 04:24:39 [notice] 1#1: nginx/1.29.4
2026/01/18 04:24:39 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19)
2026/01/18 04:24:39 [notice] 1#1: OS: Linux 6.6.87.2-microsoft-standard-WSL2
2026/01/18 04:24:39 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/01/18 04:24:39 [notice] 1#1: start worker processes
2026/01/18 04:24:39 [notice] 1#1: start worker process 30
2026/01/18 04:24:39 [notice] 1#1: start worker process 31
2026/01/18 04:24:39 [notice] 1#1: start worker process 32
2026/01/18 04:24:39 [notice] 1#1: start worker process 33
2026/01/18 04:24:39 [notice] 1#1: start worker process 34
2026/01/18 04:24:39 [notice] 1#1: start worker process 35
2026/01/18 04:24:39 [notice] 1#1: start worker process 36
2026/01/18 04:24:39 [notice] 1#1: start worker process 37
```

他のターミナルから停止します。(コンテナは削除されません、いつでも開始できます)

> docker container stop my-nginx

```
my-nginx
```

停止を確認します。

> docker container ls -a

```
CONTAINER ID   IMAGE     COMMAND                   CREATED             STATUS                      PORTS     NAMES
06c44f195b11   nginx     "/docker-entrypoint.…"   3 minutes ago       Exited (0) 48 seconds ago             my-nginx
c7f7bf9f99da   alpine    "/bin/sh"                 14 minutes ago      Exited (0) 9 minutes ago              my-alpine3
0a4d920bc00f   alpine    "ls /"                    28 minutes ago      Exited (0) 15 minutes ago             alpine2
0b4d21e2b229   alpine    "/bin/sh"                 About an hour ago   Exited (0) 22 minutes ago             my-alpine
```

### コンテナを削除する

> docker container rm my-alpine3

削除を確認します。

> docker container ls -a

```
CONTAINER ID   IMAGE     COMMAND                   CREATED             STATUS                      PORTS     NAMES
06c44f195b11   nginx     "/docker-entrypoint.…"   16 minutes ago      Exited (0) 13 minutes ago             my-nginx
0a4d920bc00f   alpine    "ls /"                    41 minutes ago      Exited (0) 28 minutes ago             alpine2
0b4d21e2b229   alpine    "/bin/sh"                 About an hour ago   Exited (0) 35 minutes ago             my-alpine
```

### runコマンド

runは以下の3つの処理を行います。

- docker image pull - イメージをダウンロード(ない場合)
- docker container create - コンテナを作成
- docker container start - コンテナを起動

### オプション

#### バックグランドで実行(-d)

-d をつけると バックグランドで実行されます。

> docker container run -d --name my-nginx nginx

#### 対話モード(-it)

-it をつけることで、コンテナに入って操作できます。デフォルトで "bin/bash"実行され、操作が可能となります。

> docker container run -it --name my-alpine2 alpine

### 実行中のコンテナに入る

バックグラウンドで起動します。

> docker container run -d --name my-nginx nginx

実行中のコンテナに入ります。(exec で入ってい exit してもコンテナは停止しません)

> docker container exec -it my-nginx /bin/bash

```
root@8a4b0abd3697:/#
```

停止し削除する。

> docker container stop my-nginx && docker container rm my-nginx

### portを公開

ホスト側のポート:コンテナ側のポートを指定。※複数のポートを指定可能

> docker container run -d --name my-nginx-with-port -p 8080:80 nginx

接続可能なIPを設定する場合。指定しない場合は 0.0.0.0 が設定される。

> docker container run -d --name my-nginx-with-port -p 127.0.0.1:8080:80 nginx

```
ad474da9bb138f404e5dcc0f0acfc7f9524a477f5969930a22c718576876b53a
```

状態を確認する。  
localhost:8080 から nginx に接続し確認する。

> docker container ls -a

```
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS         PORTS                                     NAMES
deb5944cba45   nginx     "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx-with-port
```

### バックグラウンドで実行

> docker cotainer run -d --name nginx-bg nginx

```
Status: Downloaded newer image for nginx:latest
```

> docker container ls -a

```
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS          PORTS     NAMES
1d54fa7bbfb0   nginx     "/docker-entrypoint.…"   18 seconds ago   Up 18 seconds   80/tcp    nginx-bg
```

ログを参照、監視する場合は(-f)

> docker container logs nginx-bg

```
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/01/18 12:59:45 [notice] 1#1: using the "epoll" event method
2026/01/18 12:59:45 [notice] 1#1: nginx/1.29.4
2026/01/18 12:59:45 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19)
2026/01/18 12:59:45 [notice] 1#1: OS: Linux 6.6.87.2-microsoft-standard-WSL2
2026/01/18 12:59:45 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/01/18 12:59:45 [notice] 1#1: start worker processes
2026/01/18 12:59:45 [notice] 1#1: start worker process 29
2026/01/18 12:59:45 [notice] 1#1: start worker process 30
2026/01/18 12:59:45 [notice] 1#1: start worker process 31
2026/01/18 12:59:45 [notice] 1#1: start worker process 32
2026/01/18 12:59:45 [notice] 1#1: start worker process 33
2026/01/18 12:59:45 [notice] 1#1: start worker process 34
2026/01/18 12:59:45 [notice] 1#1: start worker process 35
2026/01/18 12:59:45 [notice] 1#1: start worker process 36
```

### ログを監視

> docker container run -d --name nginx-logs -p 8080:80 nginx

```
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS          PORTS                                     NAMES
e5c94753bc52   nginx     "/docker-entrypoint.…"   56 seconds ago   Up 55 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   nginx-logs
```

ログを確認する。(-fでリアルタイム監視)

> docker container logs nginx-logs

ブラウザからlocalhost:8080にアクセスします。  
アクセスログが確認できます。

```
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/01/18 13:19:14 [notice] 1#1: using the "epoll" event method
2026/01/18 13:19:14 [notice] 1#1: nginx/1.29.4
2026/01/18 13:19:14 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19)
2026/01/18 13:19:14 [notice] 1#1: OS: Linux 6.6.87.2-microsoft-standard-WSL2
2026/01/18 13:19:14 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/01/18 13:19:14 [notice] 1#1: start worker processes
2026/01/18 13:19:14 [notice] 1#1: start worker process 29
2026/01/18 13:19:14 [notice] 1#1: start worker process 30
2026/01/18 13:19:14 [notice] 1#1: start worker process 31
2026/01/18 13:19:14 [notice] 1#1: start worker process 32
2026/01/18 13:19:14 [notice] 1#1: start worker process 33
2026/01/18 13:19:14 [notice] 1#1: start worker process 34
2026/01/18 13:19:14 [notice] 1#1: start worker process 35
2026/01/18 13:19:14 [notice] 1#1: start worker process 36
172.17.0.1 - - [18/Jan/2026:13:26:22 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36" "-"
172.17.0.1 - - [18/Jan/2026:13:27:02 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36" "-"
172.17.0.1 - - [18/Jan/2026:13:27:02 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36" "-"
2026/01/18 13:27:02 [error] 29#29: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
```

### 対話モード(it)

ubuntuコンテナに入る。  
動いてるコンテナに入る場合はexecを使用。

- run -it: 新しいコンテナを作ってい入る: exit(コンテナ停止)
- exec -it: 動いているコンテナに入る: exit(コンテナ継続)

> docker container run -it --name my-ubuntu ubuntu

```
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
a3629ac5b9f4: Pull complete
1baf05536e37: Download complete
Digest: sha256:7a398144c5a2fa7dbd9362e460779dc6659bd9b19df50f724250c62ca7812eb3
Status: Downloaded newer image for ubuntu:latest
root@c7005bd52b10:/#
--- コマンドを実行 ---
root@c7005bd52b10:/# cat /etc/os-release
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
root@c7005bd52b10:/#
```

### 環境変数を設定

コンテナに環境変数を渡せます。

> docker container run -it -e MY_NAME="Docker User" ubuntu

```
root@0f082b6b551a:/# echo $MY_NAME
Docker User
```

MySQL用に記述。

> docker container run -d --name my-mysql -e MYSQL_ROOT_PASSWORD=secret123 mysql

```
Unable to find image 'mysql:latest' locally
latest: Pulling from library/mysql
... インストールのログが表示されます
```

> docker container exec -it my-mysql mysql -u root -p

```
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
--- mysqlコマンドを実行 ---
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.007 sec)

mysql>
```

### ファイルの共有(コンテナとホスト)

ファイルを共有します。(今回はバインドマウント)

> docker container run -d --name my-nginx -p 8080:80 -v ${pwd}/my-html:/usr/share/nginx/html nginx

ブラウザから以下のURLでファイルの共有を確認。  
Windows側でファイルを更新した結果が反映されます。

> localhost:8080/test.html

次のコマンドで接続してコンテナからファイルを確認できます。

> docker container exec -it my-nginx bash
