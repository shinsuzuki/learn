import petl as etl
import requests
import json
import datetime
import oracledb

# from sqlalchemy import create_engine


def main():
    print("--> petl start\n")

    # ======================================================================
    # CSV
    # ======================================================================
    # ----------------------------
    print("== csv読込")
    table = etl.fromcsv("./data/example.csv")
    print(table)
    # +-----+-----+-----+
    # | foo | bar | baz |
    # +=====+=====+=====+
    # | a   | 1   | 3.4 |
    # +-----+-----+-----+
    # | b   | 2   | 7.4 |
    # +-----+-----+-----+
    # | c   | 6   | 2.2 |
    # +-----+-----+-----+
    # | d   | 9   | 8.1 |
    # +-----+-----+-----+

    # ----------------------------
    print("== カラムを変換,追加")
    table = etl.convert(table, "foo", "upper")
    table = etl.convert(table, "bar", int)
    table = etl.convert(table, "baz", float)
    table = etl.addfield(table, "quux", lambda row: (row.bar * row.baz))
    print(table)
    # +-----+-----+-----+--------------------+
    # | foo | bar | baz | quux               |
    # +=====+=====+=====+====================+
    # | A   |   1 | 3.4 |                3.4 |
    # +-----+-----+-----+--------------------+
    # | B   |   2 | 7.4 |               14.8 |
    # +-----+-----+-----+--------------------+
    # | C   |   6 | 2.2 | 13.200000000000001 |
    # +-----+-----+-----+--------------------+
    # | D   |   9 | 8.1 |  72.89999999999999 |
    # +-----+-----+-----+--------------------+

    print("== テーブルをフィルタリング")
    table = etl.select(table, lambda x: x.foo == "A" or x.foo == "C")
    print(table)
    # +-----+-----+-----+--------------------+
    # | foo | bar | baz | quux               |
    # +=====+=====+=====+====================+
    # | A   |   1 | 3.4 |                3.4 |
    # +-----+-----+-----+--------------------+
    # | C   |   6 | 2.2 | 13.200000000000001 |
    # +-----+-----+-----+--------------------+

    # ======================================================================
    # JSON
    # ======================================================================
    # ----------------------------
    print("== JSONを取得")
    res = requests.get("https://jsonplaceholder.typicode.com/comments?postId=1")
    item = json.loads(res.content)[0]
    print(json.dumps(item, indent=2))
    # {
    #   "postId": 1,
    #   "id": 1,
    #   "name": "id labore ex et quam laborum",
    #   "email": "Eliseo@gardner.biz",
    #   "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
    # }

    # ----------------------------
    print("== JSONを取得、リストをループして処理")
    res = requests.get("https://jsonplaceholder.typicode.com/comments?postId=1")
    # json_str = json.loads(res.content)["body"]
    items = json.loads(res.content)
    for item in items:
        print(json.dumps(item["name"], indent=2))

    # "id labore ex et quam laborum"
    # "quo vero reiciendis velit similique earum"
    # "odio adipisci rerum aut animi"
    # "alias odio sit"
    # "vero eaque aliquid doloribus et culpa"

    # ----------------------------
    print("== JSONを取得、リストから指定したプロパティをテーブルへ変換")
    res = requests.get("https://jsonplaceholder.typicode.com/comments?postId=1")
    items = json.loads(res.content)
    table_a = etl.fromdicts(items, header=["id", "name", "email"])
    print(table_a)
    # +----+-------------------------------------------+------------------------+
    # | id | name                                      | email                  |
    # +====+===========================================+========================+
    # |  1 | id labore ex et quam laborum              | Eliseo@gardner.biz     |
    # +----+-------------------------------------------+------------------------+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com |
    # +----+-------------------------------------------+------------------------+
    # |  3 | odio adipisci rerum aut animi             | Nikita@garfield.biz    |
    # +----+-------------------------------------------+------------------------+
    # |  4 | alias odio sit                            | Lew@alysha.tv          |
    # +----+-------------------------------------------+------------------------+
    # |  5 | vero eaque aliquid doloribus et culpa     | Hayden@althea.biz      |
    # +----+-------------------------------------------+------------------------++

    # ----------------------------
    print("== テーブルをフィルタリング")
    table_b = etl.select(table_a, lambda x: x.id == 2 or x.id == 3)
    print(table_b)
    # +----+-------------------------------------------+------------------------+
    # | id | name                                      | email                  |
    # +====+===========================================+========================+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com |
    # +----+-------------------------------------------+------------------------+
    # |  3 | odio adipisci rerum aut animi             | Nikita@garfield.biz    |
    # +----+-------------------------------------------+------------------------+

    # ----------------------------
    print("== テーブルにカラムを追加")
    table_c = etl.addfield(table_b, "created_date", datetime.datetime.now())
    print(table_c)
    # +----+-------------------------------------------+------------------------+----------------------------+
    # | id | name                                      | email                  | created_date               |
    # +====+===========================================+========================+============================+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com | 2025-12-20 01:23:12.797398 |
    # +----+-------------------------------------------+------------------------+----------------------------+
    # |  3 | odio adipisci rerum aut animi             | Nikita@garfield.biz    | 2025-12-20 01:23:12.797398 |
    # +----+-------------------------------------------+------------------------+----------------------------+

    # ----------------------------
    print("== テーブルからカラムを削除")
    table_d = etl.cutout(table_c, "created_date")
    print(table_d)
    # +----+-------------------------------------------+------------------------+
    # | id | name                                      | email                  |
    # +====+===========================================+========================+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com |
    # +----+-------------------------------------------+------------------------+
    # |  3 | odio adipisci rerum aut animi             | Nikita@garfield.biz    |
    # +----+-------------------------------------------+------------------------+

    # ----------------------------
    print("== テーブルの先頭から1行出力")
    table_e = etl.head(table_d, 1)
    print(table_e)
    # +----+-------------------------------------------+------------------------+
    # | id | name                                      | email                  |
    # +====+===========================================+========================+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com |
    # +----+-------------------------------------------+------------------------+

    # ----------------------------
    print("== テーブルをレコード型のリストへ変換")
    table_f = etl.records(table_a)
    for item in table_f:
        print(f"id={item.get('id')}, name={item.get('name')}, email={item.get('email')}")
    # id=1, name=id labore ex et quam laborum, email=Eliseo@gardner.biz
    # id=2, name=quo vero reiciendis velit similique earum, email=Jayne_Kuhic@sydney.com
    # id=3, name=odio adipisci rerum aut animi, email=Nikita@garfield.biz
    # id=4, name=alias odio sit, email=Lew@alysha.tv
    # id=5, name=vero eaque aliquid doloribus et culpa, email=Hayden@althea.biz

    # ----------------------------
    print("== テーブルをソート(email)")
    table_sorted = etl.sort(table_a, "email")
    print(table_sorted)
    # +----+-------------------------------------------+------------------------+
    # | id | name                                      | email                  |
    # +====+===========================================+========================+
    # |  1 | id labore ex et quam laborum              | Eliseo@gardner.biz     |
    # +----+-------------------------------------------+------------------------+
    # |  5 | vero eaque aliquid doloribus et culpa     | Hayden@althea.biz      |
    # +----+-------------------------------------------+------------------------+
    # |  2 | quo vero reiciendis velit similique earum | Jayne_Kuhic@sydney.com |
    # +----+-------------------------------------------+------------------------+
    # |  4 | alias odio sit                            | Lew@alysha.tv          |
    # +----+-------------------------------------------+------------------------+
    # |  3 | odio adipisci rerum aut animi             | Nikita@garfield.biz    |
    # +----+-------------------------------------------+------------------------+

    # ----------------------------
    print("== テーブルをCSVに保存")
    etl.tocsv(table_d, "output_table_d.csv")
    # == otuput_table_d.csv ==
    # id,name,email
    # 2,quo vero reiciendis velit similique earum,Jayne_Kuhic@sydney.com
    # 3,odio adipisci rerum aut animi,Nikita@garfield.biz

    # ----------------------------
    print("== テーブルをJSONに保存")
    etl.tojson(table_d, "output_table_d.json", indent=2)
    # == output_table_d.json ==
    # [
    #   {
    #     "id": 2,
    #     "name": "quo vero reiciendis velit similique earum",
    #     "email": "Jayne_Kuhic@sydney.com"
    #   },
    #   {
    #     "id": 3,
    #     "name": "odio adipisci rerum aut animi",
    #     "email": "Nikita@garfield.biz"
    #   }
    # ]

    # ----------------------------
    print("== DBよりデータを取得(oracledb)")
    ORACLE_USER = "dbuser"
    ORACLE_PASSWORD = "sasa"
    ORACLE_HOST = "localhost"
    ORACLE_PORT = "1521"
    ORACLE_SERVICE = "orcl"

    # Oracleへの直接接続
    connection = oracledb.connect(
        user=ORACLE_USER,
        password=ORACLE_PASSWORD,
        dsn=f"{ORACLE_HOST}:{ORACLE_PORT}/{ORACLE_SERVICE}",
    )

    table = etl.fromdb(connection, "select * from employee")
    print(table)
    # +-----+---------+-----------+--------+---------------------+---------------+
    # | ID  | NAME    | JOB_TITLE | SALARY | HIRE_DATE           | DEPARTMENT_ID |
    # +=====+=========+===========+========+=====================+===============+
    # | 101 | Alice   | Manager   |  80000 | 2020-01-01 00:00:00 |            10 |
    # +-----+---------+-----------+--------+---------------------+---------------+
    # | 102 | Bob     | Sales Rep |  50000 | 2021-05-15 00:00:00 |            10 |
    # +-----+---------+-----------+--------+---------------------+---------------+
    # | 103 | Charlie | Sales Rep |  52000 | 2022-10-10 00:00:00 |            10 |
    # +-----+---------+-----------+--------+---------------------+---------------+
    # | 201 | David   | Engineer  |  75000 | 2019-03-20 00:00:00 |            20 |
    # +-----+---------+-----------+--------+---------------------+---------------+
    # | 202 | Eve     | Engineer  |  75000 | 2023-07-07 00:00:00 |            20 |
    # +-----+---------+-----------+--------+---------------------+---------------+

    print("\n<-- petl end")


if __name__ == "__main__":
    main()
