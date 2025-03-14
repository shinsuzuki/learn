
Import-Module webadministration

$appPoolName = "DefaultAppPool"
Get-WebAppPoolState $appPoolName

