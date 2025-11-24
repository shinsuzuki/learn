@echo off
@REM =========================================================
@REM [ 全てのパッケージをインストール ]
@REM =========================================================
echo Batch started (%~nx0)
pip install -r requirements.txt
echo Batch finished (%~nx0)