#!/bin/bash

LOG_DIR="./logs"

if [[ ! -d "$LOG_DIR" ]]; then
    echo "[ERROR] Log directory not found: $LOG_DIR" >&2
    exit 1
fi

echo "===== Log Loop Tool ====="
echo "Target directory: $LOG_DIR"
echo

# 1. 各ログファイルの行数を表示
echo "--- 各ログファイルの行数 ---"
for f in "$LOG_DIR"/*.log; do
    echo "$(basename "$f"): $(wc -l < "$f") lines"
done

# 2. 全ログから ERROR 行を抽出
echo
echo "--- ERROR 行の抽出 ---"
for f in "$LOG_DIR"/*.log; do
    echo "[File: $(basename "$f")]"
    grep "ERROR" "$f" | head
    echo
done

# 3. 全ログを1行ずつ読み、404 をカウント
echo "--- 全ログの404件数 ---"
count=0
for f in "$LOG_DIR"/*.log; do
    # while read line; do
    #     if [[ $line == *" 404 "* ]]; then
    #         count=$((count + 1))
    #     fi
    # done < "$f"

    # cat "$f" | while read line; do
    #     if [[ $line == *" 404 "* ]]; then
    #         count=$((count + 1))
    #     fi
    # done

    # cat で中身を流し、grep で「 404 」の行だけを絞り込み、wc -l で一気に行数を数える
    file_count=$(cat "$f" | grep -c " 404 ")
    # 全ファイルの合計値に加算
    count=$((count + file_count))
done

echo "404 count: $count"
