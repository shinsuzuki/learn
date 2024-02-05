# CPUによりソートし上位5件出力
Get-Process | Where-Object { $_.CPU -gt 3 } | Sort-Object -Descending { $_.CPU } | Select-Object -First 5

# __result
# Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
# -------  ------    -----      -----     ------     --  -- -----------
#    2175      42   293640     320140     527.78  23664   7 chrome
#    1938     129   167396     286196     201.89   3696   7 chrome
#    1000      27   230596     247760     116.06  11808   7 Code
#     283      15     3596      17696      86.88   2040   7 ElcMouseApl
#     626      36   246752     274972      81.92  26580   7 Code