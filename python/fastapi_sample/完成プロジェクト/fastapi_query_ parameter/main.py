from fastapi import FastAPI
from typing import Optional
from data import get_books_by_category

app = FastAPI()

# クエリパラメータで指定されたカテゴリに基づいて書籍情報を検索し、
# 結果をJSON形式で返す
@app.get("/books/")
async def read_books(
    category: Optional[str] = None
    )-> list[dict[str, str]]:
    # クエリパラメータで指定されたカテゴリに基づいて書籍を検索する
    result = get_books_by_category(category)
    # 結果を辞書のリストとして返す
    return [{
        "id": book.id,
        "title": book.title,
        "category": book.category
        } for book in result]