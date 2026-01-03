#!/bin/bash
echo "--> start"

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

echo "---------------------------------------- リダイレクト"
#  2> : 標準エラー出力をファイルに書き込む（上書き）
cat missing.txt 2>> error.log

# &> : 標準出力と標準エラー出力の両方をファイルに書き込む（Bash固有の簡便記法）。
cat missing.txt &> error_1_2.log

# 標準出力とファイルに書き込む
grep "keyword" largefile.log 2>&1  grep_output.txt | tee -a error_1_2_2.log

echo "---------------------------------------- パイプ"
grep "missing" error.log | wc -l


echo "---------------------------------------- 日付"
date "+%Y-%m-%d" # 2026-01-04

echo "---------------------------------------- 制御"
# if(比較用、bash拡張)
num=11
if [[ "$num" -gt 10 ]]; then
    echo "10 以上"
fi

if [[ "$num" -gt 20 ]] ; then
    echo "20 以上"
else
    echo "20 以下"
fi

# case(パターンマッチング用)
ans=10
case $ans in
    10)
        echo "ans=10"
        ;;
    20)
        echo "ans=20"
        ;;
    *)
        echo ans=その他
        ;;
esac


# for
for i in "a" "b" "c"
do
    echo $i
done;

for ((i=0;i<3;i++));
do
    echo $i
done;


echo "<-- end"