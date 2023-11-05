# encoding
$enc = [System.Text.Encoding]::UTF8

# read file
$lines = [System.IO.File]::ReadAllLines("./test-utf8.txt", $enc)

# output contents
$list =  New-Object System.Collections.Generic.list[string]
foreach ($line in $lines) {
    $list.Add($line + "_add")
}

# write file
$path = "./my-data.txt"
$outFilePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
[System.IO.File]::WriteAllLines($outFilePath , $list, $enc)