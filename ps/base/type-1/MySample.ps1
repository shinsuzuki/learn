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

$config = Get-Content "config.json" -Raw | ConvertFrom-Json;
# Outputlog("dbServer=$($config.dbServer)")
# Outputlog("database=$($config.database)")
# Outputlog("user=$($config.user)")
# Outputlog("password=$($config.password)")
# Outputlog("timeout=$($config.timeout)")
# Outputlog("url=$($config.url)")

#----------------------------------------
# script main
#----------------------------------------
try {
    OutputLog("start $($scriptName)");
    $watch = New-Object System.Diagnostics.Stopwatch;
    $watch.Start();

    OutputLog("job...");

    #----------
    # db
    #----------
    # $cnstr = "Data Source=$($config.dbServer);Initial Catalog=$($config.database);User ID=$($config.user); Password:$($config.password); Connection Timeout=$($config.timeout);";
    # $cn = New-Object -TypeName System.Data.SqlClient.SqlConnection $cnstr;

    # try {
    #     $cn.open();
    #     $cmd = $cn.CreateCommand();
    #     $cmd.Connection = $cn;
    #     $sql = "select ...";
    #     $cmd.CommandText = $sql;
    #     $adaper = New-Object -TypeName System.Data.SqlClient.SqlDataAdapter $cmd;
    #     $adaper.Fill($ds) | Out-Null
    #     $table = $ds.$Tables[0];
    #     foreach ($row in $table.Rows) {
    #         #...
    #     }

    #     #...
    # }
    # catch {
    #     throw;
    # }
    # finally{
    #     $cn.close();
    #     $cn.Dispose();
    # }


    #----------
    # api
    #----------
    # try {
    #     $url = $config.url;
    #     $response = Invoke-WebRequest -Method Get -Uri $url;
    #     Outputlog("StatusCode:$($response.StatusCode)");
    #     Outputlog("StatusDescription:$($response.StatusDescription)");
    # }
    # catch [System.Net.WebException] {
    #     $exceptionResponse = $_.Exception.Response;

    #     if ($null -eq $exceptionResponse) {
    #         # network error script end
    #         throw;
    #     }

    #     $stream = $exceptionResponse.GetResponseStream;
    #     $stream.Position = 0;
    #     $reader = [System.IO.StreamReader]::new($stream);
    #     $errorResponse = $reader.ReadToEnd();
    #     $stream.close();
    #     $reader.close();
    #     Outputlog("StatusCode:$($exceptionResponse.StatusCode.value__)");
    #     Outputlog("StatusCode:$($exceptionResponse.StatusCode)");
    #     Outputlog("ErrorResponse:$($errorResponse)");
    # }

    #----------------------------------------
    # script after
    #----------------------------------------
    $watch.Stop();
    $t = $watch.Elapsed;
    OutputLog("processing time[" + ($t.totalSeconds.toString("0.00")) + " sec]");
    OutputLog("end $($scriptName)");
    $sw.Close();
    exit 0;
}
catch {
    $sw.Close();
    exit 1;
}