@echo off
@REM ========================================
@REM FastAPIの初期環境構築バッチ
@REM ========================================

@echo off
echo [Start] Creating FastAPI Environment...

REM 仮想環境(.venv)の作成（もしなければ）
if not exist .venv (
    echo Creating virtual environment...
    py -3.12 -m venv .venv
)

REM 仮想環境を有効化してインストール
echo Installing packages...
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install fastapi uvicorn[standard]

REM requirements.txtの作成（現在の構成を保存）
pip freeze > requirements.txt

echo [Success] FastAPI environment is ready!
pause