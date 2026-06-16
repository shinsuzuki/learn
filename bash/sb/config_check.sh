#!/bin/bash

CONFIG="config.json"
LOG_DIR="/var/log"

echo "===== Config Checker ====="

# 設定ファイルチェック
if [[ ! -f "$CONFIG" ]]; then
    echo "[ERROR] $CONFIG が見つかりません" >&2
    exit 1
else
    echo "[OK] $CONFIG が存在します"
fi

# ログディレクトリチェック
if [[ -d "$LOG_DIR" ]]; then
    echo "[OK] ログディレクトリ: $LOG_DIR"
else
    echo "[ERROR] ログディレクトリがありません: $LOG_DIR" >&2
    exit 1
fi

# JSON の簡易チェック（jq がある場合）
if command -v jq >/dev/null 2>&1; then
    echo "[INFO] jq が見つかりました。JSON を整形します:"
    jq . "$CONFIG"
else
    echo "[INFO] jq がありません。JSON チェックはスキップします。"
fi

