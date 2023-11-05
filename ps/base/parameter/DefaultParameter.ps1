Param(      # 先頭行でないとエラー
    $startTime = [DateTime]::Today.AddHours(-15),   # 前日9時
    $endTime = [DateTime]::Today.AddHours(9),       # 本日9時
    $thresholdValue = 10
)

echo "startTime: $startTime"
echo "endTime: $endTime"
echo "thresholdValue: $thresholdValue"