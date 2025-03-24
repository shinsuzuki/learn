#-------------------------------------------------------------------------------
# RemoteSetting.ps1
#-------------------------------------------------------------------------------
# 踏み台側のWinRM の TrastedHosts にホストを追加
Clear-Item WSMan:\localhost\Client\TrustedHosts

# 結果を確認
Write-Host "":
Write-Host Result:
Get-Item WSMan:\localhost\Client\TrustedHosts
