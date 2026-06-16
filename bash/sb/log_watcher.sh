#!/bin/bash

# ====== 設定 ======
LOG_FILE="${1:-/var/log/nginx/access.log}"

# ====== 色付き出力 ======
info()  { echo -e "\e[32m[INFO]\e[0m $1"; }
warn()  { echo -e "\e[33m[WARN]\e[0m $1"; }
error() { echo -e "\e[31m[ERROR]\e[0m $1" >&2; }

# ====== チェック関数 ======
check_file() {
    if [[ ! -f "$1" ]]; then
        error "Log file not found: $1"
        exit 1
    fi
}

# ====== 集計関数 ======
count_status() {
    local code=$1
    grep " $code " "$LOG_FILE" | wc -l
}

top_ips() {
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head
}

avg_response() {
    awk '{sum += $NF} END {if (NR>0) print sum/NR; else print 0}' "$LOG_FILE"
}

latest_errors() {
    grep -E "ERROR|WARN|CRITICAL" "$LOG_FILE" | tail -n 10
}

# ====== メイン処理 ======
info "Log Watcher Started"
info "Target: $LOG_FILE"
echo

check_file "$LOG_FILE"

echo "--- 行数 ---"
wc -l < "$LOG_FILE"
echo

echo "--- 404件数 ---"
count_status 404
echo

echo "--- 500件数 ---"
count_status 500
echo

echo "--- IPランキング（上位10） ---"
top_ips
echo

echo "--- 平均レスポンス時間 ---"
avg_response
echo

echo "--- 最新のエラー行（10件） ---"
latest_errors
echo

info "Done."
