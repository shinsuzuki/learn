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
    $sql = "SELECT
                OBJ.name AS TableName,
                IND.rows
            FROM
                sys.objects AS OBJ
                JOIN
                    sys.sysindexes AS IND
                ON  OBJ.object_id = IND.id
                AND IND.indid < 2
            WHERE
                OBJ.type = 'U'
            ORDER BY
                OBJ.name;"

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
    foreach ($row in $table.Rows) {
        $tableName = $row.item("TableName");
        $rows = $row.item("rows");
        #Write-Host "$tableName,$rows";
        $outputList.Add("$tableName,$rows");
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
