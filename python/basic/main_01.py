import copy
import datetime
import functools
import json
import os
import re


def main():
    print("execute main")

    # datetime
    print(datetime.date.today())
    print(datetime.datetime.now())

    # range
    print(">> range")
    for i in range(3):
        print(i)

    # list
    print(">> list")
    data_list = []
    data_list.append(1)
    data_list.append(2)
    data_list.append(3)
    print(data_list)
    data_list.pop(0)  # indexで削除する
    print(data_list)

    # deepcopy
    print(">> deepcopy")
    data_list2 = copy.deepcopy(data_list)
    data_list.pop(0)  # indexで削除する
    print(data_list)
    print(data_list2)

    # リスト内表記
    print(">> リスト内表記")
    data_list = [1, 2, 3, 4]
    data_list2 = [x * 2 for x in data_list]
    print(data_list2)

    # map(全リスト項目に対して処理し返す)
    print(">> map")
    datas = [1, 2, 3, 4]
    print(list(map(lambda x: x > 2, datas)))

    # filter(条件によりフィルターしたデータを返す)
    print(">> filter")
    datas = [1, 2, 3, 4]
    print(list(filter(lambda x: x > 2, datas)))

    # reduce()
    print(">> reduce")
    datas = [1, 2, 3, 4]
    result = functools.reduce(lambda result, x: result + x, datas)
    print(result)

    # リスト項目全体から判定する
    print(">> list判定")
    data_list = [100, 200, 300]
    print(all(map(lambda x: x >= 100, data_list)))  # 全部Trueの場合True
    print(any(map(lambda x: x == 100, data_list)))  # 一つでもTrueならTrue
    print(not any(map(lambda x: x < 100, data_list)))  # 全てFalseならTrue

    # set(ユニークデータ)、集合演算ができる
    print(">> set")
    data_sets = set()  # からの場合はset()で初期化
    data_sets.add(1)
    data_sets.add(2)
    data_sets.add(2)  # no error
    print(data_sets)  # ユニークなデータ

    # 辞書
    print(">> dic")
    dict = {}
    dict["a"] = 1
    dict["b"] = 2
    print(dict["a"])
    print(dict.get("c", -1))
    print("a" in dict)
    print("c" in dict)
    print(list(dict.items()))
    print(list(dict.keys()))
    print(list(dict.values()))

    # 動的なクラス
    class db:
        def __init__(self):
            self.port = 8080
            self.user = "user"
            self.password = "passwordd"

        def login(self):
            print("login!")

    dbinfo = db()
    dbinfo.login()

    # 置換
    line = "a,b,c"
    print(line.replace(",", ""))

    # 正規表現を使用
    print(re.sub(r"\d+", "999", "a123,b123,c123"))

    # maketransを使用
    table = str.maketrans({"1": "z"})
    print("a123,b123,c123".translate(table))

    # 記号などをまとめて取り除きたい場合に便利
    messy_text = "Price: [1,200] yen (tax-in)!"
    table = str.maketrans("", "", "[]()!")
    cleaned_text = messy_text.translate(table)
    print(f"Cleaned symbols: {cleaned_text}")


if __name__ == "__main__":
    main()
