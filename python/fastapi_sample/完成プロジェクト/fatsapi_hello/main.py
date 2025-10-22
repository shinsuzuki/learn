# 必要なライブラリをインポート
from fastapi import FastAPI

# FastAPIのインスタンスを作成
app = FastAPI()

# GETかつエンドポイント「'/'」で呼ばれる関数
@app.get("/")
async def get_hello():
    return {"message": "Hello World"}