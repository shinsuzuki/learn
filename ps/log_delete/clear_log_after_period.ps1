#
# 7日過ぎたログを消す
#
$DELETE_DAYS_ELAPSED = 7
Get-ChildItem ./logs -Recurse -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$DELETE_DAYS_ELAPSED) } | Remove-Item -Force
