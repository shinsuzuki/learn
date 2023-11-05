# 数日前の0時
$date = [Datetime](Get-Date).AddDays(-3).ToString("d");
# or
$date = [Datetime](Get-Date).AddDays(-3).ToString("yyyy/MM/dd");

Write-Host $date.ToString();
# > 2021/11/22 0:00:00