Write-Host "`r`n>>>>>>>> 配列(.net)"
$list = New-Object System.Collections.Generic.List[string]
$list.Add("a")
$list.Add("g")
$list.Add("c")
foreach ($item in $list) {
    Write-Host $item
}


Write-Host "`r`n>>>>>>>> 配列(ps)"
$array = @()
$array += 12
$array += 23
Write-Host ($array -join "-")


Write-Host "`r`n>>>>>>>> ハッシュ"
$hash = @{}
$hash["a"] = 1
$hash["b"] = 2
Write-Host $hash["b"]


Clear-Host
Write-Host "`r`n>>>>>>>> Property指定"
Get-ChildItem ./ | Select-Object -Property Name

Clear-Host
Write-Host "`r`n>>>>>>>> Filter"
Get-ChildItem ./ -Recurse -File | Where-Object { $_.Name -like 't1*' }

Clear-Host ForEach-Object
Get-Process | ForEach-Object { $_.Name }
#Get-Process | %{ $_.Name }
