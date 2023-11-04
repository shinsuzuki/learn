# 名前が含まれる場合
get-wmiobject -class win32_process | Where-Object { $_.name -like '*google*' } | Select-Object { $_name }

# ソート、ユニーク化
get-wmiobject -class win32_process | Sort-Object -Property name  | select-object -property name -unique
