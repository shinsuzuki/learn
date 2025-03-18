
# 配列(.net)
$list = New-Object System.Collections.Generic.List[string]
$list.Add("a")
$list.Add("g")
$list.Add("c")

foreach ($item in $list) {
    Write-Host $item
}

# 配列(ps)
$array = @()
$array += 12
$array += 23
Write-Host ($array -join "-")

# ハッシュ
$hash = @{}
$hash["a"] = 1
$hash["b"] = 2
Write-Host $hash["b"]