#-------------------------------------------------------------------------------
# RemoteSetting.ps1
#-------------------------------------------------------------------------------
# 踏み台側のWinRM の TrastedHosts にホストを追加
$servers = "LDS-GWH-221,LDS-APH-222,LDS-DBH-223";
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $servers

# 結果を確認
Write-Host "":
Write-Host Result:
Get-Item WSMan:\localhost\Client\TrustedHosts
