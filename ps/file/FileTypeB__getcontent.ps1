# read file
$lines = @(Get-Content -path "./test-utf8.txt" -Encoding UTF8)
Write-Host $lines

# output contents
$list =  @()
foreach ($line in $lines) {
    $list += ($line + "_add")
}

# write file
Set-Content -path "./test-utf8-add-b.txt" -Encoding UTF8 -Value $list