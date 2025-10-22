from typing import Optional

# ユーザー情報を持つプロフィール返却する関数
# 引数：文字列型、文字列型/Optional、数値型/Optional
# 戻り値：辞書型
def get_profile(
        email: str,
        username: Optional[str] = None,
        age: Optional[int] = None
    ) -> dict:
    profile = {"email": email}
    if username:
        # usernameが引数に存在すれば、辞書型へ追加
        profile["username"] = username
    if age:
        # ageが引数に存在すれば、辞書型へ追加
        profile["age"] = age
    return profile

# ==============================================================
# 呼び出し
# ==============================================================
# usernameとageを指定しない場合
user_profile = get_profile(email="user@example.com")
# 表示
print(user_profile)

# usernameとageの両方を指定する場合
complete_profile = get_profile(email="user@example.com",
    username="元太", age=30)
# 表示
print(complete_profile)