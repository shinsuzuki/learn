@REM 仮想環境を有効化
call .venv\Scripts\activate.bat

@REM srcフォルダを検索パスに追加する
set PYTHONPATH=%PYTHONPATH%;src

@REM app.mainをモジュールとして実行
python -m app.main

