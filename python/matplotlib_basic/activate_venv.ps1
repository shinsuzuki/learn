# 1. スクリプトの場所を基準にパスを構成する
# $PSScriptRoot はこのスクリプトが存在するディレクトリを指します
$VenvActivate = Join-Path $PSScriptRoot ".venv\Scripts\Activate.ps1"

# 2. ドットソーシングによる実行
# 先頭に「. 」（ドットとスペース）を付けることで、
# 呼び出し先スクリプト内の設定（仮想環境の有効化）を現在のセッションに反映させます。
if (Test-Path $VenvActivate) {
    . $VenvActivate
    Write-Host "Virtual environment has been activated." -ForegroundColor Cyan

    # 3. 仮想環境が有効な状態でPythonを実行
    Write-Host "$(python -V)"
}
else {
    Write-Error "Could not find Activate.ps1 at: $VenvActivate"
}
