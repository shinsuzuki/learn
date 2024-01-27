# CSVの列をダブルクォーテーションで囲む
#import-csv "sample.csv" | export-csv "sample_out.csv" -NoTypeInformation

# ダブルクォーテーションで囲まれたCSV列の中身を取得
$lines = import-csv "sample.csv"
$list =  New-Object System.Collections.Generic.list[string]

foreach ($line in $lines) {
    $list.Add($line.title1 + "_" + $line.title2 + "_" + $line.title3 + "_" + $line.title4)
}

$enc = [System.Text.Encoding]::UTF8
$path = "./sample_out_list.txt"
$outFilePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
[System.IO.File]::WriteAllLines($outFilePath , $list, $enc)
