import pandas as pd
import numpy as np
import oracledb
from sqlalchemy import create_engine, inspect, types
from sqlalchemy.engine import Engine


class OracleTableUploader:
    """
    Oracleのテーブル定義を自動取得し、CSVデータを適切な型で
    一括登録するためのユーティリティクラス。
    """

    def __init__(self, user, password, dsn):
        """
        SQLAlchemyエンジンを初期化します。
        dsnは 'host:port/service_name' または TNS名を指定します。
        """
        connection_url = f"oracle+oracledb://{user}:{password}@{dsn}"
        self.engine = create_engine(connection_url)

    def _get_table_schema(self, table_name: str):
        """
        SQLAlchemyのInspectorを使用して、既存テーブルの型情報を取得します。
        """
        inspector = inspect(self.engine)
        columns = inspector.get_columns(table_name)

        if not columns:
            raise ValueError(f"Table '{table_name}' not found or no columns accessible.")

        # カラム名をキー、SQLAlchemyの型オブジェクトを値とする辞書を作成
        schema_map = {col["name"].lower(): col["type"] for col in columns}
        return schema_map

    def upload_csv(self, csv_path: str, table_name: str, if_exists: str = "append", encoding: str = "utf-8"):
        """
        CSVを読み込み、テーブル定義に合わせた型指定でOracleへアップロードします。
        """
        # 1. ターゲットテーブルのスキーマ情報を取得
        target_schema = self._get_table_schema(table_name)

        # 2. CSVの読み込み
        # ここでは一旦全て文字列として読み込み、後で変換をかけるのが安全
        df = pd.read_csv(csv_path, encoding=encoding)

        # カラム名を小文字に統一してマッチングしやすくする（Oracleは通常大文字だがSQLAlchemyは柔軟）
        df.columns = [c.lower() for c in df.columns]

        # 3. データ型の調整 (NULL対応)
        # ターゲットテーブルに存在するカラムのみを対象にする
        upload_dtype_config = {}
        for col in df.columns:
            if col in target_schema:
                col_type = target_schema[col]
                upload_dtype_config[col] = col_type

                # 数値型(Integer)の場合のNULL対応: 'Int64'への変換
                if isinstance(col_type, (types.Integer, types.BIGINT)):
                    df[col] = pd.to_numeric(df[col], errors="coerce").astype("Int64")

                # 日付型の場合の変換
                elif isinstance(col_type, (types.Date, types.DateTime)):
                    df[col] = pd.to_datetime(df[col], errors="coerce")

        # 4. to_sqlの実行
        try:
            # Oracle側は通常大文字なので、テーブル名を調整
            df.to_sql(
                name=table_name.upper(),
                con=self.engine,
                if_exists=if_exists,
                index=False,
                dtype=upload_dtype_config,
                chunksize=5000,  # 大量データ対応
            )
            print(f"Successfully uploaded {len(df)} rows to {table_name}.")
        except Exception as e:
            print(f"Error during to_sql: {e}")
            raise


# --- 利用例 ---
if __name__ == "__main__":
    # 接続情報
    USER = "my_user"
    PASS = "my_password"
    DSN = "localhost:1521/xe"

    uploader = OracleTableUploader(USER, PASS, DSN)

    # 既存の 'employees' テーブルに対して 'data.csv' をアップロード
    # 1. テーブル情報を取得
    # 2. CSVを読み込み、IntegerカラムのNULLをInt64として処理
    # 3. to_sqlで流し込み
    # uploader.upload_csv("employees_data.csv", "employees")


"""
Oracleのテーブル定義（スキーマ）を自動的に取得し、
Pandasのデータ型をそれに適合させてからto_sqlを実行する汎用的なユーティリティライブラリを作成しました。

このライブラリは、既存テーブルの各カラムのデータ型（VARCHAR2, NUMBER, DATEなど）を調査し、
SQLAlchemyの型オブジェクトにマッピングすることで、NULL値や型不一致のエラーを最小限に抑えます。

Oracleデータ移行ユーティリティ
12月22日 0:17

このライブラリの特徴
動的な型取得 (inspect): SQLAlchemyのinspect機能を使用して、
実行時にOracle上の実際のカラム定義（NUMBER, VARCHAR2, DATE等）を取得します。
これにより、手動で辞書を作成する必要がありません。

NULL許容整数の処理: Pandasで最もトラブルになりやすい「整数の欠損値」を、Int64（Nullable Integer）にキャストすることで、.0が付加された浮動小数点数として登録されるのを防ぎます。
日付の自動変換: 定義がDateやDateTimeの場合、pd.to_datetimeを使用して文字列から日付オブジェクトへ変換し、OracleのDATE型へ正しくマッピングします。
チャンク処理: chunksizeを指定しているため、数万件規模のCSVでもメモリ不足やタイムアウトを抑えて転送可能です。

注意事項
テーブルの存在: このコードは「既存のテーブル」に対して型を合わせる設計です。
テーブルが存在しない場合は_get_table_schemaでエラーになります。

大文字・小文字: Oracleは内部的にオブジェクト名を大文字で保持するため、
ライブラリ内でupper()やlower()を使用してマッチングを調整しています。

"""
