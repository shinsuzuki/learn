@echo off
@REM =========================================================
@REM [ 全てのパッケージ情報をリストアップ ]
@REM =========================================================
echo Batch started (%~nx0)
pip freeze > requirements.txt
echo Batch finished (%~nx0)