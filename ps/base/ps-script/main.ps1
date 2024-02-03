#____________________ ファイル内容を取得してそれを保存する
$dataDir = "data"
if (Test-Path $dataDir) {
    Remove-Item -Path $dataDir -Recurse -Force
}

Write-Host "作業DIRを作成しファイルを作成"
New-Item -ItemType Directory $dataDir | Out-Null
Set-Content -Path (New-Item -ItemType File (Join-Path $dataDir "data-1.txt")) -Value "ab,cd`r`efg" -Encoding UTF8
Set-Content -Path (New-Item -ItemType File (Join-Path $dataDir "data-2.txt")) -Value "1234567" -Encoding UTF8

Write-Host "ファイルの内容を分割、置換し配列へ登録"
$list = @()
Get-ChildItem .\data | ForEach-Object {
    Get-Content -Path $_.FullName -Encoding UTF8 | ForEach-Object {
        $list += ($_ -split "," | ForEach-Object {
                $_ -replace "12", "xyz"
            })
    }
}

Write-Host "配列をファイルに保存"
Set-Content -Path (New-Item -Path (Join-Path $dataDir "output.txt")) -Value $list -Encoding UTF8

Write-Host "ファイル内容を確認"
Get-Content -Path (Join-Path $dataDir "output.txt") -Encoding UTF8 | ForEach-Object {
    Write-Host $_
}

Remove-Item -Force -Recurse -Path $dataDir


