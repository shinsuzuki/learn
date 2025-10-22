from fastapi import APIRouter
from schemas.category import Category

router = APIRouter()

# ----------------------------------------------------
# カテゴリ一覧を表示するためのエンドポイント
# ----------------------------------------------------
@router.get("/categories/", response_model=dict)
async def read_categories():
    return {"message": "カテゴリ一覧を表示", "categories": []}

# ----------------------------------------------------
# カテゴリを登録するためのエンドポイント
# ----------------------------------------------------
@router.post("/categories/", response_model=dict)
async def create_category(category: Category):
    return {"message": "カテゴリを作成しました", "category": category}

# ----------------------------------------------------
# カテゴリを更新するためのエンドポイント
# ----------------------------------------------------
@router.put("/categories/{category_id}", response_model=dict)
async def update_category(category_id: int, category: Category):
    return {"message": "カテゴリを更新しました",
            "category_id": category_id, "category": category}

# ----------------------------------------------------
# カテゴリを削除するためのエンドポイント
# ----------------------------------------------------
@router.delete("/categories/{category_id}", response_model=dict)
async def delete_category(category_id: int):
    return {"message": "カテゴリを削除しました", "category_id": category_id}