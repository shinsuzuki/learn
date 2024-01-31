# モジュールファイル（psm1）を読み込む、using moduleはファイルの先頭に記述する必要があります
using module "./utils/StringEx.psm1"
Write-Host(StringToUpper("abcDEFghi"))

# スクリプト（ps1）ファイルを読み込む
. "./utils/StringEx.ps1"
Write-Host(StringToLower("abcDEFghi"))

# モジュールファイル（psm1）を読み込み
Import-Module "./utils/StringEx2.psm1"
Write-Host(StringToLower2("xyzABC"))

# スクリプトの現在パスから相対パスを取得する方法
Import-Module $PSScriptRoot/utils/StringEx3.psm1
Write-Host(StringToUpper2("xyzABC"))

#__result
# StringToUpper > ABCDEFGHI
# StringToLower > abcdefghi
# StringToLower2 > xyzabc
# StringToUpper2 > XYZABC