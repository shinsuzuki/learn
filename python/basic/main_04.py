import copy
import json
import os
import shutil
import jsons
from typing import Any


def main():
    print("--> start main_03\n")
    # ======================================================================

    # --------------------
    # 辞書を更新、型が違う場合はpylanceはエラーとなるが、動きます
    dic_1 = {"a": 1, "b": 2}
    print(dic_1)
    # {'a': 1, 'b': 2}

    params = {"z": 99, "y": 100}
    params.update(dic_1)
    print(params)
    # {'z': 99, 'y': 100, 'a': 1, 'b': 2}

    # --------------------
    print("-- オプショナルの書き方")
    data: str | None = None
    data = "abc"
    print(data)
    data = None
    print(data)
    data = 100  # pylanceでエラー、動きます
    print(data)

    def func_a(**d1) -> str | None:
        # return 100
        # return "!abac"
        print(d1)
        return None

    func_a(a=1, b=2)

    # --------------------
    print("-- 内包表記")
    dic = {"a": 1, "b": 2, "c": 3, "d": 4}
    print("リスト")
    list = [f"{k}:{v}" for k, v in dic.items() if v > 1]
    print(list)

    print("辞書")
    filters = {"a", "b"}
    dic_filter = {f"{k}:{v}" for k, v in dic.items() if k in filters}
    print(dic_filter)

    # --------------------
    print("-- **の仕組み")

    # 仕組みの解説： **（ダブルアスタリスク）とは？
    # ** は、辞書の「キー」を「引数名」に、「値」を「引数の値」に変換して関数やクラスに渡す指示子です。
    # data = {"id": 1, "name": "Tanaka"}
    # Employee(**data)
    # Python内部では Employee(id=1, name="Tanaka") と解釈される。
    # 階層が深い場合はPydanticを利用する

    class Person:
        def __init__(self, name: str, old: int):
            self.name = name
            self.old = old

    person_1 = Person(name="sato", old=99)
    print(f"person_1:{jsons.dumps(person_1)}")

    dic_1: dict[str, Any] = {"name": "aoi", "old": 100}
    person_2 = Person(**dic_1)
    print(f"person_2:{jsons.dumps(person_2)}")

    # ======================================================================
    print("\n<-- end main_03")


if __name__ == "__main__":
    main()
