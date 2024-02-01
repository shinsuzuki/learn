# IPアドレスを調査
Get-NetIPAddress | Select-Object InterfaceAlias,IPAddress | Out-File "result.txt"
