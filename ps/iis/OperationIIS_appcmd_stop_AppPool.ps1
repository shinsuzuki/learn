# 管理者権限が必要

# アプリケーションプール名を設定
$APPPOOL_NAME = "DefaultAppPool"

#__________ アプリケーションプール終了(appcmd)
C:\Windows\System32\inetsrv\appcmd stop apppool /apppool.name:$APPPOOL_NAME


