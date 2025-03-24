@echo off
rem ============================================================================
rem CheckDiskUsage.bat: Disk容量をチェック
rem ============================================================================

echo start CheckDiskUsage.bat

rem ========================================
rem ウィンドウ最小化
rem ========================================
rem @if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof

rem ========================================
rem パラメータ設定
rem ========================================
rem param:logDir(ログ出力ディレクトリをフルパス指定)
set logDir=C:\Users\Administrator\Desktop\suzuki_dev\logs

rem param:psScriptFile(PSスクリプトファイルをフルパス指定))
set psScriptFile=C:\Users\Administrator\Desktop\suzuki_dev\CheckDiskUsage.ps1

rem param:targetServers([コンピュータ名:ユーザー名:パスワードファイルパス]をカンマ区切りで指定)
set targetServers=^
LDS-GWH-221:Administrator:.\pass\pwd_LDS-GWH-221.dat,^
LDS-APH-222:Administrator:.\pass\pwd_LDS-APH-222.dat,^
LDS-DBH-223:Administrator:.\pass\pwd_LDS-DBH-223.dat

rem ========================================
rem script実行
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %psScriptFile% -logDir '%logDir%' -targetServers '%targetServers%'; exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end CheckDiskUsage.bat
rem exit
rem pause
