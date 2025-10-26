from typing import Union
from typing import Annotated
from enum import Enum
from fastapi import FastAPI, Query, Header
from pydantic import BaseModel, Field

app = FastAPI()


# -------------------- ルートエンドポイント
@app.get("/")
async def root():
    return {"message": "Hello, World!"}


# -------------------- パスパラメータ(検証:Pydanticあり)
# @app.get("/items/{item_id}")
# async def read_item(item_id: int):
#     return {"item_id": item_id}


# Enumクラス
class ModelName(str, Enum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"


@app.get("/models/{model_name}")
async def get_model(model_name: ModelName):
    if model_name is ModelName.alexnet:
        return {"model_name": model_name, "message": "Deep Learning FTW!"}

    if model_name.value == "resnet":
        return {"model_name": model_name, "message": "LeCNN all the images"}

    return {"model_name": model_name, "message": "Have some residuals"}


# -------------------- クエリパラメータ
# @app.get("/items/")
# async def read_items(skip: int = 0, limit: int = 10):
#     fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]
#     return fake_items_db[skip : skip + limit]


# -------------------- リクエストボディ
class Item(BaseModel):
    name: str
    # description: str | None = None
    description: str | None = Field(
        default=None, title="The description of the item", max_length=120
    )
    # price: float
    price: float = Field(gt=0, description="The price must be greater than zero")
    tax: float | None = None


@app.post("/items/")
async def create_item(item: Item):
    # return item

    item_dict = item.model_dump()
    if item.tax is not None:
        price_with_tax = item.price + item.tax
        item_dict.update({"price_with_tax": price_with_tax})
        print(item_dict)

    return item_dict


# -------------------- クエリパラメータと文字列の検証
@app.get("/items/")
async def read_items(
    q: Annotated[
        str | None, Query(min_length=3, max_length=20, pattern="^fixedprefix$")
    ] = None,
):
    results = {"items": [{"item_id": "Foo"}, {"item_id": "Bar"}]}
    if q:
        results.update({"q": q})

    return results


# -------------------- ヘッダパラメータ
@app.get("/items_header/")
async def read_items(
    user_agent: Annotated[str | None, Header()] = None,
    abc_agent: Annotated[str | None, Header()] = None,
):
    return {"User-Agent": user_agent, "Abc-Agent": abc_agent}


# クッキーパラメータモデルから読む
