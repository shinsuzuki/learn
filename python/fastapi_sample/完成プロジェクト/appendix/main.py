from fastapi import FastAPI
from schemas import User

app = FastAPI()

# ユーザー情報(資格と住所情報を含む)JSONデータを受け取るエンドポイント
@app.post("/users/")
async def create_user(user: User) -> dict:
    # 受け取ったデータを表示する
    print("=== 受け取ったユーザー情報 ===")
    print("ユーザーID:", user.user_id)
    print("ユーザー名:", user.user_name)
    print("■：資格情報")
    for qualification in user.qualifications:
        print(f" - 資格ID: {qualification.qualification_id}, 資格名: {qualification.qualification_name}")
    print("■：住所情報")
    print(f" - 都道府県: {user.address.city}, 郵便番号: {user.address.postal_code}")
    
    return {"message": "ユーザーと資格情報を受け取りました"}