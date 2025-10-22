from pydantic import BaseModel

# 商品のスキーマ
class Item(BaseModel):
    # 商品ID
    item_id: int
    # 商品名
    item_name: str
    # カテゴリID
    category_id: int