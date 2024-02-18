#!/bin/bash
echo "__start bash__"
echo ""

#
# Ubuntu 22.04.2 LTS
#

#____________________ スクリプト
echo "____スクリプト"
echo "script_name:$0"       # スクリプト名
echo "script_args_count:$#" # 引数の数
# echo "script_args_1:$1"     # 1つ目の引数
# echo "script_args_2:$2"     # 2つ目の引数
# echo "script_args_all:$@"   # 全ての引数


#____________________ 文字列
echo "____文字列"
name="john_abcdefg"
echo $name

#________ 文字列展開
echo "xyz_${name}"      # xyz_john_abcdefg

#________ 部分文字列
echo "部分文字列:${name:0:3}"        # joh
echo "部分文字列:${name:4}"          # _abcdefg

#________ 長さ
echo "length:${#name}"         # 12

#________ uppper,lower
echo "upper:${name^^}"        # JOHN_ABCDEFG
echo "lower:${name,,}"        # john_abcdefg


#____________________ デフォルト引数
foo=""
echo "default:${foo:=default-val}"

#____________________ コマンドの実行
echo "____コマンド実行"
pwd
echo "dir:$(pwd)"


#____________________ 関数
echo "____関数"
#________ 文字列を返すイメージ
function get_name () {
    #echo "arg_count:$#"    # 引数の数
    echo "$1 - $2"
}

# 関数の出力を変数へ代入,パラメータはスペース区切りで渡す
myname=$(get_name "john" "punch")
echo "myname:$myname"

#________ 数値を返す
function get_value () {
    return 100
}

# returnで返された値は $? で取得する
get_value
echo "ret:$?"


#____________________ パス
echo "____パス"
path="/abc/def/ghi.cs"
echo "${path##*/}"      # ファイル名
echo "${path%/*}"       # DIR名


#____________________ 色付け
echo "____色付け"
# https://linux.just4fun.biz/?%E9%80%86%E5%BC%95%E3%81%8D%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%81%AB%E8%89%B2%E3%82%92%E4%BB%98%E3%81%91%E3%82%8B%E3%83%BBtput
tput setaf 1 && "hello world red"   # red
tput setaf 2 && "hello world green"   # grenn
tput setaf 3 && "hello world yellow"   # yellow
tput setaf 7 && "hello world white"   # white


#____________________ 制御
echo "____制御"
#________ for
echo "__for"
for v in {1..3}; do
    echo "$v"
done

#________ if
echo "__if"
#__　文字列比較
state_str="abc"
if [[ $state_str == "abc" ]]; then
    echo "if-match-str"
fi

#__　数値比較
state_val=110
if [[ $state_val -gt 100 ]]; then
    echo "if-match-value"
fi

#__ 正規表現
state_reg="123abc"
if [[ $state_reg = ^[0-9]. ]]; then
    echo "if-match-regex"
fi

#__ ファイル条件
echo "__ファイル条件"
if [[ -e file.txt ]]; then
    echo "exists > file.txt."
fi

#________ case
echo "__case"
cv="v2"
case "$cv" in
    "v1") echo case_v1
    ;;
    "v2"|"v3") echo case v2 or v3
    ;;
    *) echo default
    ;;
esac


#____________________ 配列
echo "____配列"
fruits=('apple' 'banan' 'orange')   # 丸かっこで定義、
echo "fruits-2:${fruits[2]}"    # orange、参照は波括弧


echo "__宣言"
declare -a item_array=()
item_array+=("abc")
item_array+=("def")
echo "item:${item_array[0]}"
echo "item:${item_array[1]}"

for item in "${item_array[@]}"; do
    echo "for-item:$item"
done


#____________________ 辞書
echo "____辞書"
declare -A dic
dic[a]=100
dic[b]=200
dic[c]=300
echo "dic-a:${dic[a]}"
echo "dic-b:${dic[b]}"
echo "dic-b:${dic[c]}"

echo "__辞書_key"
for key in "${!dic[@]}"; do
    echo "key:$key"
done

echo "__辞書_value"
for value in "${dic[@]}"; do
    echo "value:$value"
done


#____________________ ファイル読込
echo "____ファイル読込"
while read -r line; do
    echo "$line"
done < file.txt


#____________________ ディレクトリ操作
# echo "____ディレクトリ操作"
# ディレクトリの作成
# mkdir -p "a/b/c"

#ディレクトリを階層、中身が存在していても消す
# rm -rf "a"


#____________________ ユーザー入力の入力待ち
# echo "____ユーザー入力の入力待ち"
# echo -n "proceed? [y/n]:"
# read -r ans
# echo "$ans"


#____________________ コマンドの結果(forは使い所による)
echo "____コマンドの結果"
#for item in $(ls -1); do           << shellshock
# for item in $(ls -1 ./*.txt); do
#     echo "item:$item"
# done;


echo "__ファイル一覧"
for file in *.txt; do
    if [ -f "$file" ]; then
        echo "item:$file"
    fi
done

echo "__ファイル一覧2(IFSの半角スペース・タブ・改行を無視し、オリジナルの内容を取得する)"
find ./*.txt | while IFS= read -r line; do
    echo "item:$line"
done

echo "__コマンド結果一覧"
ps aux | head -3 | while read -r line; do
    echo "item:$line"
done

echo "__コマンド結果一覧(awk, sort)"
ps aux | awk '{ print $3, $4, $5, $11 }' | sort -k 3 -nr | head -3

echo "__コマンド結果一覧(配列に追加、参照、ファイルに出力)"
declare -a ps_array=()
while IFS= read -r line; do
    ps_array+=("$line")
done < <(ps aux | grep /lib/systemd)

outpufile="output_psaux.txt"
rm $outpufile
for item in "${ps_array[@]}"; do
    echo "item:$item"
    echo "$item" >> $outpufile
done

echo "__コマンドの出力結果を文字列で出力"
echo "dir:$(pwd)"


#____________________ 他コマンドとの連携
echo "____他コマンドとの連携"

echo "__awk(抽出)"
ls -al | awk '{ print $9, $5 | "sort -k2,2 -n -r" }'

echo "__cut(抽出)"
echo "a,b,c,d,e,f,g" | cut -d ',' -f 3-4

echo "__grep(検索)"
ps -aux | grep systemd

echo "__sed(置換、削除、抽出など)"
ps aux | sed s/systemd/SYSTEMD/g



#____________________ 設定ファイルから読込み
echo "____設定ファイルから読込み"
# shellcheck disable=SC1091
source ./setting.config
tput setaf 2 && echo "MY_VALUE1:$MY_VALUE1"
tput setaf 2 && echo "MY_VALUE2:$MY_VALUE2"
tput setaf 7



echo ""
echo "__end bash__"