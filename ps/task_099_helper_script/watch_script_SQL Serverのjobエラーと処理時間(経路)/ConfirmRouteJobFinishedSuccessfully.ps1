#-------------------------------------------------------------------------------
# ConfirmJobFinishedSuccessfully.ps1: 経路のジョブの正常終了を確認
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$logDir,
    [parameter(mandatory)][String]$server,
    [parameter(mandatory)][String]$database,
    [parameter(mandatory)][String]$userId,
    [parameter(mandatory)][String]$pass,
    [parameter(mandatory)][String]$jobName,
    [parameter(mandatory)][String]$targetDate
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
    $errorLogFile = "$myLogDir/error_$($scriptName)_$($jobName)_$now.log";
    # 結果ログファイル名
    $outputLogFile = "$myLogDir/result_$($scriptName)_$($jobName)_$now.log";
    # 出力リスト
    $outputList = New-Object 'System.Collections.Generic.List[string]';

    #-------------------- 対象日付
    $myTargetDate = [DateTime]::ParseExact($targetDate , "yyyy/MM/dd", $null)
    $myTargetDate = $myTargetDate.ToString("yyyyMMdd")
    Write-Host "targetDate:$myTargetDate";

    #-------------------- ジョブ名
    Write-Host "jobName:$jobName"

    #-------------------- 開始処理
    $watch = New-Object System.Diagnostics.StopWatch;
    $watch.Start();

    #-------------------- get data
    Write-Host("get data...");

    $cnnstr = "Data Source=$server;Initial Catalog=$database;User ID=$userId; Password=$pass;";
    $cnn = New-Object -TypeName System.Data.SqlClient.SqlConnection $cnnstr;
    $sql = "select
                j.name,
                h.job_id,
                h.step_id,
                h.run_date,
                h.run_time,
                h.run_duration,
                h.sql_message_id,
                h.sql_severity,
                h.step_name,
                h.run_status,
                h.message
            from sysjobhistory h
                join (
                    select
                        *
                    from
                        sysjobs
                    where
                        name = @jobName
                        and
                        enabled = 1
                ) j on h.job_id = j .job_id
                where
                    h.step_id <> 0
                    and
                    h.run_date=@targetDate
                order by
                    h.run_date,
                    h.run_time,
                    h.job_id,
                    h.step_id; "

    try {
        $cnn.Open();
        $cmd = $cnn.CreateCommand()
        $cmd.Connection = $cnn;
        $cmd.CommandText = $sql;
        # param
        $sqlparam = New-Object Data.SqlClient.SqlParameter("@jobName", [Data.SQLDBType]::NVarChar, -1);
        $cmd.Parameters.Add($sqlparam).Value = $jobName;
        $sqlparam = New-Object Data.SqlClient.SqlParameter("@targetDate", [Data.SQLDBType]::NVarChar, -1);
        $cmd.Parameters.Add($sqlparam).Value = $myTargetDate;
        # execute
        $adpter = New-Object -TypeName System.Data.SqlClient.SqlDataAdapter $cmd;
        $ds = New-Object -TypeName System.Data.DataSet;
        $adpter.Fill($ds) | Out-Null;
        $table = $ds.Tables[0];
    }
    catch {
        Write-Host $_.Exception
        $_.Exception | Format-List -force | Out-File -Encoding default $errorLogFile;
        exit 1;
    }
    finally {
        $cnn.Close();
        $cnn.Dispose();
    }

    #-------------------- doing
    Write-Host("doing...");
    foreach ($row in $table.Rows) {
        $stepId = $row.item("step_id");
        $runDuration = $row.item("run_duration");
        $sqlMessageId = $row.item("sql_message_id");
        $sqlSeverity = $row.item("sql_severity");
        $stepName = $row.item("step_name");
        $runStatus = $row.item("run_status");
        $msg = $row.item("message");

        $runDate = $row.item("run_date");
        $runTime = $row.item("run_time");
        $runDateTimeJoin = "$($runDate)$($runTime)"
        $runDateTime = [DateTime]::ParseExact($runDateTimeJoin , "yyyyMMddHHmmss", $null)
        $runDateTimeStr = $runDateTime.ToString("yyyy/MM/dd HH:mm:ss")

        if ($runStatus -eq 0) {
            $outmsg = "NG,$runDateTimeStr,$stepId,$stepName,$runStatus,$runDuration,$sqlSeverity,$sqlMessageId,$msg";
            Write-Host $outmsg
            $outputList.Add($outmsg);
        }
        else {
            $outmsg = "OK,$runDateTimeStr,$stepId,$stepName,$runStatus,$runDuration";
            Write-Host $outmsg
            $outputList.Add($outmsg);
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
        New-Item $myLogDir -type directory -Force | Out-Null;
        Set-Content -path $outputLogFile -Value $outputList -Encoding default;
    }
    else {
        Write-Host "target data does not exist.";
        Set-Content -path $outputLogFile -Value "target data does not exist." -Encoding default;
    }

    exit 0;
}
catch {
    Write-Host $_.Exception
    $_.Exception | Format-List -force | Out-File -Encoding default $errorLogFile;
    exit 1;
}
