# モジュールファイル（psm1）を読み込む、これはファイルの先頭に記述する
using module "./utils/StringEx.psm1"
Write-Host(StringToUpper("abcDEFghi"))


# スクリプト（ps1）ファイルを読み込む
. "./utils/StringEx.ps1"
Write-Host(StringToLower("abcDEFghi"))

#__result
# StringToUpper > ABCDEFGHI
# StringToLower > abcdefghi
