# 管理者権限が必要

# アプリケーションプール名を設定
$APPPOOL_NAME = "DefaultAppPool"

#__________ アプリケーションプール起動(appcmd)
C:\Windows\System32\inetsrv\appcmd start apppool /apppool.name:$APPPOOL_NAME
