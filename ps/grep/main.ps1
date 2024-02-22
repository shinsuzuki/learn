Write-Host "____start"

Select-String -Path .\sample.log -Pattern "^INC[0-9].+,2020-02-03" | Out-File -enco utf8 result.txt

Write-Host "____end"


