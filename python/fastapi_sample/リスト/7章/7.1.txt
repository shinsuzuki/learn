from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# =====【スキーマ】=====
# カテゴリのスキーマ
class Category(BaseModel):
    category_id: int
    category_name: str

# 商品のスキーマ
class Item(BaseModel):
    item_id: int
    item_name: str
    category_id: int

# =====【カテゴリ】=====
# カテゴリ一覧を取得
@app.get("/categories/", response_model=dict)
async def read_categories():
    # 実際にはデータベースから取得する処理が入ります
    return {"message": "カテゴリ一覧を表示", "categories": []}

# 新しいカテゴリを作成
@app.post("/categories/", response_model=dict)
async def create_category(category: Category):
    # 実際にはデータベースに保存する処理が入ります
    return {"message": "カテゴリを作成しました", "category": category}

# カテゴリを更新
@app.put("/categories/{category_id}", response_model=dict)
async def update_category(category_id: int, category: Category):
    # 実際にはデータベースを更新する処理が入ります
    return {"message": "カテゴリを更新しました",
    "category_id": category_id, "category": category}

# カテゴリを削除
@app.delete("/categories/{category_id}", response_model=dict)
async def delete_category(category_id: int):
    # 実際にはデータベースから削除する処理が入ります
    return {"message": "カテゴリを削除しました", "category_id": category_id}

# =====【商品】=====
# 商品一覧を取得
@app.get("/items/", response_model=dict)
async def read_items():
    # 実際にはデータベースから取得する処理が入ります
    return {"message": "商品一覧を表示", "items": []}

# 新しい商品を作成
@app.post("/items/", response_model=dict)
async def create_item(item: Item):
    # 実際にはデータベースに保存する処理が入ります
    return {"message": "商品を作成しました", "item": item}

# 商品を更新
@app.put("/items/{item_id}", response_model=dict)
async def update_item(item_id: int, item: Item):
    # 実際にはデータベースを更新する処理が入ります
    return {"message": "商品を更新しました",
    "item_id": item_id, "item": item}

# 商品を削除
@app.delete("/items/{item_id}", response_model=dict)
async def delete_item(item_id: int):
    # 実際にはデータベースから削除する処理が入ります
    return {"message": "商品を削除しました", "item_id": item_id}