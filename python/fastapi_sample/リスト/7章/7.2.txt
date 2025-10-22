from pydantic import BaseModel

# カテゴリのスキーマ
class Category(BaseModel):
    # カテゴリID
    category_id: int
    # カテゴリ名
    category_name: str