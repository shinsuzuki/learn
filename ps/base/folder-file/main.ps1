#Get-ChildItem ./

# 階層ディレクトリを作成
if(!(Test-Path "./tmp1")) {
    New-item -type Directory -path "tmp1/tmp2/tmp3"
    New-item -Type File -path "tmp1/ttt1.txt"
    New-item -Type File -path "tmp1/tmp2/ttt1.txt"
    New-item -Type File -path "tmp1/tmp2/tmp3/ttt1.txt"
}

# ファイルの作成,utf8で作成される
if (!(Test-Path "./f1.txt")) {
    New-item -type File "f1.txt"
}

for ($i = 0; $i -lt 10; $i++) {
    $rnd = Get-Random(1000)
    New-item -Type File -path "tmp_${rnd}.txt"
}


# コピーフォルダ
Copy-Item "f1.txt" "f2.txt"

# ファイル一覧取得
Get-ChildItem -Recurse -Filter "*.txt"




# 少し待つ
Start-Sleep -Seconds 10

# ディレクトリを削除
if (Test-path "tmp1") {
    Remove-Item -Path "./tmp1" -Recurse -Force
}

# ファイルの削除
if (Test-Path "f1.txt") {
    Remove-Item -path "*.txt" -Force
}
