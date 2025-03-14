
Import-Module webadministration

$appPoolName = "DefaultAppPool"
Start-WebAppPool $appPoolName
