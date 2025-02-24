# nginx-memo(linux)

## 基本コマンド

### イメージを取得（★debian）
$ docker pull nginx

### nginxを起動
$ docker container run --name nginx1 --publish 9000:80 nginx


### 別ターミナルから接続して試す
$ docker container exec --interactive --tty nginx1 bash

### バージョン
:/# nginx -v

### 状態をチェック
:/# service nginx status

### nginxを停止
:/# service nginx stop

### nginx 設定ファイルを読み込み
:/# service nginsx reload

### nginx を再起動
:/# service nginsx restart

### psコマンドがないので、下記でインストール
> apt update
> apt install -y procps

### アクセスログ
/var/log/nginx/access.log
/var/log/nginx/error.log


## 設定とか

### httpリクエスト
http://user:password@www.example.com:8080/path/to/file?a=1&b=2#f1

### 設定ファイル
場所: /etc/nginx/nginx.conf

### includeディレクティブ
指定したDIR以下の設定ファイルを読み込む。再起動が必要。

### 






