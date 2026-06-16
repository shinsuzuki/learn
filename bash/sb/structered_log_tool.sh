#!/bin/bash

# ====== 設定 ======
LOG_FILE="${1:-access.log}"   # 引数があれば使う、なければ access.log

# ====== 関数 ======
error() {
    echo -e "\e[31m[ERROR]\e[0m $1" >&2
}

info() {
    echo -e "\e[32m[INFO]\e[0m $1"
}

check_file() {
    if [[ ! -f "$1" ]]; then
        error "File not found: $1"
        exit 1
    fi
}

count_404() {
    grep " 404 " "$LOG_FILE" | wc -l
}

top_ips() {
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head
}

# ====== メイン処理 ======
info "Target log: $LOG_FILE"
check_file "$LOG_FILE"

echo
info "行数"
wc -l < "$LOG_FILE"

echo
info "404件数"
count_404

echo
info "IPランキング"
top_ips
