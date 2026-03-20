#!/bin/bash
# --------------------------------------------------------------------------------
# gemini.learn.sh
# --------------------------------------------------------------------------------

# 堅牢化のオプション設定
# set -e (errexit): コマンドが失敗した時点でスクリプトを即座に終了させる。 << エラーチェックの前で終了するためあまり使えない
# set -u (nounset): 未定義の変数を使おうとした時にエラーを出す（タイポ防止）。
# set -o pipefail: パイプラインの途中でエラーが起きても、全体の終了ステータスを「失敗」として扱う。
#set -euo pipefail
set -uo pipefail

# メイン処理開始
echo "処理を開始します..."

# 変数の展開
NAME="sato"
echo "hello ${NAME}" # 変数が展開される
echo 'hello $NAME' # 変数が展開されない

# コマンド置換(コマンドの結果を変数へ)
TODAY=$(date +%Y-%m-%d) # yyyy-mm-dd形式
echo "today:${TODAY}"
# mkdir "${TODAY}"


# 終了ステータス(成功なら0、失敗なら0以外)
# if
# ls /dir_xxx
# echo $?
ls /tmp_xxx

if [[ $? -eq 0 ]]; then
    echo "success"
else
    echo "failure"
fi

# 最初のコマンドが成功したとき次のコマンドを実行
ls /tmp && echo "ls /tmp success"

# 最初のコマンドが失敗したとき次のコマンドを実行
ls /tmp_xxx || echo "ls /tmp_xxx failure"
[[ -f config.txt ]] || echo "設定ファイルがありません"

# if
if [[ -f config.txt ]]; then
    echo "confit.txtが存在します"
else
    echo "confit.txtが存在しません"
fi

# loop処理
for file in data/*.csv; do
    echo "file: ${file}"
    cat "${file}"
done

echo ""
cat data/list.txt | while read line; do
    echo "${line}"
done






# メイン処理完了
echo "処理が正常に完了しました。"
