#
# 保存先 → C:\Documents and Settings\＜ユーザー名＞\My Documents\WindowsPowerShell\pfofile.ps1
#

# プロンプト短縮1
# function prompt() {
#     "[" + (Split-Path (Get-Location) -Leaf) + "] > "
# }

# プロンプト短縮2
function prompt
    {"PS " + (get-location).drive.name+":\...\"+ $( ( get-item $pwd ).Name ) +">"
}