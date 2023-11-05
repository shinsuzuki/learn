# read file, output contents
$list =  @()
foreach ($line in @(gc -path "./test-utf8.txt" -Encoding UTF8)) {
    $list += ($line + "_add")
}

# write file
sc -path "./test-utf8-add-c.txt" -Encoding UTF8 -Value $list