@echo off
echo off
echo start start_script.bat

rem ========================================
rem [script 実行]
rem ========================================
powershell -NoProfile -ExecutionPolicy Unrestricted %~dp0sample.ps1; exit $LASTEXITCODE;

rem ========================================
rem [script exit]
rem ========================================
echo ps_errorlevel:%ERRORLEVEL%
echo end start_script.bat


