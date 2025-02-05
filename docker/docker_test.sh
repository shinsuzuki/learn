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






