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
    print("-- 配列 --")
    print(s1.array)

    print("---- 数値登録,Indexを文字列 ---- ")
    s1 = pd.Series([1, 2, 3, 4], index=["a", "b", "c", "d"])
    print(s1)
    print("-- インデックスラベルでアクセス --")
    print(s1["a"])

    print("---- 辞書からシリーズへ(キーがインデックス) ---- ")
    d1 = {"Apple": 150, "Banana": 200, "Cherry": 300}
    s1 = pd.Series(d1)
    print(s1)
    print("-- シリーズから辞書へ --")
    print(s1.to_dict())

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

    print("-- head --")
    print(df.head(3))

    print("-- tail --")
    print(df.tail(3))

    print("-- カラムの並び替え --")
    # カラムがなければ列が欠損値で登録される
    new_order_columns = ["year", "state", "pop", "dept"]
    print(pd.DataFrame(data, columns=new_order_columns))

    # 既存のカラムを並び替える
    # df_new_order_columns = df[new_order_columns]
    # print(df_new_order_columns)

    print("-- 列を取得 --")
    print(df["state"])
    print(df.year)

    print("-- 列の値を変更 --")
    df["dept"] = np.arange(6.0)
    print(df)

    print("-- 列を追加、削除 --")
    df["eastern"] = df["state"] == "Ohio"
    print(df)
    del df["eastern"]
    print(df)

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

    print("-- 行と列を入れ替え --")
    print(df.T)

    print("-- インデックスを設定 --")
    print(df)

    print("-- インデックス名、カラム名を設定 --")
    df.index.name = "year"
    df.columns.name = "state"
    print(df)

    print("\n<-- end main")


if __name__ == "__main__":
    main()
