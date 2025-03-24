#-------------------------------------------------------------------------------
# ConfirmIncreaseNumberOfImports.ps1: 取り込み件数の増加量確認
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$logDir,
    [parameter(mandatory)][String]$server,
    [parameter(mandatory)][String]$database,
    [parameter(mandatory)][String]$userId,
    [parameter(mandatory)][String]$pass
)

# エラー設定
$ErrorActionPreference = "Stop";

#$logDir="D:\NikonLDS\Maintenance\SQLCheck\log"
#$server="LDS-DB-G20\LDS"
#$database="LDS_DB_VIEWER"
#$userId="fpduser"
#$pass="FPDuser"

try {
    #-------------------- 基本設定
    # ログディレクトリ存在チェック
    $myLogDir = $logDir;

    if (-not (Test-Path $myLogDir)) {
        Write-Host "parameter logDir does not exist";
        throw "parameter logDir does not exist";
    }

    # スクリプトファイル名
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($myInvocation.MyCommand.name);
    # 処理日時
    $now = Get-Date -Format "yyyy-MM-dd_HH-mm-ss";
    # エラーログファイル名
    $errorLogFile = "$myLogDir/error_$($scriptName)_$now.log";
    # 結果ログファイル名
    $outputLogFile = "$myLogDir/result_$($scriptName)_$now.log";
    # 出力リスト
    $outputList = New-Object 'System.Collections.Generic.List[string]';

    #-------------------- 開始処理
    $watch = New-Object System.Diagnostics.StopWatch;
    $watch.Start();

    #-------------------- get data
    Write-Host("get data...");

    $cnnstr = "Data Source=$server;Initial Catalog=$database;User ID=$userId; Password=$pass;";
    $cnn = New-Object -TypeName System.Data.SqlClient.SqlConnection $cnnstr;
    $sql = "SELECT TOP 50
                --d.object_id, d.database_id,
                dd.name DB,
                OBJECT_NAME(object_id, d.database_id) 'proc_name',
                --d.cached_time,
                d.last_execution_time,
                --d.total_elapsed_time*0.00001 total_elapsed_time,
                format(d.total_elapsed_time*0.000001,'###.###') AS exe_total_second,
                format(d.total_elapsed_time*0.000001/d.execution_count,'###.###') AS [exe_avg_second],
                format(d.max_elapsed_time*0.000001,'###.###') exe_max_second ,
                format(d.last_elapsed_time*0.000001,'###.###') exe_last_second ,
                d.execution_count
            FROM sys.dm_exec_procedure_stats AS d
            INNER join sys.databases dd on
                dd.database_id = d.database_id
            ORDER BY d.total_elapsed_time DESC;"

    try {
        $cnn.Open();
        $cmd = $cnn.CreateCommand();
        $cmd.Connection = $cnn;
        $cmd.CommandText = $sql;
        # execute
        $adpter = New-Object -TypeName System.Data.SqlClient.SqlDataAdapter $cmd;
        $ds = New-Object -TypeName System.Data.DataSet;
        $adpter.Fill($ds) | Out-Null;
        $table = $ds.Tables[0];
    }
    catch {
        Write-Host $_.Exception;
        $_.Exception | Format-List -force | Out-File -Encoding default $errorLogFile;
        exit 1;
    }
    finally {
        $cnn.Close();
        $cnn.Dispose();
    }

    #-------------------- doing
    Write-Host("doing...");
    $outputList.Add("DB,proc_name,last_execution_time,exe_total_second,exe_avg_second,exe_max_second,exe_last_second,execution_count");
    foreach ($row in $table.Rows) {
        $DB = $row.item("DB");
        $proc_name = $row.item("proc_name");
        $last_execution_time = $row.item("last_execution_time");
        $exe_total_second = $row.item("exe_total_second");
        $exe_avg_second = $row.item("exe_avg_second");
        $exe_max_second = $row.item("exe_max_second");
        $exe_last_second = $row.item("exe_last_second");
        $execution_count = $row.item("execution_count");    
        $outputList.Add("$DB,$proc_name,$last_execution_time,$exe_total_second,$exe_avg_second,$exe_max_second,$exe_last_second,$execution_count");
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
