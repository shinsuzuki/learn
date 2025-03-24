@echo off
rem ============================================================================
rem ConfirmIncreaseNumberOfImports.bat: 取り込み件数の増加量確認
rem ============================================================================

echo start ConfirmIncreaseNumberOfImports.bat

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
set psScriptFile=C:\dev\script\lds_watch\ConfirmIncreaseNumberOfImports.ps1

rem param:server(サーバーを指定)
set server=ap-yok1203\LDS

rem param:database(データベースを指定)
set database=LDS_DB_VIEWER

rem param:userId(ユーザーIDを指定)
set userId=fpduser

rem param:pass(パスワードを指定)
set pass=FPDuser

rem ========================================
rem script実行
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %psScriptFile% -logDir '%logDir%' -server %server% -database %database% -userId %userID% -pass %pass%; exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end ConfirmIncreaseNumberOfImports.bat
rem exit
