import petl as etl


def run_petl_demo():
    # 1. データの抽出 (Extract)
    # リストのリスト（ヘッダー付き）からテーブルを作成
    table1 = [
        ["id", "name", "city"],
        [1, "Alice", "Tokyo"],
        [2, "Bob", "Osaka"],
        [3, "Charlie", "Nagoya"],
    ]

    table2 = [
        ["user_id", "amount"],
        [1, 1000],
        [2, 2500],
        [4, 500],
    ]

    print("--- Original Table ---")
    print(etl.look(table1))

    # 2. データの変換 (Transform)
    # フィルタリング: city が 'Tokyo' の行のみ抽出
    tokyo_users = etl.select(table1, lambda r: r.city == "Tokyo")

    # 列の変換: name を大文字にする
    transformed_table = etl.convert(table1, "name", lambda v: v.upper())

    # 列の追加: 固定値や計算結果を追加
    added_col = etl.addfield(transformed_table, "country", "Japan")

    # 3. 結合 (Join)
    # table1 の 'id' と table2 の 'user_id' で結合（内部結合）
    joined_table = etl.join(table1, table2, lkey="id", rkey="user_id")

    print("--- Joined & Transformed Table ---")
    print(etl.look(joined_table))

    # 4. 集計 (Aggregation)
    # 合計などを計算
    summary = etl.aggregate(table2, "user_id", aggregation=sum, value="amount")
    print("--- Summary (Aggregation) ---")
    print(etl.look(summary))

    # 5. 書き出し (Load)
    # CSVファイルへの保存（実際には実行されませんが、構文の例です）
    etl.tocsv(joined_table, "output.csv")

    # 別の形式（辞書のリスト）への変換
    data_dict = etl.dicts(joined_table)
    print("--- Output as Dictionaries ---")
    for row in data_dict:
        print(row)


if __name__ == "__main__":
    run_petl_demo()
