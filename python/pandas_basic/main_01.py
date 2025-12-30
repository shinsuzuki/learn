import pandas as pd
import numpy as np
import json
import os


def main():
    print("--> start main\n")

    print("---------- シリーズ ----------")

    print("---- 数値登録 ---- ")
    s1 = pd.Series([1, 2, 3, 4])
    print("-- 中身 --")
    print(s1)
    # 0    1
    # 1    2
    # 2    3
    # 3    4
    # dtype: int64

    print("-- 配列 --")
    print(s1.array)
    # <NumpyExtensionArray>
    # [1, 2, 3, 4]
    # Length: 4, dtype: int64

    print("---- 数値登録,Indexを文字列 ---- ")
    s1 = pd.Series([1, 2, 3, 4], index=["a", "b", "c", "d"])
    print(s1)
    # a    1
    # b    2
    # c    3
    # d    4
    # dtype: int64

    print("-- インデックスラベルでアクセス --")
    print(s1["a"])
    # 1

    print("---- 辞書からシリーズへ(キーがインデックス) ---- ")
    d1 = {"Apple": 150, "Banana": 200, "Cherry": 300}
    s1 = pd.Series(d1)
    print(s1)
    # Apple     150
    # Banana    200
    # Cherry    300
    # dtype: int64

    print("-- シリーズから辞書へ --")
    print(s1.to_dict())
    # {'Apple': 150, 'Banana': 200, 'Cherry': 300}

    # (+)によりseries同士のjoinも可能
    # indexは入れ替えか可能

    print("---------- DaraFrame ----------")

    data = {
        "state": ["Ohio", "Ohio", "Ohio", "Nevada", "Nevada", "Nevada"],
        "year": [2000, 2001, 2002, 2001, 2002, 2003],
        "pop": [1.5, 1.7, 3.6, 2.4, 2.9, 3.2],
    }
    df = pd.DataFrame(data)
    print(df)
    #     state  year  pop
    # 0    Ohio  2000  1.5
    # 1    Ohio  2001  1.7
    # 2    Ohio  2002  3.6
    # 3  Nevada  2001  2.4
    # 4  Nevada  2002  2.9
    # 5  Nevada  2003  3.2

    print("-- head --")
    print(df.head(3))
    #   state  year  pop
    # 0  Ohio  2000  1.5
    # 1  Ohio  2001  1.7
    # 2  Ohio  2002  3.6

    print("-- tail --")
    print(df.tail(3))
    #     state  year  pop
    # 3  Nevada  2001  2.4
    # 4  Nevada  2002  2.9
    # 5  Nevada  2003  3.2

    print("-- カラムの並び替え --")
    # カラムがなければ列が欠損値で登録される
    new_order_columns = ["year", "state", "pop", "dept"]
    print(pd.DataFrame(data, columns=new_order_columns))
    #    year   state  pop dept
    # 0  2000    Ohio  1.5  NaN
    # 1  2001    Ohio  1.7  NaN
    # 2  2002    Ohio  3.6  NaN
    # 3  2001  Nevada  2.4  NaN
    # 4  2002  Nevada  2.9  NaN
    # 5  2003  Nevada  3.2  NaN

    # 既存のカラムを並び替える
    # df_new_order_columns = df[new_order_columns]
    # print(df_new_order_columns)

    print("-- 列を取得 --")
    print(df["state"])
    # 0      Ohio
    # 1      Ohio
    # 2      Ohio
    # 3    Nevada
    # 4    Nevada
    # 5    Nevada

    print(df.year)
    # 0    2000
    # 1    2001
    # 2    2002
    # 3    2001
    # 4    2002
    # 5    2003

    print("-- 列の値を変更 --")
    df["dept"] = np.arange(6.0)
    print(df)
    #     state  year  pop  dept
    # 0    Ohio  2000  1.5   0.0
    # 1    Ohio  2001  1.7   1.0
    # 2    Ohio  2002  3.6   2.0
    # 3  Nevada  2001  2.4   3.0
    # 4  Nevada  2002  2.9   4.0
    # 5  Nevada  2003  3.2   5.0

    print("-- 列を追加、削除 --")
    df["eastern"] = df["state"] == "Ohio"
    print(df)
    #     state  year  pop  dept  eastern
    # 0    Ohio  2000  1.5   0.0     True
    # 1    Ohio  2001  1.7   1.0     True
    # 2    Ohio  2002  3.6   2.0     True
    # 3  Nevada  2001  2.4   3.0    False
    # 4  Nevada  2002  2.9   4.0    False
    # 5  Nevada  2003  3.2   5.0    False

    del df["eastern"]  # これはdfが編集される
    print(df)
    #     state  year  pop  dept
    # 0    Ohio  2000  1.5   0.0
    # 1    Ohio  2001  1.7   1.0
    # 2    Ohio  2002  3.6   2.0
    # 3  Nevada  2001  2.4   3.0
    # 4  Nevada  2002  2.9   4.0
    # 5  Nevada  2003  3.2   5.0

    print("-- ネストしたデータ --")
    pupulations = {
        "Ohio": {
            2000: 1.5,
            2001: 1.7,
            2003: 3.6,
        },
        "Nevada": {
            2001: 2.4,
            2003: 2.9,
        },
    }

    df = pd.DataFrame(pupulations)
    print(df)
    #       Ohio  Nevada
    # 2000   1.5     NaN
    # 2001   1.7     2.4
    # 2003   3.6     2.9

    print("-- 行と列を入れ替え --")
    print(df.T)
    #         2000  2001  2003
    # Ohio     1.5   1.7   3.6
    # Nevada   NaN   2.4   2.9

    print("-- インデックスを設定 --")
    print(df)
    #       Ohio  Nevada
    # 2000   1.5     NaN
    # 2001   1.7     2.4
    # 2003   3.6     2.9

    print("-- インデックス名、カラム名を設定 --")
    df.index.name = "year"
    df.columns.name = "state"
    print(df)
    # state  Ohio  Nevada
    # year
    # 2000    1.5     NaN
    # 2001    1.7     2.4
    # 2003    3.6     2.9

    print("-- 軸から削除(Series) --")
    s1 = pd.Series([1, 2, 3, 4], index=["a", "b", "c", "d"])
    print(s1)
    # a    1
    # b    2
    # c    3
    # d    4
    # dtype: int64
    print(s1.drop("c"))
    # a    1
    # b    2
    # d    4
    # dtype: int64

    print("-- 軸から削除(DataFrame) --")
    data = {
        "state": ["Ohio", "Ohio", "Ohio", "Nevada", "Nevada", "Nevada"],
        "year": [2000, 2001, 2002, 2001, 2002, 2003],
        "pop": [1.5, 1.7, 3.6, 2.4, 2.9, 3.2],
    }
    df = pd.DataFrame(data, index=["a", "b", "c", "d", "e", "f"])
    print(df)
    #     state  year  pop
    # 0    Ohio  2000  1.5
    # 1    Ohio  2001  1.7
    # 2    Ohio  2002  3.6
    # 3  Nevada  2001  2.4
    # 4  Nevada  2002  2.9
    # 5  Nevada  2003  3.2

    # indexを指定して削除
    print(df.drop(index=["c", "e"]))
    #     state  year  pop
    # 0    Ohio  2000  1.5
    # 1    Ohio  2001  1.7
    # 3  Nevada  2001  2.4
    # 5  Nevada  2003  3.2

    # 列を指定して削除(削除したDFが返される)
    print(df.drop(columns=["state"]))

    print("-- インデックスで参照 --")
    print(df.loc["c"])
    # state    Ohio
    # year     2002
    # pop       3.6
    # Name: c, dtype: object

    print("-- インデックスの位置で参照 --")
    print(df.iloc[3])
    # state    Nevada
    # year       2001
    # pop         2.4
    # Name: d, dtype: object

    print("-- ソート --")
    # 昇順
    print(df.sort_values("year", ascending=True))
    # 降順
    print(df.sort_values("year", ascending=False))

    print("-- ランク --")
    # サンプルデータの作成（同じ値 20 が重複しているのがポイント）
    df = pd.DataFrame({"Name": ["Alice", "Bob", "Charlie", "David", "Eve"], "Score": [10, 20, 20, 30, 40]})

    print("--- 元のデータ ---")
    print(df)

    # 1. 基本的な順位 (default: method='average')
    # 同じ値がある場合、それらの順位の平均値を返します（2位と3位の平均で2.5位）
    df["Rank_Avg"] = df["Score"].rank()

    # 2. 最小順位 (method='min')
    # いわゆる「同着2位」方式。次の順位は飛ばされます（1位, 2位, 2位, 4位...）
    df["Rank_Min"] = df["Score"].rank(method="min")

    # 3. 最大順位 (method='max')
    # 同じ値の中で最大の順位を割り当てます（1位, 3位, 3位, 4位...）
    df["Rank_Max"] = df["Score"].rank(method="max")

    # 4. 密な順位 (method='dense')
    # 同着があっても次の順位を飛ばしません（1位, 2位, 2位, 3位...）
    df["Rank_Dense"] = df["Score"].rank(method="dense")

    # 5. 出現順 (method='first')
    # 同じ値でも、リストの上にある方を先の順位にします（1位, 2位, 3位, 4位...）
    df["Rank_First"] = df["Score"].rank(method="first")

    # 6. 降順ソート (ascending=False)
    # スコアが高い方を1位にしたい場合
    df["Rank_Desc"] = df["Score"].rank(ascending=False, method="min")

    print("\n--- メソッド別順位比較 ---")
    print(df[["Name", "Score", "Rank_Avg", "Rank_Min", "Rank_Dense", "Rank_First", "Rank_Desc"]])
    #       Name  Score  Rank_Avg  Rank_Min  Rank_Dense  Rank_First  Rank_Desc
    # 0    Alice     10       1.0       1.0         1.0         1.0        5.0
    # 1      Bob     20       2.5       2.0         2.0         2.0        3.0
    # 2  Charlie     20       2.5       2.0         2.0         3.0        3.0
    # 3    David     30       4.0       4.0         3.0         4.0        2.0
    # 4      Eve     40       5.0       5.0         4.0         5.0        1.0

    # 【主要なパラメータまとめ】
    # - axis: 0なら列内(縦)、1なら行内(横)で順位付け
    # - numeric_only: Trueにすると数値列のみを対象にする
    # - na_option: 欠損値(NaN)をどう扱うか ('keep', 'top', 'bottom')
    # - pct: Trueにすると、0.0から1.0の間の相対的な割合（パーセンタイル）で返す

    print("\n--- 集約 ---")
    print(f"sum: {df["Score"].sum()}")  # sum: 120
    print(f"max: {df["Score"].max()}")  # max: 40
    print(f"min: {df["Score"].min()}")  # min: 10
    print(f"mean: {df["Score"].mean()}")  # mean: 24.0

    print("\n--- ユニーク、頻度、所属の確認 ---")
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

    print(f"Categoryのユニークな値のリスト: {df["Category"].unique()}")
    # Categoryのユニークな値のリスト: ['Apple' 'Banana' 'Cherry']

    print(f"Categoryのユニークな値の個数: {df["Category"].nunique()}")
    # Categoryのユニークな値の個数: 3

    print(f"Categoryの出現頻度を集計: {df["Category"].value_counts()}")
    # Categoryの出現頻度を集計: Category
    # Apple     2
    # Banana    1
    # Cherry    1

    print(f"Categoryの出現頻度の割合: {df["Category"].value_counts(normalize=True)}")
    # Categoryの出現頻度の割合: Category
    # Apple     0.50
    # Banana    0.25
    # Cherry    0.25

    print(f"Categoryの出現頻度の最大値: {max(df["Category"].value_counts())}")
    # Categoryの出現頻度の最大値: 2
    #      A     B  C Category
    # 0  1.0  10.0  5    Apple
    # 1  2.0  20.0  5   Banana
    # 2  3.0   NaN  5    Apple

    # isin,フィルター
    df_filtered = df[df["Category"].isin(["Apple", "Banana"])]
    print(df_filtered)
    #      A     B  C Category
    # 0  1.0  10.0  5    Apple
    # 1  2.0  20.0  5   Banana
    # 2  3.0   NaN  5    Apple

    print("\n<-- end main")


if __name__ == "__main__":
    main()
