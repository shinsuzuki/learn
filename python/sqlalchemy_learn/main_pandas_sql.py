import os
from utils.db.database import get_dbsession, engine, select, insert, update, delete, func
import pandas as pd


def main():
    os.system("cls")

    """メイン実行関数"""
    # ============================================================ セレクト系を試す
    # FastAPIの依存性注入（DI）システムが内部的に with 句と同じ役割を果たしています。
    # FastAPIではWithは不要です

    with get_dbsession() as db:
        print("pandas to sql")

        df = pd.read_csv("./employee_data.csv", encoding="utf-8")

        # 2. 【重要】文字列をdatetimeオブジェクトに変換
        # これを行わないと、Oracleは '2025-01-01 00:00:00' という文字列を
        # そのままDATE型に入れようとして、書式不一致エラー(ORA-01861)になります。
        df["HIRE_DATE"] = pd.to_datetime(df["HIRE_DATE"])

        try:
            # if_exists のオプション:
            # 'append': 既存テーブルに追記
            # 'replace': テーブルを削除して新規作成（注意！）
            # 'fail': すでにテーブルがあるとエラー
            table_name = "employee"
            df.to_sql(
                name=table_name.lower(),  # SQLAlchemyの仕様上、小文字で渡すとOracle側で大文字として扱われます
                con=engine,
                if_exists="append",
                index=False,  # DataFrameのIndexは列として登録しない
                chunksize=5000,  # 5000行ごとにコミット（大量データ時の高速化）
            )
            print(f"Successfully uploaded data to {table_name}.")
        except Exception as e:
            print(f"Error uploading to Oracle: {e}")


if __name__ == "__main__":
    main()
