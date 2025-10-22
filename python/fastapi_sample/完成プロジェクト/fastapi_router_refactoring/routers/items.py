from fastapi import APIRouter
from schemas.item import Item

router = APIRouter()

# ----------------------------------------------------
# 商品一覧を表示するためのエンドポイント
# ----------------------------------------------------
@router.get("/items/", response_model=dict)
async def read_items():
    return {"message": "商品一覧を表示", "items": []}

# ----------------------------------------------------
# 商品を作成するためのエンドポイント
# ----------------------------------------------------
@router.post("/items/", response_model=dict)
async def create_item(item: Item):
    return {"message": "商品を作成しました", "item": item}

# ----------------------------------------------------
# 商品を更新するためのエンドポイント
# ----------------------------------------------------
@router.put("/items/{item_id}", response_model=dict)
async def update_item(item_id: int, item: Item):
    return {"message": "商品を更新しました",
            "item_id": item_id, "item": item}

# ----------------------------------------------------
# 商品を削除するためのエンドポイント
# ----------------------------------------------------
@router.delete("/items/{item_id}", response_model=dict)
async def delete_item(item_id: int):
    return {"message": "商品を削除しました", "item_id": item_id}
