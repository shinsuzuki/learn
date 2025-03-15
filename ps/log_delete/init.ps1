# データ作成
Remove-Item -Path logs -Recurse

New-Item -Path "logs" -ItemType Directory
New-Item ./logs/data1.log
New-Item ./logs/data2.log
New-Item ./logs/data3.log

Set-ItemProperty ./logs/data1.log -Name CreationTime -Value (Get-Date).AddDays(-10)
Set-ItemProperty ./logs/data1.log -Name LastWriteTime -Value (Get-Date).AddDays(-10)
Set-ItemProperty ./logs/data2.log -Name CreationTime -Value (Get-Date).AddDays(-10)
Set-ItemProperty ./logs/data2.log -Name LastWriteTime -Value (Get-Date).AddDays(-10)
