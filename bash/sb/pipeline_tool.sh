#!/bin/bash

LOG_FILE="access.log"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "[ERROR] Log file not found: $LOG_FILE" >&2
    exit 1
fi

echo "===== Pipeline Log Analyzer ====="
echo "File: $LOG_FILE"
echo

echo "--- 1. 404件数 ---"
grep " 404 " "$LOG_FILE" | wc -l

echo "--- 2. ユニークIPランキング ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head

echo "--- 3. 最も遅いレスポンス時間（上位10件） ---"
awk '{print $NF}' "$LOG_FILE" | sort -nr | head

echo "--- 4. 今日のアクセス件数 ---"
grep "$(date +%d/%b/%Y)" "$LOG_FILE" | wc -l
