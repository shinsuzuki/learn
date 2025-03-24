@echo off
rem ============================================================================
rem BackupDBFiles.bat: ファイルをバックアップ
rem ============================================================================
echo start BackupDBFiles.bat

rem ========================================
rem ローカル開発フラグ
rem ========================================
rem 開発用フラグ(local:on/server:off)
set local_dev_flag=off;

rem ========================================
rem ウィンドウ最小化
rem ========================================
@if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof

rem ========================================
rem パラメータ設定
rem ========================================
if %local_dev_flag%==on (
    rem ======== ローカル開発の設定
    echo local_job
    rem param:psScriptFile(PSスクリプトファイルをフルパス指定)
    set psScriptFile=C:\dev\script\lds_watch\Backup_DB\BackupDbFiles.ps1
    rem param:logDir(ログ出力ディレクトリをフルパス指定)
    set logDir=C:\dev\script\output\BackupDBFiles\logs
    rem param:targetDir(バックアップの対象とするディレクトリをフルパス指定)
    set targetDir=C:\dev\script\lds_watch\targetdb_data\Backup
    rem param:backupDir(バックアップを出力するディレクトリをフルパス指定)
    set backupDir=C:\dev\script\output\BackupDBFiles\backup
) else (
    rem ======== サーバー稼働の設定
    echo server_job
    rem param:psScriptFile(PSスクリプトファイルをフルパス指定)
    set psScriptFile=D:\dev\suzuki\backup_db\BackupDbFiles.ps1
    rem param:logDir(ログ出力ディレクトリをフルパス指定)
    set logDir=D:\dev\suzuki\backup_db\logs
    rem param:targetDir(バックアップの対象とするディレクトリをフルパス指定)
    set targetDir=D:\dev\suzuki\backup_db\Backup_suzuki_2
    rem param:backupDir(バックアップを出力するディレクトリをフルパス指定)
    set backupDir=\\LDS-ADH-220\ShareTemp\backup_db_test_suzuki\backup_2
)

rem param:backupFileRotateCount(バックアップファイル世代管理数)
set backupFileRotateCount=7

rem param:logFileRotateCount(ログファイル世代管理数)
set logFileRotateCount=20

rem param:targetSqlServerDb(SQLServerのDBリスト)
set targetSqlServerDb=LDS_DB:LDS_PROCESS_DB

rem ========================================
rem script実行
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %psScriptFile% ^
-targetDir '%targetDir%' ^
-targetSqlServerDb '%targetSqlServerDb%' ^
-backupDir '%backupDir%' ^
-backupFileRotateCount '%backupFileRotateCount%' ^
-logDir '%logDir%' ^
-logFileRotateCount '%logFileRotateCount%' ^
;exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end BackupDBFiles.bat
rem exit
rem pause
