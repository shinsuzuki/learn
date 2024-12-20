#!/bin/bash

# 変数
#--------------------
name="john"
echo $name
# 文字列を展開
echo "my name is ${name}."
# 部分文字列
echo "部分文字列: ${name:0:2}"
# 文字列超
echo "文字列長:${#name}"


# 配列
#--------------------
array_info() {
    echo "<array info>"

    # 関数に配列を渡す場合はdeclare -n により名前参照することにより配列を参照できる
    declare -n array=$1

    # 配列のサイズ
    echo -e "\tarray size: ${#array[*]}"

    # 配列の内容を参照(*)
    echo -e "\tarray value:${array[*]}"

    # loop
    echo -e "\tfor loop"
    for item in "${array[@]}"
    do
        echo -e "\t\t$item"
    done;

    # loop2
    echo -e "\tloop(for-index)"
    for ((i=0;i<${#array[*]};i++))
    do
        echo -e "\t\t${array[i]}"
    done
}

# 初期化
array0=(1 2 3 4)
array_info array0


# 空の配列を作成
array1=()
# 配列に要素を追加
array1+=('add1')
array1+=('add2')
array_info array1


# declareにより明示的に配列を作成
declare -a array2=()
# 配列に要素を追加
array2[0]="add1"
array2[1]="add2"
array2[2]="add3"
array_info array2

# 配列を削除
del_array=(1 2 3)
echo "before del_array size: ${#del_array[*]} - value:${del_array[*]}"
unset "del_array[1]"
echo "after  del_array size: ${#del_array[*]} - value:${del_array[*]}"


# 辞書
#--------------------
declare -A dic
dic[a]=100
dic[b]=101
dic[c]=102
echo "${dic[a]}"
echo "${dic[b]}"

# 辞書のキー
for key in "${!dic[@]}";
do
    echo "key:$key"
done

# 辞書の値
for v in "${dic[@]}";
do
    echo "value:$v"
done

# 辞書のkeyをソート
keys=$(echo "${!dic[*]}" | tr ' ' '\n' | sort)
for key in ${keys};
do
    echo "${key}:${dic[$key]}"
done
