@echo off
@REM =========================================================
@REM [ pip.exeを更新  ]
@REM =========================================================
echo Batch started (%~nx0)
python -m pip install --upgrade pip
echo Batch finished (%~nx0)
