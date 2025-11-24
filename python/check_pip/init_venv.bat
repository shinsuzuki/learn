@echo off
@REM =========================================================
@REM [ 仮想環境初期化  ]
@REM =========================================================
echo Batch started (%~nx0)
py -3.12 -m venv venv
echo Batch finished (%~nx0)