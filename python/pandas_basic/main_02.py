import pandas as pd
import numpy as np
import json
import os


def main():
    print("--> start\n")
    # ----------------------------------------------------------------------

    print("\n---------- データのカウント ----------")
    df = pd.DataFrame(
        {
            "A": [1, 2, 3, np.nan],
            "B": [10, 20, np.nan, 40],
            "C": [5, 5, 5, 5],
            "Category": ["Apple", "Banana", "Apple", "Cherry"],
        }
    )

    print(df)
    #      A     B  C Category
    # 0  1.0  10.0  5    Apple
    # 1  2.0  20.0  5   Banana
    # 2  3.0   NaN  5    Apple
    # 3  NaN  40.0  5   Cherry

    print(f"Categoryのリスト数 (全行): {len(df)}")
    # Categoryのリスト数 (全行):4
    print(f"Categoryのリスト数 (全行): {df.shape[0]}")
    # Categoryのリスト数 (全行):4
    print(f"Categoryのリスト数 (naを除く): \n{df.count()}")
    # Categoryのリスト数 (naを除く):
    # A           3
    # B           3
    # C           4
    # Category    4
    # dtype: int64

    print("\n---------- 重複行の削除 ----------")
    # サンプルデータの作成（重複データを含む）
    df = pd.DataFrame(
        {
            "ID": [1, 2, 2, 3, 4, 1],
            "A": [1, 2, 2, 3, 4, 1],
            "B": [10, 20, 20, 30, 40, 100],  # ID:1 は Bの値が異なる
            "C": ["X", "Y", "Y", "X", "Z", "X"],
        }
    )

    print(df)
    #    ID  A    B  C
    # 0   1  1   10  X
    # 1   2  2   20  Y
    # 2   2  2   20  Y
    # 3   3  3   30  X
    # 4   4  4   40  Z
    # 5   1  1  100  X

    # 2. 重複行の確認 (duplicated)
    # 重複している行を True として返します
    print("\n--- 重複行の確認 (Trueが重複) ---")
    print(df.duplicated())
    # 0    False
    # 1    False
    # 2     True
    # 3    False
    # 4    False
    # 5    False
    # dtype: bool

    print("\n--- 重複行(全カラム)を抽出 ---")
    print(df[df.duplicated()])
    #    ID  A   B  C
    # 2   2  2  20  Y

    print("\n--- 重複行(カラム:ID)を抽出 ---")
    print(df[df.duplicated("ID")])
    #    ID  A    B  C
    # 2   2  2   20  Y
    # 5   1  1  100  X

    # 3. 全く同じ行（全列一致）を削除
    # 全てのカラムの値が一致する行を削除します
    df_unique_all = df.drop_duplicates()
    print("\n--- 全列一致する重複を削除 ---")
    print(df_unique_all)
    #    ID  A    B  C
    # 0   1  1   10  X
    # 1   2  2   20  Y
    # 3   3  3   30  X
    # 4   4  4   40  Z
    # 5   1  1  100  X

    # 4. 特定のカラムを基準に重複を削除 (subset)
    # IDが同じであれば重複とみなします
    df_unique_id = df.drop_duplicates(subset=["ID"])
    print("\n--- 特定のカラムを基準に重複を削除 (subset) ---")
    print(df_unique_id)
    #    ID  A   B  C
    # 0   1  1  10  X
    # 1   2  2  20  Y
    # 3   3  3  30  X
    # 4   4  4  40  Z

    # 5. 「最後」のデータを残す (keep)
    # デフォルト(keep='first')は最初の行を残しますが、'last'で最後を残せます
    df_keep_last = df.drop_duplicates(subset=["ID"], keep="last")
    print("\n--- ID重複時に「最後」の行を残す ---")
    print(df_keep_last)
    #    ID  A    B  C
    # 2   2  2   20  Y
    # 3   3  3   30  X
    # 4   4  4   40  Z
    # 5   1  1  100  X

    # 6. 重複がある行を「すべて」削除する (keep=False)
    # 1つでも重複があれば、その値を持つ行をすべて消去します
    df_keep_none = df.drop_duplicates(subset=["ID"], keep=False)
    print("\n--- 重複がある行をすべて削除 ---")
    print(df_keep_none)

    # 7. インデックスを振り直す
    # 削除後はインデックスが飛ぶため、reset_indexをセットで使うのが一般的です
    df_final = df.drop_duplicates(subset=["ID"]).reset_index(drop=True)
    print("\n--- 重複削除後にインデックスを振り直し ---")
    print(df_final)
    #    ID  A   B  C
    # 3   3  3  30  X
    # 4   4  4  40  Z

    # 8. 欠損値(NaN)の数を数える
    nan_count = df.isnull().sum()
    print("\n--- 列ごとの欠損値の数 ---")
    print(nan_count)
    # ID    0
    # A     0
    # B     0
    # C     0

    print("\n---------- マッピング ----------")
    df = pd.DataFrame(
        {
            "ID": [101, 102, 103, 104],
            "Status_Code": [1, 2, 1, 3],
            "Score": [85, 40, 72, 55],
            "City": ["tokyo", "osaka", "nagoya", "tokyo"],
        }
    )

    print("\n--- 辞書を使ったマッピング (map) ---")
    # 1. 辞書を使ったマッピング (map)
    # 特定の列の値を、辞書に基づいて置換します。
    # 辞書にない値は NaN になります。
    status_map = {1: "Active", 2: "Pending", 3: "Closed"}
    df["Status_Name"] = df["Status_Code"].map(status_map)
    print(df)
    #     ID  Status_Code  Score    City Status_Name
    # 0  101            1     85   tokyo      Active
    # 1  102            2     40   osaka     Pending
    # 2  103            1     72  nagoya      Active
    # 3  104            3     55   tokyo      Closed

    print("\n--- 値の置換 (replace) ---")
    # 2. 値の置換 (replace)
    # mapと似ていますが、辞書にない値は「元の値が維持」されます。
    # また、DataFrame全体に対しても適用可能です。
    df["City_JP"] = df["City"].replace({"tokyo": "東京", "osaka": "大阪"})
    print(df)

    print("\n--- 関数（ラムダ式）を使ったマッピング (apply) ---")
    df["Grade"] = df["Score"].apply(lambda x: "Pass" if x >= 60 else "Fail")
    print(df)

    # 4. 複数カラムを参照したマッピング
    # apply(axis=1) を使うと、行全体の値を参照して新しい値を作れます。
    print("\n--- 複数カラムを参照したマッピング ---")

    def detailed_judge(row):
        if row["Grade"] == "Pass" and row["Score"] >= 80:
            return "Excellent"

        return row["Grade"]

    df["Detail_Grade"] = df.apply(detailed_judge, axis=1)
    print(df)

    # 5. 文字列の変換 (strアクセサ)
    # 大文字・小文字変換などの文字列操作もマッピングの一種です。
    print("\n--- 複数カラムを参照したマッピング ---")
    df["City_Upper"] = df["City"].str.upper()
    print(df)

    print("\n---------- グルーピング ----------")

    # サンプルデータの作成
    df = pd.DataFrame(
        {
            "Category": ["Food", "Food", "Electronics", "Electronics", "Food"],
            "Item": ["Apple", "Banana", "Laptop", "Mouse", "Cherry"],
            "Sales": [100, 150, 1200, 300, 200],
            "Quantity": [10, 20, 1, 5, 15],
            "Store": ["Tokyo", "Osaka", "Tokyo", "Osaka", "Tokyo"],
        }
    )

    print(df.groupby("Category")["Sales"].sum())
    # Category
    # Electronics    1500
    # Food            450
    # Name: Sales, dtype: int64

    # 3. 複数列でのグルーピング
    # Storeごと、さらにCategoryごとの合計を算出
    store_cat_sum = df.groupby(["Store", "Category"])["Sales"].sum()
    print("\n--- Store別・Category別の売上合計 ---")
    print(store_cat_sum)

    # 6. グループごとのデータ確認
    # 特定のグループ（例: Food）に属する行だけを抽出
    food_group = df.groupby("Category").get_group("Food")
    print("\n--- 'Food' グループのデータのみ抽出 ---")
    print(food_group)

    # ----------------------------------------------------------------------
    print("\n<-- end")


if __name__ == "__main__":
    main()
