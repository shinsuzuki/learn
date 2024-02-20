@echo off

rem __________ today
FOR /F "usebackq delims=" %%a in (`powershell "(get-date).ToString(\"yyyy/MM/dd\")"`) do Set TODAY=%%a
echo today: %TODAY%

@REM > __result
@REM today: 2024/02/20


rem __________ today-9h
setlocal
set command=`powershell "[DateTime]::Today.AddHours(9).ToString('yyyy-MM-dd HH:mm:ss')"`
FOR /F "usebackq delims=" %%A IN (%command%) DO set today9=%%A
echo today-9: %today9%

@REM > __result
@REM today-9: 2024-02-20 09:00:00