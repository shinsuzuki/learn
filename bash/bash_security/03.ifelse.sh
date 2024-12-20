#!/bin/bash

# bash条件
#  0:成功
#  1:失敗

echo "__if_1"
if cd tmp; then
    echo 'success cd'
else
    echo 'failure cd'
fi

echo "__if_2"
if ls | grep tmp; then
    echo 'success find tmp'
else
    echo 'failure find tmp'
fi

echo "__数値評価(アルファベット順)"
val_1=1
val_2=3
if [[ $val_1 -lt $val_2 ]]; then
    echo 'val_1 <= val_2'
else
    echo 'val_1 > val_2'
fi

echo "__数値評価(数値順)"
if ((val_1 < val_2)); then
    echo 'val_1 <= val_2'
fi
