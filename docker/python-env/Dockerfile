# 軽量なPythonイメージを使用
FROM python:3.11-slim

# コンテナ内の作業ディレクトリを設定
WORKDIR /app

# Windows側のrequirements.txtをコピーしてライブラリをインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# その他のファイルはdocker-composeのvolumesで同期されるため、COPYは不要