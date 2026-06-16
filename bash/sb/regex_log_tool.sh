#!/bin/bash

LOG_FILE="${1:-access.log}"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "[ERROR] Log file not found: $LOG_FILE" >&2
    exit 1
fi

echo "===== Regex Log Tool ====="
echo "File: $LOG_FILE"
echo

echo "--- 1. ERROR / WARN 行数 ---"
grep -E "ERROR|WARN" "$LOG_FILE" | wc -l

echo "--- 2. 404 行数 ---"
grep " 404 " "$LOG_FILE" | wc -l

echo "--- 3. IPランキング（上位10） ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head

echo "--- 4. 平均レスポンス時間 ---"
awk '{sum += $NF} END {print sum/NR}' "$LOG_FILE"

echo "--- 5. IP をマスクしたログ（先頭10行） ---"
sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/IP_REDACTED/g' "$LOG_FILE" | head
