from pydantic import BaseModel

# 書籍の作成と更新に使用するスキーマ
class BookSchema(BaseModel):
    # タイトル
    title: str
    # カテゴリ
    category: str
    
# レスポンス用のスキーマには
# 書籍スキーマを継承してidも含める
class BookResponseSchema(BookSchema):
    # ID
    id: int