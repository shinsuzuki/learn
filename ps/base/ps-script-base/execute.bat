rem <execute.bat>
echo off
echo start execute.bat

rem ========================================
rem [script 実行]
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %~dp0MySample.ps1; exit $lastexitcode;

rem ========================================
rem [script exit]
rem ========================================
echo ps_errorlevel:%errlrlevel%
echo end execute.bat
rem exit
pause