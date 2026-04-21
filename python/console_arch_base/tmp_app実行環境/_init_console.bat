@echo off
@REM ========================================
@REM コンソールの初期環境構築バッチ
@REM ========================================

@echo off
echo [Start] Creating Console Environment...

REM 仮想環境(.venv)の作成（もしなければ）
if not exist .venv (
    echo Creating virtual environment...
    py -3.12 -m venv .venv
)

REM 仮想環境を有効化,pipを更新
echo Installing packages...
call .venv\Scripts\activate
python -m pip install --upgrade pip

REM requirements.txtの作成（現在の構成を保存）
@REM pip freeze > requirements.txt

echo [Success] Console environment is ready!
pause