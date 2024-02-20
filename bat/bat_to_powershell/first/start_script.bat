@echo off

rem bat-file to powershell

echo bat start
echo.

powershell -NoProfile -ExecutionPolicy Unrestricted ./main.ps1 "aaa" "bbb"

echo.
echo bat finish! press any key to exit...
pause > nul
