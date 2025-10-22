from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import ValidationError
from routers.memo import router as memo_router

# ==================================================
# 起動ファイル
# ==================================================
app = FastAPI()

# CORS設定
app.add_middleware(
    CORSMiddleware,
    # 許可するオリジンを指定
    allow_origins=["http://127.0.0.1:5500"],
    # 認証情報を含むリクエストを許可
    allow_credentials=True,
    # 許可するHTTPメソッドを指定
    allow_methods=["*"],
    # 許可するHTTPヘッダーを指定
    allow_headers=["*"],
)

# ルーターのマウント
app.include_router(memo_router)

# バリデーションエラーのカスタムハンドラ
@app.exception_handler(ValidationError)
async def validation_exception_handler(exc: ValidationError):
    # ValidationErrorが発生した場合にクライアントに返すレスポンス定義
    return JSONResponse(
        # ステータスコード422
        status_code=422,
        # エラーの詳細
        content={
        # Pydanticが提供するエラーのリスト
        "detail": exc.errors(),
        # バリデーションエラーが発生した時の入力データ
        "body": exc.model
    }
)