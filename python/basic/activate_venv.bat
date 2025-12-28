@echo off
set SCRIPT_DIR=%~dp0

:: PowerShellを起動し、以下の順で実行します：
:: 1. 仮想環境の activate.ps1 を呼び出す
:: ※ -NoExit を付けると、処理終了後もPowerShellウィンドウを開いたままにできます。

powershell -NoProfile -ExecutionPolicy Bypass -Command '%SCRIPT_DIR%.venv\Scripts\Activate.ps1'

echo --- 処理が完了しました ---
