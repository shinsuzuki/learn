import csv
import os
import sys
import oracledb


# oracle接続情報
ORACLE_USER = "dbuser"
ORACLE_PASSWORD = "sasa"
ORACLE_CONNECT_STRING = "localhost:1521/orcl"
ORACLE_HOST = "localhost"
ORACLE_PORT = "1521"
ORACLE_SERVICE = "orcl"
DATABASE_URL = f"oracle+oracledb://{ORACLE_USER}:{ORACLE_PASSWORD}@{ORACLE_HOST}:{ORACLE_PORT}/{ORACLE_SERVICE}"


def main():
    print("--> start")

    # if len(sys.argv) != 2:
    #     print("usage: parameter error!")
    #     sys.exit(1)
    #
    # csv_file = sys.argv[0]
    # table_name = sys.argv[1]

    # まず固定で行う
    csv_file = "t_user_data.csv"
    table_name = "t_user"

    # with get_dbsession() as db:
    #     print("pandas to sql")

    connection = oracledb.connect(user=ORACLE_USER, password=ORACLE_PASSWORD, dsn=ORACLE_CONNECT_STRING)
    cursor = connection.cursor()

    try:
        with open(csv_file, encoding="utf-8") as f:
            cursor.execute(
                "select  column_name, data_type from user_tab_columns where table_name = :1", [table_name.upper()]
            )

            # --- カラム情報を取得 ---
            print("--- カラム情報 ---")
            column_info_dic = {}
            column_info_list = cursor.fetchall()
            for col in column_info_list:
                column_info_dic[col[0]] = col[1]
                print(f"  {col}")

            # --- CSVファイルのヘッダーからカラム名を取得 ---
            print("--- CSVファイルのヘッダーからカラム名 ---")
            reader = csv.reader(f)
            column_name_list = next(reader)
            for column_name in column_name_list:
                print(f"  {column_name}")

            # --- 動的にINSERT分を生成 ---
            column_list_str = ", ".join(column_name_list)
            binds_str = ""
            bind_list = []

            # カラムの種別ごとに対応
            for i, column in enumerate(column_name_list):
                table_type = column_info_dic[column]

                if table_type.startswith("TIMESTAMP"):
                    # TIMESTAMP型は桁数を指定しない場合はデフォルト値の6で設定されます
                    # TIMESTAMPなら以下のフォーマットと想定する
                    bind_list.append(f"TO_TIMESTAMP(:{i+1}, 'YYYY-MM-DD HH24:MI:SS')")
                elif table_type == "DATE":
                    bind_list.append(f"TO_DATE(:{i+1}, 'YYYY-MM-DD')")
                else:
                    bind_list.append(f":{i+1}")

            # values を構築
            bind_list_str = ",".join(bind_list)

            # insert を構築
            insert_sql = f"insert into {table_name} ({column_list_str}) values ({bind_list_str})"
            print("--- insert_sql ---")
            print(f"  {insert_sql}")

            # --- パラメータを作成 ---
            data_list = []
            for row in reader:
                data_list.append(tuple(row))

            # --- 一括実行 ---
            cursor.executemany(insert_sql, data_list)

        # --- コミット---
        connection.commit()

    except Exception as e:
        connection.rollback()
        print(f"An exception occurred. {e}")
    finally:
        cursor.close()
        connection.close()
        print("<-- end")
        pass


if __name__ == "__main__":
    main()
