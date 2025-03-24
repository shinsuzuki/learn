#-------------------------------------------------------------------------------
# ELTool_ExtractAlert.ps1: アラートを抽出
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$startTime,
    [parameter(mandatory)][String]$endTime,
    [parameter(mandatory)][String]$logDir
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
    $now = Get-Date -Format "yyyy-MM-dd_HH-mm-ss";
    # エラーログファイル名
    $errorLogFile = "$myLogDir/error_$($scriptName)_$now.log";
    # 結果ログファイル名
    $outputLogFile = "$myLogDir/result_$($scriptName)_$now.log";
    # 対象とするタスクスケジューラ名
    $targetTaskSchedularName = '"\LDS\ELTool"';
    # ログから抽出するレベル(1:critical, 2:error, 3:warning)
    $targetLevelList = @(1, 2, 3);
    # アラート対象とするレベル(1:critical, 2:error, 3:warning)
    $targetAlertLevelList = @(1, 2, 3);
    # 出力リスト
    $outputList = New-Object 'System.Collections.Generic.List[string]';

    #-------------------- 期間出力
    $myStartTime = [Datetime]::Parse($startTime);
    $logStartTime = "startTime:" + $myStartTime.ToString("yyyy/MM/dd HH:mm:ss");
    Write-Host($logStartTime);

    $myEndTime = [Datetime]::Parse($endTime);
    $logEndTime = "endTime:" + $myEndTime.ToString("yyyy/MM/dd HH:mm:ss");
    Write-Host($logEndTime);

    #-------------------- 開始処理
    $watch = New-Object System.Diagnostics.StopWatch;
    $watch.Start();

    #-------------------- event get
    Write-Host("get event...");

    $eventList = Get-WinEvent -ComputerName localhost -FilterHashtable @{
        logname   = 'Microsoft-Windows-TaskScheduler/Operational'
        Level     = $targetLevelList
        StartTime = (Get-Date $myStartTime)
        EndTime   = (Get-Date $myEndTime)
    };

    #-------------------- doing
    Write-Host("doing...");

    $dataCount = $eventList.Length;
    $count = 0;
    $per = 0;

    foreach ($item in $eventList) {
        # 進捗率を表示
        $per = ($count++ / $dataCount * 100);
        $per = [int]$per;
        Write-Progress -Activity "check data" -PercentComplete $per -CurrentOperation "$per %"

        # Write-Host $item.Message
        # タスクスケジューラ名が対象ならチェック
        if ($item.Message.Contains($targetTaskSchedularName)) {
            # アラート対象をチェック
            if ($targetAlertLevelList.Contains([int]($item.Level))) {
                $level = $item.LevelDisplayName;
                $timeCreated = $item.TimeCreated.ToString("yyyy/MM/dd HH:mm:ss");
                $id = $item.id;
                $message = $item.Message;
                $alertMsg = "$level,$timeCreated,$id,$message"
                $outputList.Add($alertMsg);
            }
        }
    }

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
        $outputList.Reverse();
        Set-Content -path $outputLogFile -Value $outputList -Encoding default;
    }
    else {
        Write-Host "target data does not exist.";
        Set-Content -path $outputLogFile -Value "target data does not exist." -Encoding default;
    }

    exit 0;
}
catch {
    if ($_.Exception -match "No events were found that match the specified selection criteria") {
        # 指定した条件に当てはまるイベントログがない場合はエラーとしない
        Write-Host "no events found.";
        exit 0;
    }
    else {
        Write-Host $_.Exception
        $_.Exception | Format-List -force | Out-File -Encoding default $errorLogFile
        exit 1;
    }
}
