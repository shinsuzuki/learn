# 配列のソート
$list = @(2, 3, 1)

foreach ($item in $list | Sort-Object ) {
    Write-Host $item
}
# > 1
# > 2
# > 3


# ハッシュのソート
$hash = @{}
$hash.Add(3, 30)
$hash.Add(1, 10)
$hash.Add(2, 20)

$hash.GetEnumerator() | Sort-Object -Property Key | ForEach-Object {
    $msg = [string]$_.Key + "/" + [string]$_.Value
    Write-Host $msg
}

foreach ($item in ($hash.GetEnumerator() | Sort-Object -Property Key)) {
    $msg = [string]$item.Key + ":" + [string]$item.Value
    Write-Host $msg
}

# > 1:10
# > 2;20
# > 3:30
