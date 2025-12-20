import pandas as pd
import numpy as np


def main():
    print(">> start pandas")
    # ========================================

    # 一次元データ
    print(">> 一次元データ")
    ser = pd.Series([10, 20, 30])
    print(ser)

    # 2次元データ
    print(">> 2次元データ")
    pd_df = pd.DataFrame(
        [
            [10, "a", True],
            [20, "b", False],
            [30, "c", True],
            [40, "d", True],
        ]
    )
    print(pd_df)

    # DataFrameの概要
    print(">> DataFrameの概要")
    np_df = pd.DataFrame(np.arange(100).reshape(25, 4))
    print(np_df)

    print(">> DataFrameの先頭の5行")
    print(np_df.head())

    print(">> DataFrameの末尾の5行")
    print(np_df.tail())

    print(">> DataFrameのサイズ")
    print(np_df.shape)

    # インデックス名、カラム名
    print(">> インデックス名、カラム名")
    df = pd.DataFrame(np.arange(6).reshape((3, 2)))
    df.index = ["01", "02", "03"]
    df.columns = ["A", "B"]
    print(df)

    # dictからDataFrameを作成
    print(">> dictからDataFrameを作成")
    df = pd.DataFrame({"A列": [1, 2, 3], "B列": [2, 3, 4]})
    print(df)

    # ========================================
    print("<< end pandas")


if __name__ == "__main__":
    main()
