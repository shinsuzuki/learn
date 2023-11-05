# カスタムオブジェクト
function CreateCustomObject() {
    $data = New-Object PSObject | Select-Object one, two, three;
    return $data
}

$datas = @()
$o1 = CreateCustomObject
$o1.one = "a1"
$o1.two= "b1"
$o1.three= "c1"
$datas += $o1;

$o2 = CreateCustomObject
$o2.one = "a2"
$o2.two= "b2"
$o2.three= "c2"
$datas += $o2;

$datas | Format-Table -AutoSize


# one two three
# --- --- -----
# a1  b1  c1
# a2  b2  c2
