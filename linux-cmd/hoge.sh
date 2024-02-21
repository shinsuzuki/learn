#!/bin/bash

# 一覧
ls -al

# ディレクトリを移動
$ cd tmp

# 現在のディレクトリを表示
$ pwd

# ディレクトリ作成
$ mkdir tmp
# ディレクトリをパスどおりに作成
$ mkdir -p a/b/c

# ディレクトリ削除
$ rm -r a

# ディレクトリを再帰的に削除
$ rm -rf a

# ファイルを作成
$ touch test.txt
$ echo aaa >test.txt

# ファイルを削除(-f 存在しないファイルを無視)
$ rm -f test.txt

# 経過を表示
$ rm -v test.txt

# ファイルをコピー
$ copy file1.txt file2.txt

# ファイルを移動
$ mv file1.txt tmp_dir

# ファイルをリネーム
$ mv file1.txt file2.txt

# ファイルを参照
$ cat file-list.txt

# more(enterで一行づつ進む、戻れない)
$ more file.txt

# ファイルの中身を確認
$ cat -n file.txt

# ファイルの中身を確認(バイナリーと判断される)
$ less file.txt
$ less -r file.txt

# ファイルの中身を確認するには cat から less -r にパイプで繋ぐと文字化けはしない
$ cat -n file.txt | less -r

# ファイルの先頭10行を見る
$ head -n 10 memo.txt

# ファイルの末尾10行を見る
$ tail -n 10 memo.txt

# 所有者を検索
$ whois google.co.jp

# ログイン名を表示
$ whoami

# DNSサーバに問い合わせを行いサーバから様々な情報収集
$ dig google.com

# サイトを取得(再帰的に取得)
$ wget -r https://www.nhk.or.jp

# 日付
$ date date "+%Y/%m/%d %H:%M:%S"

# 稼働状況
$ uptime

# システム情報を表示
$ uname -a

# CPU,Memory情報
$ cat /proc/cpuinfo
$ cat /proc/meminfo

# ディスクの空き容量
$ df -h

# ディスクの使用量（DIR単位）
$ du

# メモリ使用量
$ free -h

# コマンド本体およびマニュアルファイルとソースファイルのパスを表示
$ whereis

# 指定した名前で実行されるコマンドの実行ファイルをフルパスで表示
$ which

# 検索（標準入力を grep）
$ ps aux | grep usr

# 検索(フォルダを再帰的、ファイル名表示 grep)
$ grep -nr '^[0-9].*' --include='*.txt' ./

# 文字数カウント
echo abcd | wc -m
wc -m file1.txt

# uniq(ソート後uniq)
ps aux | awk '{ print $11 }' | grep "^[a-zA-Z]" | sort | uniq

# 連続番号
seq 10

# 連続番号(0埋め)
seq -w 10

# ファイル連結（行ごとに連結）
paste file1.txt file2.txt

# ファイル一覧
find .file -type f -name "*.txt"

# ファイル一覧(ファイル名のみ)
find .file -type f -name "*.txt" | awk -/F '{ print $NF }'

# 文字列置換(tr)
echo abcdefg | tr a-z A-Z
echo abcdefg | tr -d bc

# 文字列置換(sed)
echo abcdefg | sed s/abc/xyz/
