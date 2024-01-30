$outlist = @()

Get-Content -path "./sample_utf8.txt" -Encoding UTF8 |
    ForEach-Object {
        $outlist += $_
    }

Set-Content -path "./sample_output_utf8.txt" -Value $outlist -Encoding UTF8