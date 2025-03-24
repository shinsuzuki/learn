#-------------------------------------------------------------------------------
# RemoteTest.ps1
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$user,
    [parameter(mandatory)][String]$targetServer,
    [parameter(mandatory)][String]$pwdFileName
)

#Write-Host "$user/$targetServer/$pwdFileName"

$password = Get-Content $pwdFileName | ConvertTo-SecureString;
$credential = New-Object System.Management.Automation.PSCredential $user, $password;
Invoke-Command -ComputerName $targetServer -Credential $credential -ScriptBlock { Get-WmiObject Win32_LogicalDisk }
