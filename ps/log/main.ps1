#
$list = @()
Import-Csv .\log.csv -Encoding UTF8 | ForEach-Object {
    if ($_.contact_type.Trim() -eq "phone" -and $_.urgency.Trim() -eq "1 High") {
        $list += $_
    }
}

$list = $list | Sort-Object { $_.priority }
$outputList = @()
foreach ($item in $list) {
    $line = $item.sys_created_on + ", [" + $item.priority + "], " + $item.category + ", " + $item.state
    Write-Host $line
    $outputList += $line
}

Set-Content -Path result.txt -Encoding UTF8 -Value $outputList