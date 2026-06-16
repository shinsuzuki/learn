# 共通関数

# エラー出力
function log_error() {
  echo -e "\e[31m[ERROR]\e[0m $1" >&2
}

# 必須ファイルの存在チェックを行う関数
function check_required_file() {
    local target_file="$1"

    if [[ ! -f "$target_file" ]]; then
        log_error "必須ファイルが見つかりません: $target_file"
        return 1
    fi
    return 0
}