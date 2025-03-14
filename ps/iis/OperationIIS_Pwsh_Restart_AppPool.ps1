
Import-Module webadministration

$appPoolName = "DefaultAppPool"
Restart-WebAppPool $appPoolName
