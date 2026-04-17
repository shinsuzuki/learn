@echo off
@REM ========================================
@REM APIの動作環境を作成
@REM ========================================
@REM 仮想環境を作成
call init_venv.bat

@REM 仮想環境に切替
call activate_venv.bat

@REM update.exeを更新
call update_pip.bat

@REM パッケージをインストール
call install_dev_package.bat






