@REM 仮想環境を有効化
call .venv\Scripts\activate.bat

@REM srcフォルダを検索パスに追加する
set PYTHONPATH=%PYTHONPATH%;src

@REM appを起動
uvicorn app.main:app --port 8092
