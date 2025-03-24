#-------------------------------------------------------------------------------
# RemoteMkpass.ps1
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$pwdFileName
)

#Write-Host "pwdFileName: $pwdFileName"

$cred = Get-Credential
$cred.Password | ConvertFrom-SecureString | Set-Content $pwdFileName
