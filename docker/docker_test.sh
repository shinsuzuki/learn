# バージョン取得
$ docker version

# コンテナを実行
$ docker container run hello-world

# コンテナの一覧
$ docker container ls

# 全てのコンテナの一覧（終了済みも）
$ docker container ls -all

# コンテナのコマンドを指定して実行
$ docker container run -it ubuntu bash

# コンテナを停止
$ docker container stop fb34d1fe6922

# コンテナを削除
$ docker container rm e52dfe29bbdc2

# コンテナの起動時に任意の処理を実行
$ docker container run ubuntu whoami

# コンテナの起動時に任意の処理を実行
$ docker container run ubuntu head -n 4 /etc/os-release

# コンテナに名前を付ける
$ docker run --name hello

# コンテナ停止時に自動でコンテナを削除
$ docker run --name hello --rm hello-world

# コンテナ起動時にコマンドを実行する
$ docker container run ruby ruby -e'print 99'

# コンテナを対話操作する
$ docker container run --rm --interactive --tty python python3

# コンテナのポートを公開する
$ docker container run --rm --publish 8080:80 nginx

# MySQLサーバーを起動(環境変数に条件を指定、バックエンドで実行)
$ docker container run --name db --rm --detach \
 --env MYSQL_ROOT_PASSWORD=secret \
 --env MYSQL_USER=app \
 --env MYSQL_PASSWORD=pass1234\
 --env MYSQL_DATABASE=sample\
 --publish 3306:3306 \
 mysql
# MySQLコンテナを停止
$ docker container stp db

# コンテナの出力を確認する
$ docker cotainer logs db
# コンテナの出力を確認する(表示し続ける)
$ docker cotainer logs --follow db

# PostgreSQLを起動
$ docker container run --name db --detach --env POSTGRES_PASSWORD=secret --publish 5432:5432 postgres

# 起動中のコンテナでbashを実行
$ docker container exec --interactive --tty db bash

# 起動中のコンテナにroot以外でログイン
# ※初期パスワードが設定されていないため、rootでログイン後にrootのパスワードを'passwd'で設定する
# $docker exec -it [コンテナ名] --user root bash
$ docker exec -it [コンテナ名] --user [ユーザー名または UID] bash


# イメージを取得
$ docker image pull ubuntu:leatest
$ docker image pull ubuntu:23.10

# イメージの詳細
$ docker image inspect ruby:3.2.2

#  コンテナ起動時にイメージのタグを指定する
$ docker container run \
 --name db1 \
 --rm \
 --detach \
 --env MYSQL_ROOT_PASSWORD=secret \
 --publish 3306:3306
 mysql:8.0.35

# イメージに名前を付ける
$ docker build -t aspnetapp_image .

 # コンテナにviをインストールする
 $ docker container run --name myubuntu --interactive --tty ubuntu:22.04 bash
[user]:/# apt-get update # updateしないとインストールできない
[user]:/# api install vim

# コンテナイメージを作成(TAG:[commit])
$ docker container commit myubuntu vi-ubuntu:commmit

# コンテナからtarを作る
$ docker container export myubuntu --output export.tar
# tarからイメージを作成
$ docker image import export.tar vi-ubuntu:import

# イメージからtarを作成（バックアップやマシンの移動等、イメージを移動することを目的としたもの）
$ docker image save ubuntu:22.04 --output save.tar
# tarからイメージを作成(ubuntu:22.04のイメージが削除されていること)
$ docker image load save.tar


# ボリュームを作成
$ docker volume create --name my-volume

# ボリュームをマウント
$ docker container run \
 --name ubuntu1 --rm \
 --interactive --tty \
 --mount type=volume,source=my-volume,destination=/my-work \
 ubuntu:22.04

# ボリュームを削除
$ docker volume rm my-volume


# バインドマウント(ホストマシンのディレクトリをマウント)
$ docker container run \
 --name ruby \
 --rm --interactive --tty \
 --mount type=bind,source="$(pwd)",destination=/my-work ruby:3.2.2 bash


# ネットワークの作成
$ docker network create my-network
# ネットワーク一覧
$ docker network ls


