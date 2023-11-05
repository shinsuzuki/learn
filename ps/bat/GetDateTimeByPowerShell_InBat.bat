@echo off

rem 本日
FOR /F "usebackq delims=" %%a in (`powershell "(get-date).ToString(\"yyyy/MM/dd\")"`) do Set TODAY=%%a
echo %TODAY%

rem 本日9時
setlocal
set command=`powershell "[DateTime]::Today.AddHours(9).ToString('yyyy-MM-dd HH:mm:ss')"`
FOR /F "usebackq delims=" %%A IN (%command%) DO set today9=%%A
echo %today9%