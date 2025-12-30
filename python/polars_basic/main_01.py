import polars as pl
from datetime import datetime


def main():
    print("--> start")

    # 1. データの作成
    # 辞書からDataFrameを作成します
    df = pl.DataFrame(
        {
            "id": [1, 2, 3, 4, 5],
            "name": ["Alice", "Bob", "Charlie", "David", "Eve"],
            "age": [25, 30, 35, 40, 25],
            "city": ["Tokyo", "Osaka", "Tokyo", "Nagoya", "Osaka"],
            "sales": [100.5, 200.0, 150.0, 300.0, 120.0],
            "joined_at": ["2023-01-10", "2023-02-15", "2023-03-20", "2023-04-25", "2023-05-30"],
        }
    )

    print("\n--- 初期データ ---")
    print(df)

    # 2. 基本的な抽出と選択 (Select, Filter)
    print("\n--- 抽出、フィルター ---")
    df_fileted = df.select(
        [
            pl.col("name"),
            pl.col("age"),
            (pl.col("sales") * 1.1).alias("sales_with_tax"),
        ]
    ).filter(
        pl.col("age") > 30,
    )

    print(df_fileted)
    # print(df.filter(pl.col("age") > 30))

    # 3. 集計 (Groupby / Aggregate)
    print("\n--- 集計 (Groupby / Aggregate) ---")
    # Pandasのgroupbyに似ていますが、aggの中で複数の処理を並列実行できます
    summary = df.group_by("city").agg(
        [
            pl.col("sales").sum().alias("total_sales"),
            pl.col("age").mean().alias("avg_age"),
            pl.col("name").count().alias("user_count"),
        ]
    )

    print("\n--- 都市別の集計 ---")
    print(summary)

    # 4. 型変換と日付操作
    print("\n--- 型変換と日付操作 ---")
    # 文字列を日付型に変換し、曜日を取得します
    df_dt = df.with_columns(
        [
            pl.col("joined_at").str.to_date("%Y-%m-%d"),
        ]
    ).with_columns([pl.col("joined_at").dt.weekday().alias("weekday_num")])

    print("\n--- 日付変換後のデータ ---")
    print(df_dt)

    # 5. Lazy（遅延実行）モード
    # 大規模データを扱う際は、このモードで最適化を効かせます
    print("\n--- Lazy（遅延実行）モード ---")
    lazy_plan = df.lazy().filter(pl.col("city") == "Tokyo").group_by("city").agg(pl.col("sales").max())

    # collect() を呼ぶまで計算は開始されません
    print("\n--- Lazyモードの結果 (collect実行時) ---")
    print(lazy_plan.collect())

    # 6. CSVへの書き出し
    print("\n--- CSVへの書き出し ---")
    # df.write_csv("output.csv")

    print("<-- end")


if __name__ == "__main__":
    main()
