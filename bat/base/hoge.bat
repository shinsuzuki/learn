@echo off

echo start hoge.bat

setlocal

rem __________パラメータ
echo commandName: %0
echo param_1: %1
echo param_2: %2


rem __________SET
set name=john
echo %name%


rem __________goto
goto label_b1

:label_a1
echo label_a1

:label_b1
echo label_b1


rem __________call
rem 呼び出し後に戻ります
call sub_fufu.bat
call sub_koko.bat


rem __________sub routine ※使わないな
@REM call :funcA "abc" "def"
@REM exit /B 0

@REM :funcA
@REM     echo funcA(%1, %2)
@REM     exit /B 0


rem __________start ※使わないかな
@rem 別プロセスで実行させてます
@REM start sub_fufu.bat

@REM rem 同じウィンドウ内でコマンドを実行
@REM rem start /B sub_fufu.bat

@REM rem 別のウィンドウを開きコマンドを実行、終了を待つ
@REM rem start /WAIT sub_fufu.bat

@REM rem ウィンドウを最小化し実行
@REM start /MIN sub_fufu.bat


rem 別プロセスで実行、終了をまたずに次の処理へ
rem start sub_otherprocess_nana.bat

rem 別プロセスで実行、終了を待つ
start /wait sub_otherprocess_nana.bat


rem __________結論
rem コマンドの結果操作はバッチでは行わずPowershellで対応するため、あまり使うことろはないと思います。
rem 必要なら調査し対応します。


echo end hoge.bat
endlocal

