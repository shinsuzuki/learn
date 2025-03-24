@echo off
rem ============================================================================
rem ELTool_ExtractAlert.bat: アラートを抽出
rem ============================================================================

echo start ELTool_ExtractAlert.bat

rem ========================================
rem ウィンドウ最小化
rem ========================================
@if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof

rem ========================================
rem パラメータ設定
rem ========================================
rem param:startTime(起動する月日の15時間前を指定)
set command=`powershell "[DateTime]::Today.AddHours(-15).ToString('yyyy/MM/dd HH:mm:ss')"`
FOR /F "usebackq delims=" %%s IN (%command%) DO set startTime=%%s

rem param:endTime(起動する月日の8時間45分後を指定)
set command=`powershell "[DateTime]::Today.AddHours(8).AddMinutes(45).ToString('yyyy/MM/dd HH:mm:ss')"`
FOR /F "usebackq delims=" %%e IN (%command%) DO set endTime=%%e

rem param:logDir(ログ出力ディレクトリをフルパス指定)
set logDir=D:\NikonLDS\Maintenance\ErrorCheck\log

rem param:psScriptFile(PSスクリプトファイルをフルパス指定))
set psScriptFile=D:\NikonLDS\Maintenance\ErrorCheck\ELTool_ExtractAlert.ps1

rem ★指定期間をチェックする場合はFromToを書き換える
rem set startTime=2021/11/04 10:00:00
rem set endTime=2021/11/04 11:00:00

rem ========================================
rem script実行
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %psScriptFile% -startTime '%startTime%' -endTime '%endTime%' -logDir '%logDir%'; exit $lastexitcode;

rem ========================================
rem exit
rem ========================================
echo ps_errorlevel:%errorlevel%
echo end ELTool_ExtractAlert.bat
rem exit
pause
