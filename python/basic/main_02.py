import copy
import json
import os
import shutil
from datetime import datetime, date
from pathlib import Path


def main():
    print("execute main_2")

    # ----------------------------------------------------------------------
    # enumerate(iterable, start)
    # ----------------------------------------------------------------------
    print("--- indexと値を出力 (start=0) ---")
    for i, item in enumerate(["a", "b", "c"]):
        print(f"{i}={item}")
    # 0=a
    # 1=b
    # 2=c

    print("--- indexと値を出力 (start=1) ---")
    for i, item in enumerate(["a", "b", "c"], start=1):
        print(f"{i}={item}")
    # 1=a
    # 2=b
    # 3=c

    # ----------------------------------------------------------------------
    # zip
    # ----------------------------------------------------------------------
    print("--- zip (複数のリストを同時に回す) ---")
    hiragana = ["あ", "い", "う", "え", "お"]
    katakana = ["ア", "イ", "ウ", "エ", "オ"]

    for h, k in zip(hiragana, katakana, strict=True):
        print(f"{h}:{k}")
    # あ:ア
    # い:イ
    # う:ウ
    # え:エ
    # お:オ

    # ----------------------------------------------------------------------
    # range
    # ----------------------------------------------------------------------
    print("--- range (連続した数値を作成) ---")
    for i in range(4):
        print(i)
    # 0
    # 1
    # 2
    # 3

    # ----------------------------------------------------------------------
    # os.environ
    # ----------------------------------------------------------------------
    print("--- 環境変数を取得 ---")
    print(os.environ.get("APP_KEY", "default_value"))
    # main_app_key

    # ----------------------------------------------------------------------
    # datetime
    # ----------------------------------------------------------------------
    print("--- 時刻 ---")
    print(date.today())  # 2025-12-26
    print(datetime.now())  # 2025-12-26 00:01:45.275014
    print(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))  # 2025-12-26 00:01:45

    # ----------------------------------------------------------------------
    # フォルダ、ファイルの作成、削除
    # ----------------------------------------------------------------------
    print("--- フォルダ内のファイルとフォルダを取得 ---")
    for file in list(Path("data").iterdir()):
        print(file)

    print("--- フォルダ内のDIRのみ取得 ---")
    for dir_name in [f for f in Path("data").iterdir() if f.is_dir()]:
        print(dir_name)

    print("--- フォルダ内のファイルのみ取得 ---")
    for f in [f for f in Path("data").iterdir() if f.is_file()]:
        print(f"ファイルパス:{f},ファイル名:{f.name}")
        with open(f, "r", encoding="utf-8") as rf:
            print(rf.readlines())

    print("--- フォルダ内のファイルとフォルダを再帰的に取得 ---")
    for file in list(Path("data").glob("**/*")):
        print(file)

    print("--- フォルダ内のフォルダを再帰的に取得 ---")
    for dir_name in [f for f in Path("data").glob("**/*") if f.is_dir()]:
        print(dir_name)

    print("--- ファイルの絶対パスを取得 ---")
    full_path = Path("data").resolve()
    print(full_path)

    print("--- パスを結合する ---")
    new_path = Path("data") / "new_1"
    print(new_path)

    print("--- パスの存在を確認する ---")
    print(full_path.exists())
    print(new_path.exists())

    print("--- ファイルを作成する ---")
    new_file = Path("data/test3.txt")
    print(new_file.exists())
    new_file.touch()
    print(new_file.exists())
    new_file.unlink(missing_ok=True)  # ファイルが存在しなくてもエラーにしない
    print(new_file.exists())

    print("--- DIRを作成する ---")
    new_dir = Path("data/data2")
    print(new_dir.exists())
    new_dir.mkdir(exist_ok=True)
    print(new_dir.exists())
    new_dir.rmdir()  # rmdirは空のDIRのみ削除できる
    print(new_dir.exists())

    print("--- DIRを削除する(中身のあるも) ---")
    new_dir = Path("data/data3")
    new_dir.mkdir(exist_ok=True)
    new_file = Path("data/data3/test1.txt")
    new_file.touch()
    shutil.rmtree(new_dir)  # 対象DIRを削除できる
    print(new_dir.exists())

    # ----------------------------------------------------------------------
    # json
    # ----------------------------------------------------------------------
    print("--- JSON文字列をオブジェクトへ---")
    json_str = '{"name": "akutsu", "age": 20, "items": ["A002", "A003"]}'
    json_obj = json.loads(json_str)
    print(f"json_obj: {json_obj}")  # json_obj: {'name': 'akutsu', 'age': 20, 'items': ['A002', 'A003']}
    print(f"json_obj.name: {json_obj['name']}")  # json_obj.name: akutsu
    print(f"json_obj.items[0]: {json_obj['items'][0]}")  # json_obj.items: A002

    print("--- JSONファイルをオブジェクトへ---")
    with open("./sample.json") as rf:
        json_obj = json.load(rf)
        print(f"json_obj: {json_obj}")
    # json_obj: [{'name': 'saito', 'age': 23, 'item': ['A001', 'A002']}, {'name': 'tanaka', 'age': 24, 'item': ['A003', 'A004']}]

    print("--- オブジェクトをJSON文字列へ---")
    user = {"id": 100, "age": None, "is_active": False, "point": 100}
    json_str = json.dumps(user)
    print(json_str)

    print("--- オブジェクトをJSONファイルで保存---")
    user = {"id": 100, "age": None, "is_active": False, "point": 100}
    with open("user.json", "w") as wf:
        json.dump(user, wf)
    # {"id": 100, "age": null, "is_active": false, "point": 100}

    # ----------------------------------------------------------------------
    # リスト内表記
    # ----------------------------------------------------------------------
    print("--- リスト内表記 (条件追加) ---")
    x_list = [x for x in range(5) if x < 3]
    print(x_list)
    # [0, 1, 2]

    print("--- リスト内表記 (結果を計算) ---")
    x_list = [x * 2 for x in range(5) if x < 3]
    print(x_list)
    # [0, 2, 4]

    # ----------------------------------------------------------------------
    # 三項演算子
    # ----------------------------------------------------------------------
    print("--- 三項演算子 ---")
    value = 100
    result = "合格" if value >= 100 else "不合格"
    print(result)
    # 合格

    # ----------------------------------------------------------------------
    # 0埋め
    # ----------------------------------------------------------------------
    print("--- 0埋め ---")
    value = 99
    print(f"{value:05}")
    # 00099

    # ----------------------------------------------------------------------
    # カンマ区切り
    # ----------------------------------------------------------------------
    print("--- カンマ区切り ---")
    price = 12345
    print(f"{price:,}")
    # 12,345

    # ----------------------------------------------------------------------
    # 小数点指定
    # ----------------------------------------------------------------------
    print("--- 小数点 ---")
    rate = 12.3456789
    print(f"{rate:.3f}")  # 四捨五入
    # 12.346

    # ----------------------------------------------------------------------
    # ディープコピー
    # ----------------------------------------------------------------------
    print("--- ディープコピー ---")
    x = [1, 2, 3, 4]
    y = copy.deepcopy(x)
    x.remove(3)
    print(f"x={x},y={y}")


if __name__ == "__main__":
    main()
