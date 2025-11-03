from typing import Union, List, Any, TypeVar, Generic, Optional
from typing import Annotated
from enum import Enum
from fastapi.responses import JSONResponse
from fastapi import (
    FastAPI,
    Query,
    Header,
    Cookie,
    status,
    Form,
    File,
    UploadFile,
    HTTPException,
    Request,
)
from pydantic import BaseModel, Field, EmailStr

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
@app.get("/items/")
async def read_items(skip: int = 0, limit: int = 10):
    fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]
    return fake_items_db[skip : skip + limit]


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


# -------------------- クッキーのパラメータを取得する
@app.get("/items_cookie/")
async def read_items(
    my_cookie_value: Annotated[str | None, Cookie()] = None,
    session_id: Annotated[str | None, Cookie()] = None,
):
    return {"my_cookie_value": my_cookie_value, "session_id": session_id}


# -------------------- ヘッダパラメータを取得する
@app.get("/items_header/")
async def read_items(
    user_agent: Annotated[str | None, Header()] = None,
    abc_agent: Annotated[str | None, Header()] = None,
):
    return {"User-Agent": user_agent, "Abc-Agent": abc_agent}


# --------------------  クッキーパラメータモデルから読む
# skip

# --------------------  ヘッダーパラメータモデルから読む
# skip


# --------------------  レスポンスモデル
class Item(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float
    tax: Union[float, None] = None
    tags: List[str] = []


# @app.post("/items/", response_model=Item)
# async def create_item(item: Item) -> Any:
#     return item


@app.get("/items/", response_model=List[Item])
async def read_items() -> Any:  # Any型ヒントで何でもOK
    return [
        {"name": "Portal Gun", "price": 42.0},
        {"name": "Plumbus", "price": 32.0},
    ]


class UserIn(BaseModel):
    username: str
    password: str
    full_name: str | None = None


class UserOut(BaseModel):
    username: str
    full_name: Union[str, None] = None


# Don't do this in production!, response_model_exclude_unsetはフィールド二値が設定されない場合は返さない
@app.post("/user/", response_model=UserOut, response_model_exclude_unset=True)
async def create_user(user: UserIn) -> Any:
    return user


# デフォルト値
# List、


# -------------------- モデルより詳しく
#
# Unionによる複数のモデルを返せる


# -------------------- レスポンスステータスコード
@app.post("/items2/", status_code=status.HTTP_201_CREATED)
async def create_items2(item: Item) -> Any:
    return item


# -------------------- フォームデータ
@app.post("/login/")
@app.post("/login/")
async def login(username: Annotated[str, Form()], password: Annotated[str, Form()]):
    return {"username": username}


# -------------------- フォームモデル
class FormData(BaseModel):
    username: str
    password: str


@app.post("/login_form_model/")
async def login(data: Annotated[FormData, Form()]):
    return data


# -------------------- ファイルのアップロード
@app.post("/uploadfile/")
# async def create_upload_file(upload_file: Annotated[bytes, File()]):
#     return {"file_size": len(upload_file)}
async def create_upload_file(upload_file: UploadFile | None = None):
    contents = await upload_file.read()
    return {"filename": upload_file.filename, "contents": contents}


# -------------------- リクエストフォーム
# skip


# -------------------- エラーハンドリング
@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request: Request, exc: HTTPException):
    """
    HTTPException発生時に呼び出されるカスタムハンドラー。
    統一されたJSONフォーマットでレスポンスを返す。
    """
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "status_code": exc.status_code,
            "status": "error",
            "messages": exc.detail,
            "data": None,
        },
    )


def raise_error(status_code: int, detail_messages: List[str]):
    raise HTTPException(
        status_code=status_code,
        detail=detail_messages,
    )


@app.get("/items_error/{item_id}")
async def read_item(item_id: int):
    if item_id not in [1, 2, 3]:
        # raise HTTPException(
        #     status_code=404, detail=["Item not found_1", "Item not found_2"]
        # )
        raise_error(404, ["Item not found_1", "Item not found_2"])

    return {"item_id": item_id}


T = TypeVar("T")


# 共通レスポンスモデルを定義
class ApiResponse(BaseModel, Generic[T]):
    status_code: int = 200
    status: str = "success"
    messages: Optional[List[str]] = None
    data: Optional[T] = None


# 特定のデータモデルを定義（例：ユーザー情報）
class User(BaseModel):
    user_id: int
    name: str


# エンドポイントの例
@app.get("/user/{user_id}", response_model=ApiResponse[User])
def get_user(user_id: int):
    # データベースからユーザーを取得するなどの処理
    user_data = {"user_id": user_id, "name": "John Doe"}

    # 共通レスポンス形式でデータをラップして返す
    return ApiResponse(
        data=user_data, messages=["User retrieved successfully"], code=201
    )
