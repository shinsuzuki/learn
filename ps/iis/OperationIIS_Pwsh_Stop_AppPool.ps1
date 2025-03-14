
Import-Module webadministration

$appPoolName = "DefaultAppPool"
Stop-WebAppPool $appPoolName

