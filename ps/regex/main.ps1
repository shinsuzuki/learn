
Write-Host "____start____"

#________________ 正規表現(-match,-cmatch)

# 文字リテラル（文字列を指定）
"book" -match "oo"  # True
"book" -match "OO"  # True
"BOOK" -cmatch "oo"  # false


# 文字グループ(任意の文字をチェック)
"big" -match "b[iog]g"  # True

# 範囲チェック
"42" -match "[0-9][0-9]"    # True
"abc" -match "^[a-z-Z]{3}$"   # True
"abcd" -match "^[a-z-Z]{3}$"  # False

# 単語
"Book" -match "\w"  # True
"Book123" -match "^[a-zA-Z_0-9]+$"  # True
"Book_+123" -match "^[a-zA-Z_0-9]+$"  # False

# ワイルドカード
"abc" -match "..."  # True
"abc" -match "........"  # False

# 空白
" abc " -match "\sabc\s"    # True

# 量指定子
"abc123defgzzz" -match "[a-z]+[0-9]*z{3}"    # True
"abcdefgzzz" -match "[a-z]+[0-9]*z{3}"    # True
"abczzzz" -match "z{1,3}"   # True

# アンカー
"fishing" -match "^f.+g$"   # True

# 文字のエスケープ
"ver1.20" -match "^ver[0-9]\.[0-9]{2}"  # True
"ver1.20" -match "^ver[0-9]\.[0-9]{4}"  # False

# グループ
"this is a pen" -match "(.+is)\s(.+)"
$Matches
# __result
# Name                           Value
# ----                           -----
# 2                              a pen
# 1                              this is
# 0                              this is a pen
$Matches.Count
# __result
# 3
$Matches.Item(1)
# __result
# this is
$Matches.Item(2)
# __result
# a pen

# グループに名前を付ける
"this is a pen" -match "(?<mae>.+is)\s(?<ato>.+)"
$Matches.item("mae")
# __result
# this is
$Matches.item("ato")
# __result
# a pen


#________________ 正規表現の置換(-replace)
"this is a pen" -replace "pen", "sword"
# __result
# this is a sword
"ver1.20" -replace "\.[0-9]+", ".30"
# __result
# ver1.30


#________________ Selec-String
Select-String -path "./sample.txt" -Pattern "^[0-9]+$" |
    ForEach-Object {
        Write-Host ($_.Filename+ ":" + $_.LineNumber + ":" + $_.Line)
    }
# __result
# sample.txt:1:12345
# sample.txt:4:6789


Write-Host "____end____"
