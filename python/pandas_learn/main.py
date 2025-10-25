import pandas as pd


def main():
    print(">> start pandas")

    # ---------------------------------------- DataFrame作成
    print("-------------------- 辞書からDataFrame作成")
    data = {
        "Name": ["Alice", "Bob", "Charlie"],
        "Age": [25, 30, 35],
        "City": ["New York", "Los Angeles", "Chicago"],
    }

    df = pd.DataFrame(data)
    print(df)

    print("-------------------- csvからDataFrame作成")
    df = pd.read_csv(r"data\test.csv")
    print(df)

    print("-------------------- excelからDataFrame作成")
    df = pd.read_excel(r"data\test.xlsx")
    print(df)

    print("-------------------- webからDataFrame作成")
    url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

    column_name = [
        "sepal_length",
        "sepal_width",
        "petal_length",
        "petal_width",
        "class",
    ]

    df = pd.read_csv(url, names=column_name)
    print(df.head(5))

    # ---------------------------------------- DataFrame操作
    print("-------------------- ソート")
    data = {
        "Name": ["Alice", "Bob", "Charlie"],
        "Age": [25, 30, 35],
        "City": ["New York", "Los Angeles", "Chicago"],
    }
    df = pd.DataFrame(data)
    sorted_df = df.sort_values(by="Age", ascending=True)
    print(sorted_df)

    print("-------------------- 結合:縦(concat)")
    data1 = {"名前": ["田中", "渡辺"], "年齢": [34, 23], "出身地": ["大阪", "名古屋"]}
    data2 = {"名前": ["具志堅"], "年齢": [68], "出身地": ["沖縄"]}
    df1 = pd.DataFrame(data1)
    df2 = pd.DataFrame(data2)
    # 連結
    concated_df = pd.concat([df1, df2], axis=0)
    print(concated_df)

    print("-------------------- 結合:横(concat)")
    data1 = {"名前": ["田中", "渡辺", "具志堅"], "年齢": [34, 23, 68]}
    data2 = {
        "出身地": ["大阪", "名古屋", "沖縄"],
        "職業": ["教師", "エンジニア", "医者"],
    }

    df1 = pd.DataFrame(data1)
    df2 = pd.DataFrame(data2)

    concated_df = pd.concat([df1, df2], axis=1)
    print(concated_df)

    print("-------------------- 列の削除")
    data = {
        "Name": ["Alice", "Bob", "Charlie"],
        "Age": [25, 30, 35],
        "City": ["New York", "Los Angeles", "Chicago"],
    }

    df = pd.DataFrame(data)
    df_droped = df.drop(columns=["City"])
    print(df_droped)

    print("-------------------- 行の削除")
    data = {
        "Name": ["Alice", "Bob", "Charlie"],
        "Age": [25, 30, 35],
        "City": ["New York", "Los Angeles", "Chicago"],
    }

    df = pd.DataFrame(data)
    df_droped = df.drop(0)
    print(df_droped)

    print("-------------------- データの分割(レベルを指定して抽出)")
    data = {
        "名前": [
            "田中",
            "渡辺",
            "具志堅",
            "佐藤",
            "鈴木",
            "高橋",
            "伊藤",
            "山本",
            "中村",
            "山田",
        ],
        "年齢": [34, 23, 68, 29, 45, 31, 58, 42, 36, 27],
        "出身地": [
            "大阪",
            "名古屋",
            "沖縄",
            "東京",
            "福岡",
            "大阪",
            "名古屋",
            "東京",
            "福岡",
            "沖縄",
        ],
        "職業": [
            "教師",
            "エンジニア",
            "美容師",
            "教師",
            "エンジニア",
            "美容師",
            "教師",
            "エンジニア",
            "美容師",
            "教師",
        ],
        "年収": [500, 300, 1000, 600, 400, 800, 700, 450, 900, 550],
    }

    df = pd.DataFrame(data)
    df_over_40 = df.loc[df["年齢"] >= 40]
    print(df_over_40)

    print("-------------------- データの分割(indexを指定して抽出)")
    print("先頭5行")
    print(df.iloc[:5])
    print("末尾5行")
    print(df.iloc[-5:])

    print("-------------------- 条件抽出:query")
    high_engineer = df.query("年収 >=800")
    print(high_engineer)

    print("-------------------- 条件抽出:loc")
    filter_fd = df.loc[df["職業"] == "教師", ["名前", "年収"]]
    print(filter_fd)


if __name__ == "__main__":
    main()
