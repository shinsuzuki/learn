@REM コンソールで appフォルダの上の階層にstart_app.batを配置して実行する
@REM 開発時は　PYTHONPATHに srcフォルダを設定して対応している

@REM 仮想環境を有効化
call .venv\Scripts\activate.bat

@REM srcフォルダを検索パスに追加する
@REM set PYTHONPATH=%PYTHONPATH%;src

@REM app.mainをモジュールとして実行
python -m app.main
