@echo off

call :funcA "strA" 1
call :funcB "strB" 2
exit /b 0

:funcA
  echo funcA: %1, %2
  exit /b 0

:funcB
  echo funcB: %1, %2
  exit /b 0

