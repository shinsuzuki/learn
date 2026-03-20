#!/bin/bash

# ログ出力関数
log_info() {
    echo -e "\e[32m[INFO]\e[m $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    # 標準エラー出力(>&2)に赤い文字で出力
    echo -e "\e[31m[ERROR]\e[m $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

# 異常終了時の共通処理
die() {
    log_error "$1"
    exit 1
}