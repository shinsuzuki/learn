from fastapi import FastAPI
from enum import StrEnum
from pydantic import BaseModel

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
class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None


@app.post("/items/")
def create_item(item: Item):
    return item


# パスクエリー、ボディを取得
@app.post("/items/{item_id}")
def create_item2(item_id: str, q: str, item: Item):
    return {"item_id": item_id, "q": q, **item.model_dump()}
