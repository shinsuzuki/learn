#!/bin/bash

# 変数
echo "__変数"
val_1="aaaa"
echo "$val_1"

val_2=100
echo "$val_2"

echo "__cmdの結果を変数へ "
result=$(ls -al)
echo "$result"
