#
# 保存先 → C:\Documents and Settings\＜ユーザー名＞\My Documents\WindowsPowerShell\pfofile.ps1
#
function prompt() {
    "[" + (Split-Path (Get-Location) -Leaf) + "] > "
}