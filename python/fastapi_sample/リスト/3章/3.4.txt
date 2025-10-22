# 関数の引数がint型かstr型のいずれかであることを指定し
# 結果を返す関数
# 引数：整数型/文字列型
# 戻り値：文字列型
def parse_input(value: int | str) -> str:
    # 型判定
    if isinstance(value, int):
        return f"値は整数型です＝＞ {value}"
    elif isinstance(value, str):
        return f"値は文字列型です＝＞ {value}"
    else:
        raise ValueError("引数が整数型/文字列型ではありません")

# ==============================================================
# 呼び出し
# ==============================================================
print(parse_input(123))     # 整数を渡す
print(parse_input("abc"))   # 文字列を渡す
print(parse_input(99.9))    # 浮動小数点を渡す