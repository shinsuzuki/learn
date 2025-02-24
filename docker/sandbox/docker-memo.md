[:contents]
# cheat sheet

### バージョン

```ps1
ps> docker version
 Version:           27.5.1
 API version:       1.47
 Go version:        go1.22.11
 Git commit:        9f9e405
 Built:             Wed Jan 22 13:41:44 2025
 OS/Arch:           windows/amd64
 Context:           desktop-linux

Server: Docker Desktop 4.38.0 (181591)
 Engine:
  Version:          27.5.1
  API version:      1.47 (minimum version 1.24)
  Go version:       go1.22.11
  Git commit:       4c9b3b0
  Built:            Wed Jan 22 13:41:17 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.25
  GitCommit:        bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc:
  Version:          1.1.12
  GitCommit:        v1.1.12-0-g51d5e946
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```

## コンテナ

### コンテナを実行
```ps1
# Nginxコンテナをイメージから名前付きのコンテナを作成しポートを公開し、
# バックエンドで起動、終了後はコンテナを削除
ps> docker container run --name my_eninx --rm --detach --publish 8080:80 nginx 
```

```ps1
# 起動しているコンテナのポートを確認 
ps> docker container ls
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS          PORTS                  NAMES
2cb4110de14f   nginx     "/docker-entrypoint.…"   12 seconds ago   Up 11 seconds   0.0.0.0:8080->80/tcp   my_eninx
```

```ps1
# ubuntuコンテナを対話形式で起動
ps> docker container run -it ubuntu bash
```

### コンテナ一覧
```ps1
# コンテナの一覧の確認
ps> docker container ls
CONTAINER ID   IMAGE     COMMAND   CREATED         STATUS         PORTS     NAMES
1954ac2fe166   ubuntu    "bash"    5 minutes ago   Up 5 minutes             quirky_swirles
```

```ps1
# コンテナの全一覧の確認（起動中以外を含む）
ps> docker container ls -alll
```

### コンテナを停止
```ps1
# コンテナを停止
ps> docker container stop <container-id, container-name>
```


### コンテナを開始
```ps1
# コンテナを開始（作成済みのコンテナを起動）
ps> docker container start <container-id, container-name>
```

### コンテナを削除
```ps1
# コンテナを削除
ps> docker container rm <container-id, container-name>
```

```ps1
# コンテナを強制的に削除（停止と削除）
ps> docker container rm --force <container-id, container-name>
```

### コンテナ起動時にコマンドを実行
```ps1
# コマンドを実行(1)
ps> docker container run baash echo 'hello world!'
```

```ps11
# コマンドを実行(2)
ps> vdocker container run bash head -n 4 /etc/os-release
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.21.3
PRETTY_NAME="Alpine Linux v3.21"
```

### コンテナの環境変数を設定
```ps1
# 環境変数を設定
ps> docker container run --name db --rm --detach \
 --env MYSQL_ROOT_PASSWORD=secret \
 --env MYSQL_USER=app \
 --env MYSQL_PASSWORD=pass1234\
 --env MYSQL_DATABASE=sample\
 --publish 3306:3306 \
 mysql
```

### コンテナのログ出力
```ps1
# ログを出力を確認
ps> docker container logs <container-id,container-name>
```

```ps1
# ログを出力を確認（表示し続ける）
ps> docker container logs --follow <container-id,container-name>
```

### 起動中のコンテナに命令
```ps1
# コンテナに命令(1)
ps> docker container exec my_nginx head -n 4 /etc/os-release
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
```
```ps1
# コンテナに命令(2)
ps > dokcer contaier exec -it my_nginx bash 
root@06d4547fa17f:/#
```

## イメージ

### イメージ覧
```ps1
# イメージ覧
ps > docker image ls
```

### イメージを取得
```ps1
# イメージを取得
ps > docker image pull bash:3.1.23
```

### イメージの詳細
```ps1
# イメージの詳細
ps > docker image inspect bash:3.1.23
```

### コンテナからイメージを作る
```ps1
# コンテナからイメージを作成(viをコンテナに追加済み、それからイメージを作成)
ps > docker container commit my-ubuntu my-vi-ubuntu:commit
```

## Dockerfile

### イメージビルド
```ps1
# イメージを作成(Dockerfileの存在する場所を指定)
ps > docker image build -t <image-name> <target-dir>
```


### Dockerfile サンプル(FROM, RUN)
```ps1
# Dockerfile サンプル
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y vim
```

### Dockerfile サンプル(COPY)
```ps1
# コンテナのビルド時に、ファイルをホストのカレントからイメージの/etc/へコピー
FROM bash
COPY ./sample.txt /etc
```

### Dockerfile サンプル(CMD)
```ps1
# コンテナの起動時に実行するコマンド
FROM bash
CMD ["echo", "hello world!"]
```


## ボリューム

### ボリュームを作成
```ps1
# ボリュームを作成
ps> docker volume create --name my-volume
my-volume
```

### ボリュームを削除
```ps1
# ボリュームを削除
ps> docker volume rm my-volume
```

### ボリュームをマウント
```ps1
# 起動時にボリュームをマウント
# <mount>
# type: ボリュームをマウントする場合はvolume
# source:マウント元（作成したボリュームを指定）
# destination:マウント先（任意のパスを指定）
ps> docker container run \
 --name bash1 \
 --mount type=volume,source=my-volume,destination=/my-work \
 -it \
 bash
```

### バインドマウント（ホストマシンのディレクトリをマウント）

#### 読み込み、書き込み可能
```ps1
ps> docker run -it --rm
 --name bash1 \
 --mount "type=bind,source=$($pwd)/share-dir,destination=/my-work" \
 bash:latest 
 bash
```

#### 読み込み専用のバインドマウント(readonly)
```ps1
ps> docker run -it --rm
 --name bash1 \
 --mount "type=bind,source=$($pwd)/share-dir,destination=/my-work,readonly" \
 bash:latest 
 bash
```

[note] mountの書き方に注意  
https://forums.docker.com/t/error-in-poweshell-on-docker-run-it-mount-mount-type-bind-src-pwd/136051


## ネットワーク
todo 使うときにやる

### ネットワークの作成
```ps1
ps> docoker network create <contaneir-name>
```

### ネットワークの削除
```ps1
ps> docoker network rm <container-id, container-name>
```

### ネットワークの一覧
```ps1
ps> docoker network ls
```

## コピー（コンテナとホスト間でファイルのコピー）

### コンテナからホストへコピー
```ps1
#ps> docker cp <container-id>:<src-dir,file> <dist-dir,file>
ps > docker cp bash1:/etc/profile . 
Successfully copied 2.56kB to C:\Users\shins\mydev\learn\docker\sandbox\hoge\.
```

### ホストからコンテナへコピー
```ps1
# ps> docker cp <src-dir,file> <container-id>:<dist-dir,file> 
ps> docker cp ./sample.txt bash1:/etc/sample.txt
Successfully copied 2.05kB to bash1:/etc/sample.txt
```


## docker-compose

Docker Composeコマンドはcompose.yamlを配置した階層で実行します。

### コンテナの作成と実行

```ps1
# コンテナの作成と実行
ps> docker compose up -d
```

### コンテナの停止

```ps1
# コンテナの停止
ps> docker compose stop
```

### 作成済みのコンテナを実行

```ps1
# 作成済みのコンテナを実行
ps> docker compose start
```

### コンテナを削除

#### rm（停止状態を削除、紐づくネットワークは削除しない）
```ps1
# コンテナを削除(停止状態を削除、紐づくネットワークは削除しない)
ps> docker compose rm
```

#### rm -s（停止と削除）
```ps1
# コンテナを削除(停止と削除)
ps> docker compose rm -s
```

#### down（コンテナとネットワークを削除）
```ps1
# コンテナを削除(コンテナとネットワークを削除)
ps> docker compose down
```

#### down（コンテナとネットワーク、イメージを削除）
```ps1
# コンテナを削除(コンテナとネットワークイメージを削除)
ps> docker compose down --rmi all
```


note:  オプションでボリュームも併せて削除可能


### プロジェクトの一覧
```ps1
# プロジェクトの一覧
ps> docker compose ls 
NAME                STATUS              CONFIG FILES
001apache           running(1)          C:\Users\shins\mydev\learn\docker\sandbox\docker-compose\001.apache\compose.yaml
```

### コピー（コンテナとホスト間でファイルのコピー）

#### コンテナからホストへコピー
```ps1
# コンテナからホストへコピー
ps> docker compose cp <container-id>:<src-dir,file> <dist-dir,file>
```

#### ホストからコンテナへコピー
```ps1
# ホストからコンテナへコピー
ps> docker compose cp <src-dir,file> <container-id>:<dist-dir,file> 
```

### コンテナ内でコマンド
#### コンテナ内でコマンドを実行
```ps1
ps > docker compose exec db mariadb --version
mariadb  Ver 15.1 Distrib 10.7.8-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2
```


#### コンテナ内でシェルを立ち上げる
```ps1
ps > docker compose exec db bash
root@ac4b567eb8f2:/#
```



