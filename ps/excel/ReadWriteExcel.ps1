# ファイルオープン
$xl = New-Object -Com Excel.Application
$xl.DisplayAlerts = $false
$wb = $xl.Workbooks.Open(D:\xxxx\ps\myexcel.xlsx)

# シートを取得
$sheet = $wb.Worksheets.Item("Sheet1")

# セルの値を取得
Write-Output $sheet.Cells.Item(1,1).Text

# セルの値を設定
$sheet.Cells.Item(1,2) ="ABC1234"
Write-Output $sheet.Cells.Item(1, 2).Text

# ファイルの保存
$wb.Save();

# 後処理
$wb.close()
$xl.quit()
[void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($xl)