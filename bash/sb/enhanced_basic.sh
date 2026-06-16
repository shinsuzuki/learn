#!/bin/bash

TARGET_DIR="/var/log"
LOG_PATTERN="*.log"
TODAY=$(date "+%Y-%m-%d")


function check_dir() {
    if [ ! -d "$TARGET_DIR" ]; then
        echo "{error+ dir not found: $TARGET_DIR}"
        exit 1
    fi
}

function total_size() {
    local size=$(du -sh "$TARGET_DIR" | awk '{print $1}')
    echo "総サイズ: $size"
}

function latest_logs() {
    echo "---- 最新ログ10行 ----"
    tail -n 10 "$TARGET_DIR"/*.log 2>/dev/null
}

function error_summary() {
    echo "---- ERROR 行の件数 ----"
    grep -R "ERROR" "$TARGET_DIR" 2>/dev/null | wc -l
}


####
echo "==== start ===="
echo "date: $TODAY"
echo "target_dir: $TARGET_DIR"
echo
check_dir
count_files
total_size
latest_logs
error_summary


echo
echo "==== end ===="
