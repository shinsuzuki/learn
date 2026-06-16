#!/bin/bash

if [[ -f "test.log" ]]; then
    echo "test.log found"
else
    echo "test.log not found"
fi

if [[ -d "/var/log" ]]; then
    echo "/var/log found"
else
    echo "/var/log not found"
fi

if [[ ! -f "access2.log" ]]; then
    # 監視ツールでキャッチされる
    echo "[error] access.log not found" >&2
    exit 1
fi




name="sato"

if [[ $name == "sato" ]]; then
    echo "hello $name"
fi

if [[ $name =~ ^s ]]; then
    echo "sで開始している"
fi



