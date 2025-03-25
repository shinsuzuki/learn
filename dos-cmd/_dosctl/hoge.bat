@echo off
echo start hoge.bat

rem ______________________________
setlocal

set val_num=100
set val_name=kato
echo %val_num%
echo %val_name%

if exist dir_a (echo "dir_a exist") else (echo "dir_a not exist")

IF EXIST dir_a ( echo "dir_a exist")

rem ______________________________
endlocal