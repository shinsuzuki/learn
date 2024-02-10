#
# 関数カラー表示
#
function WriteMessage($msg, $type = "") {
    if ($type -eq "info") {
        Write-Host $msg -ForegroundColor DarkGreen
    }
    elseif ($type -eq "warn") {
        Write-Host $msg -ForegroundColor DarkYellow
    }
    elseif ($type -eq "error") {
        Write-Host $msg -ForegroundColor DarkRed
    }
    else {
        Write-Host $msg
    }

    # 他に出力したいコード等.....
}

# 関数呼び出しはスペース区切り
# https://stackoverflow.com/questions/4988226/how-do-i-pass-multiple-parameters-into-a-function-in-powershell

WriteMessage $myInvocation.MyCommand.name "info"
WriteMessage "start"
WriteMessage "  message aaaa"
WriteMessage "  message vvvvvvvvv" "info"
WriteMessage "  message xzsafasfawer" "warn"
WriteMessage "  message xxx" "error"
WriteMessage "end"
