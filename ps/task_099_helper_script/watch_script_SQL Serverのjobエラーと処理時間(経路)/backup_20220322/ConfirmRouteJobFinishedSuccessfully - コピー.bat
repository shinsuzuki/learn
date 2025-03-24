@echo off
rem ============================================================================
rem ConfirmRouteJobFinishedSuccessfully.bat: 経路のジョブの正常終了を確認
rem ============================================================================

echo start ConfirmRouteJobFinishedSuccessfully.bat

rem ========================================
rem ウィンドウ最小化
rem ========================================
rem @if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof

rem ========================================
rem パラメータ設定
rem ========================================
rem param:logDir(ログ出力ディレクトリをフルパス指定)
set logDir=C:\dev\logs\watch

rem param:psScriptFile(PSスクリプトファイルをフルパス指定))
set psScriptFile=C:\dev\script\lds_watch\ConfirmRouteJobFinishedSuccessfully.ps1

rem param:server(サーバーを指定)
set server=ap-yok1203\LDS

rem param:database(データベースを指定)
set database=msdb

rem param:userId(ユーザーIDを指定)
set userId=fpduser

rem param:pass(パスワードを指定)
set pass=FPDuser

rem param:jobName
set jobName=LDS-PROCESS_DB_REORGANIZE_INDEX

rem param:targetDate(起動する年月日を指定)
set command=`powershell "[DateTime]::Today.ToString('yyyy/MM/dd')"`
FOR /F "usebackq delims=" %%t IN (%command%) DO set targetDate=%%t
rem ★指定日をチェックする場合はtargetDateを書き換える
rem todo test data
rem set targetDate=2021/01/18

rem ========================================
rem script実行
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %psScriptFile% ^
    -logDir '%logDir%' ^
    -server %server% ^
    -database %database% ^
    -userId %userID% ^
    -pass %pass% ^
    -jobName %jobName% ^
    -targetDate %targetDate%; ^
    exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end ConfirmRouteJobFinishedSuccessfully.bat
rem exit
