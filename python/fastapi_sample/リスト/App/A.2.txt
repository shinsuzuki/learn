from pydantic import BaseModel

# 資格情報のクラス
class Qualification(BaseModel):
    qualification_id: int       # 資格ID
    qualification_name: str     # 資格名

# 住所情報のクラス
class Address(BaseModel):
    city: str                   # 市区町村
    postal_code: str            # 郵便番号

# ユーザー情報のクラス
class User(BaseModel):
    user_id: int                # ユーザーID
    user_name: str              # ユーザー名
    qualifications: list[Qualification] # 資格はリストで持つ
    address: Address                    # 住所はオブジェクト