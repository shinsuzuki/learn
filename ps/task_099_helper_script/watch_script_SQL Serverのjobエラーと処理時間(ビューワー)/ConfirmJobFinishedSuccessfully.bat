@echo off
rem ============================================================================
rem ConfirmJobFinishedSuccessfully.bat: 正常に処理が終了しているかを確認(SQL Serverのjobエラーと処理時間 > 経路 )
rem ============================================================================

echo start ConfirmJobFinishedSuccessfully.bat

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
set psScriptFile=C:\dev\script\lds_watch\ConfirmJobFinishedSuccessfully.ps1

rem param:server(サーバーを指定)
set server=ap-yok1203\LDS

rem param:database(データベースを指定)
set database=msdb

rem param:userId(ユーザーIDを指定)
set userId=fpduser

rem param:pass(パスワードを指定)
set pass=FPDuser

rem param:jobName
set jobName=LDS_VIEWER_MIGRATION

rem param:targetDate(起動する年月日を指定)
set command=`powershell "[DateTime]::Today.ToString('yyyy/MM/dd')"`
FOR /F "usebackq delims=" %%t IN (%command%) DO set targetDate=%%t
rem ★指定日をチェックする場合はtargetDateを書き換える
rem set targetDate=2021/01/18

rem param:targertStrStep[1-3]("ストアド名 END(0)" が含まれていると正常終了とする)
set targertStrStep1=PRC_MIGRATION_MASTER_MAIN END(0)
set targertStrStep2=PRC_TRENDVIEWER_MAIN END(0)
set targertStrStep3=PRC_CORRECTION_EVENT_MAIN END(0)

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
    -targetDate %targetDate% ^
    -targertStrStep1 '%targertStrStep1%' ^
    -targertStrStep2 '%targertStrStep2%' ^
    -targertStrStep3 '%targertStrStep3%'; ^
    exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end ConfirmJobFinishedSuccessfully.bat
rem exit
