from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI()

# データ構造
class BookSchema(BaseModel):
    title: str = Field(..., description="タイトルの指定：必須",
                        example="コイノボリが如く")
    category: str = Field(..., description="カテゴリの指定：必須",
                        example="comics")
    publish_year: int = Field(default=None, description="出版年の指定：任意",
                        example=2023)
    price: float = Field(..., gt=0, le=5000,
                        description="価格の指定：0 < 価格 <=10000：必須",
                        example=2500)
    
# エンドポイント
@app.post("/books/", response_model=BookSchema)
async def create_book(book: BookSchema):
    return book