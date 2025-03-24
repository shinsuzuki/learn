# 実行するコマンドを表示する
cls

$targetDir="dir-a"

Write-Host "`r`n>>>>>>>> シンプルに変数を指定したコマンドを表示"
write-Host "cmd: Get-ChildItem -Path $targetDir"        # cmd: Get-ChildItem -Path dir-a
Get-ChildItem -Path $targetDir

Write-Host "`r`n>>>>>>>> 変数に変数をいれてコマンドを表示"
$targetDir2="${targetDir}-a"
write-host $targetDir2                                  # dir-a-a
write-Host "cmd: Get-ChildItem -Path ${targetDir2}"     # cmd: Get-ChildItem -Path dir-a-a
Get-ChildItem -Path ${targetDir2}
