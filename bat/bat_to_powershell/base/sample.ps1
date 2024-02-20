#----------------------------------------
# MySample.ps1
#----------------------------------------
Set-StrictMode -Version Latest;
$ErrorActionPreference = "Stop"

#----------------------------------------
# ログ出力
#----------------------------------------
function Outputlog() {
    param($msg)

    $now = Get-Date -Format "yyyy/MM/dd HH:mm:ss";
    $outputMessage = "$($now) - $msg";
    Write-Host $outputMessage;
    $sw.WriteLine($outputMessage);
}

#----------------------------------------
# script before
#----------------------------------------
if (-not (Test-Path "./Log")) {
    New-Item Log -ItemType Directory | Out-Null;
}

$scriptName = [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.name);
$now = Get-Date -Format "yyyyMMddHHmmss";
$logFile = "./Log/$($scriptName)_$now.log";
$script:sw = New-Object System.IO.StreamWriter($logFile, $true, [System.Text.Encoding]::GetEncoding("utf-8"));

#----------------------------------------
# script main
#----------------------------------------
try {
    OutputLog("start $($scriptName)");
    $watch = New-Object System.Diagnostics.Stopwatch;
    $watch.Start();

    OutputLog("job...");
    Start-Sleep -Seconds 1

    #----------------------------------------
    # script after
    #----------------------------------------
    $watch.Stop();
    $t = $watch.Elapsed;
    OutputLog ("processing time[" + ($t.totalSeconds.toString("0.00")) + " sec]");
    OutputLog ("end $($scriptName) success ") ;
    $sw.Close();
    exit 0;
}
catch {
    OutputLog ("end $($scriptName) error ") ;
    $sw.Close();
    exit 1;
}
