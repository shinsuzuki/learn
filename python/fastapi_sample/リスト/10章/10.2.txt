from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import ValidationError
from schemas.memo import InsertAndUpdateMemoSchema, MemoSchema, ResponseSchema

# ==================================================
# 起動ファイル
# ==================================================
app = FastAPI()

# ==================================================
# メモ用のエンドポイント
# ==================================================
# メモ新規登録
@app.post("/memos", response_model=ResponseSchema)
async def create_memo(memo: InsertAndUpdateMemoSchema):
    print(memo)
    return ResponseSchema(message="メモが正常に登録されました")

# メモ情報全件取得
@app.get("/memos", response_model=list[MemoSchema])
async def get_memos_list():
    return [
        MemoSchema(title="タイトル1", description="詳細1", memo_id=1),
        MemoSchema(title="タイトル2", description="詳細2", memo_id=2),
        MemoSchema(title="タイトル3", description="詳細3", memo_id=3)
    ]

# 特定のメモ情報取得
@app.get("/memos/{memo_id}", response_model=MemoSchema)
async def get_memo_detail(memo_id: int):
    return MemoSchema(title="タイトル1", description="詳細1", memo_id=memo_id)

# 特定のメモを更新する
@app.put("/memos/{memo_id}", response_model=ResponseSchema)
async def modify_memo(memo_id: int, memo: InsertAndUpdateMemoSchema):
    print(memo_id, memo)
    return ResponseSchema(message="メモが正常に更新されました")

# 特定のメモを削除する
@app.delete("/memos/{memo_id}", response_model=ResponseSchema)
async def remove_memo(memo_id: int):
    print(memo_id)
    return ResponseSchema(message="メモが正常に削除されました")

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