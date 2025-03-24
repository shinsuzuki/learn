#-------------------------------------------------------------------------------
# CheckDiskUsage.ps1: アラートを抽出
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$logDir,
    [parameter(mandatory)][String]$targetServers
)

# エラー設定
$ErrorActionPreference = "Stop";

try {
    #-------------------- 基本設定
    # ログディレクトリ存在チェック
    $myLogDir = $logDir;

    if (-not (Test-Path $myLogDir)) {
        Write-Host "parameter logDir does not exist"
        throw "parameter logDir does not exist"
    }

    # スクリプトファイル名
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($myInvocation.MyCommand.name);
    # 処理日時
    $now = Get-Date -Format "yyyy-MM";
    $nowTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss";
    # エラーログファイル名
    $errorLogFile = "$myLogDir/error_$($scriptName)_$nowTime.log";
    # 結果ログファイル名
    $outputLogFile = "$myLogDir/result_$($scriptName)_$now.log";
    # 出力リスト
    $outputList = New-Object 'System.Collections.Generic.List[string]';
    # 対象サーバー
    $servers = $targetServers.Split(",")

    #-------------------- 開始処理
    $watch = New-Object System.Diagnostics.StopWatch;
    $watch.Start();

    #-------------------- doing
    Write-Host("doing...");
    $outputStr = "";

    foreach ($srv in $servers) {
        $computerName = $srv.split(":")[0];
        $loginUser = $srv.split(":")[1];
        $pwdFile = $srv.split(":")[2];
        Write-Host "target:$computerName,$loginUser,$pwdFile"

        # credential
        $password = Get-Content $pwdFile | ConvertTo-SecureString;
        $credential = New-Object System.Management.Automation.PSCredential $loginUser, $password;

        # get disk info
        $drives = Invoke-Command -ComputerName $computerName -Credential $credential -ScriptBlock {
            Get-WmiObject Win32_LogicalDisk -Filter DriveType=3 |
            Select-Object DeviceID,
            @{N = "UsedPercent"; E = { "{0:N0}" -f (($_.Size - $_.FreeSpace) / $_.Size * 100) } },
            @{N = "Capacity"; E = { "{0:N0}" -f ($_.Size / 1GB) } },
            @{N = "UsedSpace"; E = { "{0:N0}" -f (($_.Size - $_.FreeSpace) / 1GB) } },
            @{N = "FreeSpace"; E = { "{0:N0}" -f (($_.FreeSpace) / 1GB) } }
        }

        if ($outputStr -eq "") {
            $outputStr = Get-Date -Format "yyyy/MM/dd HH:mm:ss";
        }

        $outputStr += ",$($computerName)";

        foreach ($item in $drives) {
            $deviceId = $item.DeviceID -replace ":", "";
            $UsedPercent = $item.UsedPercent;
            #$freeSpace = $item.FreeSpace;
            $usedSpace = $item.UsedSpace;
            #$capacity = $item.Capacity;
            #$driveInfo = "$deviceId,$($UsedPercent),$($usedSpace),$($freeSpace),$($capacity)";
            $driveInfo = "$($deviceId):$($UsedPercent)%:$($usedSpace)GB";
            $outputStr += "($($driveInfo))";
        }
    }

    Write-Host $outputStr;
    $outputList.Add($outputStr);

    #-------------------- 終了処理
    $watch.Stop();
    $t = $watch.Elapsed;

    Write-Host("========================================");
    Write-Host("[done]");
    Write-Host("execution time:" + ($t.TotalSeconds.ToString("0.00")) + " sec");
    Write-Host("========================================");

    #-------------------- ファイルへ保存
    if ($outputList.Count -gt 0) {
        Write-Host "target data exists.";
        New-Item $myLogDir -type directory -Force | Out-Null
        Add-Content -path $outputLogFile -Value $outputList -Encoding default;
    }
    else {
        Write-Host "target data does not exist.";
        Set-Content -path $outputLogFile -Value "target data does not exist." -Encoding default;
    }

    exit 0;
}
catch {
    Write-Host $_.Exception
    $_.Exception | Format-List -force | Out-File -Encoding default $errorLogFile
    exit 1;
}
