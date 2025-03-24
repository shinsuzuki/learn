# 管理者権限が必要

# アプリケーションプール名を設定
$APPPOOL_NAME = "DefaultAppPool"

#__________ アプリケーションプール起動(appcmd)

#C:\Windows\System32\inetsrv\appcmd start apppool /apppool.name:$APPPOOL_NAME

#$proc = Start-Process -FilePath "$env:SYSTEMROOT\System32\inetsrv\APPCMD.exe" -ArgumentList "START APPPOOL ${APPPOOL_NAME}" -Wait -NoNewWindow -PassThru
$proc = Start-Process -FilePath "$env:SYSTEMROOT\System32\inetsrv\APPCMD.exe" -ArgumentList "STOP APPPOOL ${APPPOOL_NAME}" -Wait -NoNewWindow -PassThru

if ($proc.ExitCode -eq 0) {
    Write-Host "success"
} else {
    Write-Host "error:"
}

#Write-Host "result:$result"
