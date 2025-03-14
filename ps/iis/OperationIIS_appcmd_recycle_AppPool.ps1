# 管理者権限が必要

# アプリケーションプール名を設定
$APPPOOL_NAME = "DefaultAppPool"

#__________ アプリケーションプールリサイクル(appcmd)
C:\Windows\System32\inetsrv\appcmd recycle apppool /apppool.name:$APPPOOL_NAME

