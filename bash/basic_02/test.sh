#!/bin/bash
echo "--> start"


# 変数
echo "---------------------------------------- 変数"
name="sato"
echo $name
echo "my name: ${name}"
echo "my name length: ${#name}"
echo "---------------------------------------- 環境変数"
echo "${HOME}"
echo "${SHELL}"
echo "${USER}"

echo "---------------------------------------- printenv start"
printenv
echo "---------------------------------------- printenv end"

# 配列
echo "---------------------------------------- 配列"
echo "---------- 配列を作成"
arr1=()
arr1+=(1)
arr1+=(2)

echo "---------- 全参照"
echo "all_data: ${arr1[*]}"
# 1 2

echo "---------- 単一参照"
echo "arr1[1]: ${arr1[1]}"
# 2
echo "---------- 配列の長さ"
echo "length: ${#arr1[*]}"
# 2

echo "---------- 宣言をして配列を作成"
declare -a arr2=()
arr2[0]=1
arr2[1]=2
echo "${arr2[@]}"

echo "---------- 配列の内容を参照(for-in)"
for item in "${arr2[@]}"
do
    echo "${item}"
done;

echo "---------- 配列の内容を参照(for-loop)"
for ((i=0;i<${#arr2[*]}; i++))
do
    echo "${arr2[i]}"
done;

echo "---------- 辞書を作成"
declare -A dic1
dic1[a]=100
dic1[b]=200
dic1[c]=300

echo "---------- 単一参照"
echo "dic1[a]: ${dic1[a]}"
echo "dic1[b]: ${dic1[b]}"
echo "dic1[c]: ${dic1[c]}"

echo "---------- 全参照(キーでソート)"
#for key in $(echo "${!dic1[*]}" | tr ' ' '\n'  | sort);
for key in $(printf "%s\n" "${!dic1[@]}" | sort)
do
    echo "${key}, ${dic1[key]}"
done;


# 制御構造






# コマンドとの連携




echo "<-- end"