# 管理者権限が必要

# https://learn.microsoft.com/ja-jp/previous-versions/dd647592(v=technet.10)?redirectedfrom=MSDN

# アプリケーションプール名を設定
$APPPOOL_NAME = "DefaultAppPool"

#__________ アプリケーションプール一覧
C:\Windows\System32\inetsrv\appcmd list apppools

Write-Host ""
C:\Windows\System32\inetsrv\appcmd list apppools $APPPOOL_NAME
