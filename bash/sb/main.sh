#!/bin/bash
# 安全装置（エラーが発生したら即座に中断）
set -e

echo $0

# スクリプト自身の場所を基準に、同じディレクトリにある utils.sh を読み込む
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
source "$SCRIPT_DIR/utils.sh"

TARGET_LOG="${1:-access.log}"

echo "[INFO] 処理を開始します..."

# utils.sh 内の関数を、まるでこのファイル内で定義したかのように呼び出せる
if check_required_file "$TARGET_LOG"; then
    echo "[INFO] $TARGET_LOG の解析に成功しました。"
else
    # 失敗時のハンドリング（check_required_file内で内部的にlog_errorも動いています）
    echo "[FATAL] バッチ処理を異常終了します。" >&2
    exit 1
fi
