from typing import Annotated, Literal
from fastapi import FastAPI, Query
from enum import StrEnum
from pydantic import BaseModel, Field

app = FastAPI()


class ModelName(StrEnum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"


@app.get("/")
def read_root():
    return {"Hello": "World"}


# ---------------------------------------- パスパラメータ
@app.get("/items/{item_id}")
def read_item(item_id: int, q: str | None = None):
    return {"item_id": item_id, "q": q}


@app.get("/item_by_id/{item_id}")
def read_item_by_id(item_id: int):
    return {"item_id": "res_" + str(item_id)}


@app.get("/models/{model_name}")
def get_model(model_name: ModelName):
    if model_name is ModelName.alexnet:
        return {"model_name": model_name, "message": "Deep Learning FTW!"}

    if model_name.value == "lenet":
        return {"model_name": model_name, "message": "LeCNN all the images"}

    return {"model_name": model_name, "message": "Have some residuals"}


# ---------------------------------------- クエリーパラメータ
# デフォルトにした場合は必須でなくなる
# デフォルト値を設定せずにNoneを設定した場合はオプショナルになる
@app.get("/items/")
def read_items(skip: int = 0, limit: int = 10):
    fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]
    return fake_items_db[skip : skip + limit]


@app.get("/items_q_options/{item_id}")
def read_items_q_options(item_id: str, q: str | None = None):
    if q:
        return {"item_id": item_id, "q": q}

    return {"item_id": item_id}


# ---------------------------------------- リクエストボディ
# pydantic、BaseModelを使用
class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None


@app.post("/items/")
def create_item(item: Item):
    item_dic = item.model_dump()
    # for key in item_dic.keys():
    #     print(f"{key}: {item_dic[key]}")

    return item


# パスクエリー、ボディを取得
@app.post("/items/{item_id}")
def create_item2(
    item_id: str,
    item: Item,
    q: str | None = None,
):
    return {"item_id": item_id, "q": q, **item.model_dump()}


# ---------------------------------------- クエリーパラメータ(モデル)
# クエリーをモデルで受け取る
class FilterParams(BaseModel):
    limit: int = Field(100, gt=0, le=100)
    offset: int = Field(0, ge=0)
    order_by: Literal["created_at", "updated_at"] = "created_at"
    tags: list[str] = []


@app.get("/items2/")
def read_items2(filterParams: Annotated[FilterParams, Query()]):
    return filterParams
