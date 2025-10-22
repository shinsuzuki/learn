from typing import Annotated

# 引数で渡された整数値が指定された範囲内にあるかを
# チェックする関数
# 引数：数値型（Annotated）
# 戻り値：None
def process_value(
    value: Annotated[int, "範囲: 0 <= value <= 100"]
    )-> None:
    # 値が指定された範囲内にあるかチェックする
    if 0 <= value <= 100:
        # 値が範囲内の場合の処理
        print(f"受け取った値は範囲内です: {value}")
    else:
        # 値が範囲外の場合の処理
        raise ValueError(f"範囲外の値です。受け取った値: {value}")

# ==============================================================
# 呼び出し
# ==============================================================
# 正しい値で関数をテスト
process_value(50)

# 範囲外の値で関数をテストし、エラーを確認
try:
    process_value(150)
except ValueError as e:
    print(e)