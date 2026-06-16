#!/bin/bash

hello() {
  echo "hello world"
}

hello


hello2() {
  echo "hello world p:$1"
}

hello2 "kine"

hello3() {
  return 1 # 関数を抜ける
}

hello3
echo $?


check_file() {
    if [[ ! -f "$1" ]]; then
        #echo "[ERROR] File not found: $1" >&2
        echo "[ERROR] File not found: $1"
        return 1
    fi
    return 0
}

# returnの値をチェック、関数の結果は変数に入らないので注意
# Bashでは、直前に実行されたコマンドの return 値が自動的に $? という特殊な変数に格納されます。
# if 関数; then や $? で受け取ります
#
# また、関数から文字列を返すときはreturnでは返さず、echoで返す
if check_file all.log; then
    echo "all.log found"
else
    echo "all.log not found"
fi

count_lines() {
  wc -l < "$1"
}

count=$(count_lines test.log)
echo "$count"


