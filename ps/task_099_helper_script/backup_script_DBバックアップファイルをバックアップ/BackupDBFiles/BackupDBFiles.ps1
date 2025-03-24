#-------------------------------------------------------------------------------
# BackupDBFiles.ps1: DBファイルをバックアップ
#-------------------------------------------------------------------------------
Param(
    [parameter(mandatory)][String]$targetDir,
    [parameter(mandatory)][String]$targetSqlServerDb,
    [parameter(mandatory)][String]$backupDir,
    [parameter(mandatory)][int]$backupFileRotateCount,
    [parameter(mandatory)][String]$logDir,
    [parameter(mandatory)][int]$logFileRotateCount
)

# エラー設定
$ErrorActionPreference = "Stop";

# 7-zipの処理経過を画面に表示し、ログに出力しない(開発中は$true、本番は$falseを指定)
$isDisplay7zipInfoAndNolog = $false;

#-------------------------------------------------
# メッセージ出力
#-------------------------------------------------
function WriteFile {
    param (
        $msg
    )

    $now = Get-Date -Format "yyyy/MM/dd HH:mm:ss";
    $outputMessage = "$($now),$msg";
    Write-Host $outputMessage;
    Add-Content -Path $Const.LogFile -Value $outputMessage -Encoding default;
}

#-------------------------------------------------
# エラー出力
#-------------------------------------------------
function WriteErrorFile {
    param (
        $msg
    )

    $now = Get-Date -Format "yyyy/MM/dd HH:mm:ss";
    $outputMessage = "$($now),$msg";
    Add-Content -Path $Const.ErrorLogFile -Value $outputMessage -Encoding default;
}

#-------------------------------------------------
# ディレクトリの存在チェック
#-------------------------------------------------
function CheckExistDir {
    param (
        $pDir
    )

    if (-not (Test-Path $pDir)) {
        Write-Host "dir [$pDir] does not exist"
        throw "dir [$pDir] does not exist"
    }

    return $true;
}

#-------------------------------------------------
# ディレクトリを移動
#-------------------------------------------------
function MoveDir {
    param (
        $pWorkDir, $pBackupDir
    )

    # <robocopy options>
    # /S :サブディレクトリをコピーしますが、空のディレクトリはコピーしません
    # /J :バッファーなし I/O を使用してコピーします (大きなファイルで推奨)
    # /MOVE: フォルダ構造全体を移動
    # /R :リトライ回数:2
    # /W :リトライ待ち時間:10秒
    # /Z :前回のコピーが完全に終了していなければ、その続きからコピーが開始される
    # <memo>
    # ファイル名が同じでも、更新日付が異なるファイル（新しいファイルだけではなく、コピー元の方が古くてもコピー対象となる）上書き
    robocopy $pWorkDir $pBackupDir /MOVE /S /J /R:2 /W:10 /Z /LOG+:$($Const.LogFile) | Out-Null
    WriteFile "robocopy result:[$lastexitcode]"

    # robocopyの終了コードが8以上のときはエラー
    # https://docs.microsoft.com/ja-jp/troubleshoot/windows-server/backup-and-storage/return-codes-used-robocopy-utility
    if ($lastexitcode -ge 8) {
        throw "robocopy error:[$lastexitcode]"
    }
}

#-------------------------------------------------
# 作業ディレクトリを作成
#-------------------------------------------------
function CreateWorkDir {
    param (
        $pTargetDir, $pWorkSqlServerDir, $pTargetSqlServerDb, $pWorkPostgreSqlDir
    )

    # create working dir
    WriteFile "create working dir:$workDir";
    New-Item -ItemType Directory -Path $workDir | Out-Null;

    # create working sql server dir
    WriteFile "create working sqlserver base dir:$pWorkSqlServerDir";
    New-Item -ItemType Directory -Path $pWorkSqlServerDir | Out-Null;

    foreach ($sqlServerDb in $pTargetSqlServerDb -split ":") {
        $makeSqlServerDbDir = Join-Path $pWorkSqlServerDir $sqlServerDb;
        WriteFile "create working sqlserver db dir:$makeSqlServerDbDir";
        New-Item -ItemType Directory $makeSqlServerDbDir | Out-Null;
    }

    # create working postgre sql dir
    WriteFile "create working postgresql base dir:$pWorkPostgreSqlDir";
    New-Item -ItemType Directory -Path $pWorkPostgreSqlDir | Out-Null;
    $targetPostgreSqlBaseDir = Join-Path $pTargetDir $Const.PostgreSqlDir;

    if (Test-Path $targetPostgreSqlBaseDir) {
        $targetPostgreSqlDirList = Get-ChildItem -Path $targetPostgreSqlBaseDir | `
            Where-Object { ($_.Attributes -eq "Directory") -and ($_.Name -match "^\d{8}_\d{6}$") };

        foreach ($postgreSqlDir in $targetPostgreSqlDirList) {
            $postgreSqlDirLeaf = Split-Path $postgreSqlDir -leaf;
            $makePostgreSqlDir = Join-Path $pWorkPostgreSqlDir $postgreSqlDirLeaf;

            WriteFile "create working postgresql db:$makePostgreSqlDir";
            New-Item -ItemType Directory $makePostgreSqlDir | Out-Null;
        }
    }

}

#-------------------------------------------------
# ファイルを削除
#-------------------------------------------------
function DeleteFileList {
    param (
        $pDeleteFileList
    )

    foreach ($file in $pDeleteFileList) {
        if (Test-Path $file.FullName) {
            WriteFile ("delete file:[$($file.FullName)]");
            Remove-Item $file.FullName -Force;
        }
    }
}

#-------------------------------------------------
# ディレクトリを削除
#-------------------------------------------------
function DeleteDir {
    param (
        $pDeleteDir
    )

    if ($null -eq $workDir) {
        WriteFile ("delete dir:[null]");
    }
    else {
        if (Test-Path $pDeleteDir) {
            WriteFile ("delete dir:[$pDeleteDir]");
            Remove-Item -Path $pDeleteDir -Recurse -Force;
        }
        else {
            WriteFile ("delete dir:[none]");
        }
    }
}

#-------------------------------------------------
# ディレクトリリストを削除
#-------------------------------------------------
function DeleteDirList {
    param (
        $pDeleteDirList
    )

    foreach ($dir in $pDeleteDirList) {
        DeleteDir($dir);
    }
}

#-------------------------------------------------
# 移動するファイルを取得
#-------------------------------------------------
function GetMoveFileList {
    param (
        $pTargetDir, $pSqlServerDir, $pTargetSqlServerDb, $pPostgreSqlDir
    )

    # SQLServerDB用のファイルパスを取得
    $sqlServerTargetFileList = @();
    $dbList = $pTargetSqlServerDb -split ":";
    $sqlServerTargetDir = Join-Path $pTargetDir $pSqlServerDir;

    foreach ($db in $dbList) {
        $dbDir = Join-Path $sqlServerTargetDir $db;
        if (Test-Path $dbDir) {
            $sqlServerTargetFileList += Get-ChildItem -File -Path $dbDir | Where-Object { $_.Extension -in ".bak", ".trn" };
        }
    }

    $sqlServerTargetFileList | ForEach-object { WriteFile $_.FullName };


    # PostgreSQL用のファイルパスを取得
    $postgreSqlFileList = @();
    $postgreSqlsTargetDir = Join-Path $pTargetDir $pPostgreSqlDir;

    if (Test-Path $postgreSqlsTargetDir) {
        $postgreSqlDirList = Get-ChildItem -Path $postgreSqlsTargetDir | `
            Where-Object { ($_.Attributes -eq "Directory") -and ($_.Name -match "^\d{8}_\d{6}$") };

        foreach ($postgreSqlDir in $postgreSqlDirList) {
            $postgreSqlFileList += Get-ChildItem -file -recurse -path $postgreSqlDir.FullName | Where-Object { $_.Extension -in ".dmp" };
        }

        $postgreSqlFileList | ForEach-object { WriteFile $_.FullName };
    }

    return $sqlServerTargetFileList, $postgreSqlFileList;
}

#-------------------------------------------------
# ファイルを圧縮
#-------------------------------------------------
function CompressFile {
    param (
        $pWorkSqlServerDir, $pWorkPostgreSqlDir, $pSqlServerTargetFileList, $pPostgreSqlFileList
    )

    # sql server
    foreach ($targetFile in $pSqlServerTargetFileList) {
        $parentDirName = Split-Path -Path (Split-Path $targetFile.FullName -Parent) -leaf;
        $tmpSqlDbDir = Join-Path $pWorkSqlServerDir $parentDirName;
        $inputFile = $targetFile.FullName;
        $fileName = (Split-Path $inputFile -Leaf) + ".zip";
        $outputFile = Join-Path $tmpSqlDbDir $fileName;
        WriteFile "input:$inputFile";
        WriteFile "output:$outputFile";

        if ($isDisplay7zipInfoAndNolog) {
            # 圧縮の進捗を画面に出力、ログには出力しない
            .\7-Zip\7z.exe a "$outputFile" "$inputFile";
        }
        else {
            # 標準出力をログに出力
            .\7-Zip\7z.exe a "$outputFile" "$inputFile" | Out-File -Append -Encoding default $Const.LogFile;
        }

        WriteFile "7zip result:[$lastexitcode]";
        # 7zipの終了コードが0以外のときはエラー
        # https://sevenzip.osdn.jp/chm/cmdline/exit_codes.htm
        if ($lastexitcode -ne 0) {
            throw "7zip error:[$lastexitcode]";
        }
    }

    # postgre sql
    foreach ($posgreSqlFile in $pPostgreSqlFileList) {
        $parentDirName = Split-Path -Path (Split-Path $posgreSqlFile.FullName -Parent) -leaf;
        $tmpSqlDbDir = Join-Path  $pWorkPostgreSqlDir  $parentDirName;
        $inputFile = $posgreSqlFile.FullName;
        $fileName = (Split-Path $inputFile -Leaf) + ".zip";
        $outputFile = Join-Path $tmpSqlDbDir $fileName;
        WriteFile "input:$inputFile";
        WriteFile "output:$outputFile";

        if ($isDisplay7zipInfoAndNolog) {
            # 圧縮の進捗を画面に出力、ログには出力しない
            .\7-Zip\7z.exe a  "$outputFile" "$inputFile";
        }
        else {
            # 標準出力をログに出力
            .\7-Zip\7z.exe a  "$outputFile" "$inputFile" | Out-File -Append -Encoding default $Const.LogFile;
        }

        WriteFile "7zip result:[$lastexitcode]";
        #--------------------------------------------------
        # https://sevenzip.osdn.jp/chm/cmdline/exit_codes.htm
        #--------------------------------------------------
        # 0 =エラーなし。
        # 1 =警告（致命的でないエラー）。たとえば、1つ以上のファイルが他のアプリケーションによってロックされているため、圧縮されていません。
        # 2 =致命的なエラー。
        # 7 =コマンドラインエラー。
        # 8 =操作に十分なメモリがありません。
        # 255 =ユーザーがプロセスを停止しました。
        #--------------------------------------------------
        # 7zipの終了コードが0以外のときはエラー
        if ($lastexitcode -ne 0) {
            throw "7zip error code:[$lastexitcode]";
        }
    }
}

#-------------------------------------------------
# バックアップファイルの世代管理処理
#-------------------------------------------------
function ManagementBackupFileGeneration {
    param (
        $pBackupDir, $pSqlServerDir, $pPostgreSqlDir, $pTargetSqlServerDb, $pBackupFileRotateCount
    )

    # sqlserver バックアップファイルの世代管理
    $dbList = $pTargetSqlServerDb -split ":";

    foreach ($db in $dbList) {
        $sqlServerDir = Join-Path (Join-Path $pBackupDir $pSqlServerDir) $db;

        if (Test-Path $sqlServerDir) {
            # 拡張子 [.trn.zip] 対応
            Get-ChildItem -Path $sqlServerDir  | `
                Where-Object { $_.Name -match "\.trn\.zip$" } | `
                Sort-Object -Property Name -Descending | `
                Select-Object -Skip $pBackupFileRotateCount | `
                ForEach-Object {
                WriteFile ("delete file:[$($_.FullName)]");
                Remove-Item $_.FullName -Recurse -Force
            };

            # 拡張子 [.bak.zip] 対応
            Get-ChildItem -Path $sqlServerDir | `
                Where-Object { $_.Name -match "\.bak\.zip$" } | `
                Sort-Object -Property Name -Descending | `
                Select-Object -Skip $pBackupFileRotateCount | `
                ForEach-Object {
                WriteFile ("delete file:[$($_.FullName)]");
                Remove-Item $_.FullName -Recurse -Force
            };
        }

    }

    # postgre sql バックアップファイルの世代管理
    $postgreSqlDir = Join-Path $pBackupDir $pPostgreSqlDir;

    if (Test-Path $postgreSqlDir) {
        Get-ChildItem -Path $postgreSqlDir -Directory | `
            Sort-Object -Property Name -Descending | `
            Select-Object -Skip $pBackupFileRotateCount | `
            ForEach-Object {
            WriteFile ("delete dir:[$($_.FullName)]");
            Remove-Item $_.FullName -Recurse -Force
        };
    }
}

#-------------------------------------------------
# ログファイルの世代処理
#-------------------------------------------------
function ManagementLogFileGeneration {
    param (
        $pLogDir, $pLogFileRotateCount
    )

    # errorログは対象外
    Get-ChildItem -Path $pLogDir | `
        Where-Object { $_.Name -notmatch "error" } | `
        Where-Object { $_.Name -match (GetScriptName) } | `
        Where-Object { $_.Extension -match ".log$" } | `
        Sort-Object -Property Name -Descending | `
        Select-Object -Skip $pLogFileRotateCount | `
        ForEach-Object {
        WriteFile ("delete file:[$($_.FullName)]");
        Remove-Item $_.FullName -Recurse -Force;
    };
}

#-------------------------------------------------
# スクリプト名を取得
#-------------------------------------------------
function GetScriptName {
    $script_name = Split-Path -Leaf $PSCommandPath;
    return [System.IO.Path]::GetFileNameWithoutExtension($script_name);
}


#-------------------------------------------------------------------------------
# スクリプト開始
#-------------------------------------------------------------------------------
try {
    # ログディレクトリの存在チェック
    CheckExistDir $logDir | Out-Null;

    # 定数
    $now = Get-Date -Format "yyyy-MM-dd_HH-mm-ss";
    $Const = @{
        # ログファイル名
        LogFile       = "$logDir\result_$(GetScriptName)_$($now).log";
        # エラーログファイル名
        ErrorLogFile  = "$logDir\error_$(GetScriptName)_$($now).log";
        # バックアプ先のSQLServerフォルダ名
        SqlServerDir  = "Microsoft` SQL` Server";
        # バックアプ先のPostgreSQLフォルダ名
        PostgreSqlDir = "PostgreSQL";
    }

    # バックアップ対象とバックアップ先ディレクトリの存在チェック
    CheckExistDir $targetDir | Out-Null;
    CheckExistDir $backupDir | Out-Null;

    #-------------------------------------------------
    # 開始処理
    #-------------------------------------------------
    $watch = New-Object System.Diagnostics.StopWatch;
    $watch.Start();
    WriteFile "start >> ";
    WriteFile "param:targetDir:$targetDir";
    WriteFile "param:targetSqlServerDb:$targetSqlServerDb";
    WriteFile "param:backupDir:$backupDir";
    WriteFile "param:backupFileRotateCount:$backupFileRotateCount";
    WriteFile "param:logDir:$logDir"
    WriteFile "param:logFileRotateCount:$logFileRotateCount";

    #-------------------------------------------------
    # 作業用フォルダを作成
    #-------------------------------------------------
    WriteFile "create working dir start >>";

    $guidDir = "nci_bat_$(GetScriptName)_" + $([System.Guid]::NewGuid().Guid);
    $workDir = $env:TEMP | Join-Path -ChildPath $guidDir;
    $workSqlServerDir = Join-Path $workDir $Const.SqlServerDir;
    $workPostgreSqlDir = Join-Path $workDir $Const.PostgreSqlDir;

    CreateWorkDir `
        -pTargetDir $targetDir `
        -pWorkSqlServerDir $workSqlServerDir `
        -pTargetSqlServerDb $targetSqlServerDb `
        -pWorkPostgreSqlDir $workPostgreSqlDir;

    WriteFile "create working dir end <<";

    #-------------------------------------------------
    # 移動するファイル一覧を取得
    #-------------------------------------------------
    WriteFile "get move file start >>";

    $r = GetMoveFileList `
        -pTargetDir $targetDir `
        -pSqlServerDir $Const.SqlServerDir `
        -pTargetSqlServerDb $targetSqlServerDb `
        -pPostgreSqlDir $Const.PostgreSqlDir

    $sqlServerTargetFileList = $r[0];
    $postgreSqlFileList = $r[1];

    WriteFile "get move file end <<";

    #-------------------------------------------------
    # 圧縮
    #-------------------------------------------------
    WriteFile "compress start >>";

    CompressFile `
        -pWorkSqlServerDir $workSqlServerDir `
        -pWorkPostgreSqlDir $workPostgreSqlDir `
        -pSqlServerTargetFileList $sqlServerTargetFileList `
        -pPostgreSqlFileList $postgreSqlFileList;

    WriteFile "compress end <<";

    #-------------------------------------------------
    # ディレクトリ移動
    #-------------------------------------------------
    WriteFile "move dir start >>";

    MoveDir `
        -pWorkDir $workDir `
        -pBackupDir $backupDir;

    WriteFile "move dir end <<";

    #-------------------------------------------------
    # バックアップファイルの世代管理処理
    #-------------------------------------------------
    WriteFile "backup file generation management start >>";

    ManagementBackupFileGeneration `
        -pBackupDir $backupDir `
        -pSqlServerDir $Const.SqlServerDir `
        -pPostgreSqlDir $Const.PostgreSqlDir `
        -pTargetSqlServerDb $targetSqlServerDb `
        -pBackupFileRotateCount $backupFileRotateCount;

    WriteFile "backup file generation management end <<";

    #-------------------------------------------------
    # バックアップ対象を削除
    #-------------------------------------------------
    WriteFile "delete backup target start >>";

    # sql server
    WriteFile "delete sql server start >>";
    DeleteFileList -pDeleteFileList $sqlServerTargetFileList;
    WriteFile "delete sql server end <<";

    # postgre sql
    WriteFile "delete postgre sql start >>";
    $postgreSqlDirList = $postgreSqlFileList | ForEach-Object { Split-Path $_.FullName -Parent };
    DeleteDirList -pDeleteDirList $postgreSqlDirList;
    WriteFile "delete postgre sql end <<";

    WriteFile "delete backup target end <<";

    #-------------------------------------------------
    # ログファイルの世代管理
    #-------------------------------------------------
    WriteFile "log file generation management start >>";

    ManagementLogFileGeneration `
        -pLogDir $logDir `
        -pLogFileRotateCount $logFileRotateCount;

    WriteFile "log file generation management end <<";

    #-------------------------------------------------
    # 終了処理
    #-------------------------------------------------
    $watch.Stop();
    $t = $watch.Elapsed;
    WriteFile "========================================";
    WriteFile "[done]";
    WriteFile ("execution time:" + ($t.TotalSeconds.ToString("0.00")) + " sec");
    WriteFile "========================================";
    WriteFile "end << ";
    exit 0;
}
catch {
    WriteFile "========================================";
    WriteFile "[error]";
    WriteFile $_.Exception;
    WriteFile "========================================";
    # 作業用フォルダを削除
    WriteFile "delete working dir start >>";
    DeleteDir -pDeleteDir $workDir;
    WriteFile "delete working dir end <<";
    WriteFile "end << ";
    # エラーログを出力
    WriteErrorFile $_.Exception;
    exit 1;
}
