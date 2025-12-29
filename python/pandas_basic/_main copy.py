import pandas as pd
import json
import os


def main():
    df_main = pd.read_csv("sample.csv")
    print(df_main["id"])
    print("test")

    # ------------------------------------------------
    # 同じ値を新規の列に追加する
    df_main["add_item_1"] = 100
    df_main.to_csv("sample_add.csv")
    print("<列を追加>")
    print(df_main)

    # ------------------------------------------------
    # 他に読み込んだCSVファイルを既存のCSVの途中に列を追加する
    df_add = pd.read_csv("add_item_2.csv")
    df_main.insert(
        loc=2,
        column="item_2",
        value=df_add["item_2"],
    )

    print("<CSVを読み込んで列を挿入>")
    print(df_main)

    df_main.to_csv("sample_insert_item_2.csv")


if __name__ == "__main__":
    main()
