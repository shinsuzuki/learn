from fastapi import FastAPI, Depends
from pydantic import BaseModel

app = FastAPI()

# ユーザーモデルの定義
class User(BaseModel):
    # 名前
    username: str
    # 状態
    is_active: bool = True

# ユーザーデータのリスト
users = [
    User(username="太郎", is_active=True),
    User(username="次郎", is_active=False),
    User(username="花子", is_active=True)
]

# アクティブなユーザーをフィルタリングする依存関係
def get_active_users():
    # アクティブなユーザーだけをフィルタリング
    active_users = [user for user in users if user.is_active]
    print('=== アクティブなユーザーを取得 ===')
    return active_users

# ルート操作で依存関係を使用
@app.get("/active")
async def list_active_users(active_users: list[User] = Depends(get_active_users)):
    print('=== 【依存】してデータを取得 ===')
    return active_users