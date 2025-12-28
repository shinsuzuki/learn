import copy
import json
import os
import shutil


def main():
    # ======================================================================
    print("--> start main_03\n")
    # ======================================================================

    print("------ 除算(浮動小数) ------")
    # 除算
    print(4 / 3)
    # 1.3333333333333333

    print("------ 除算(切り捨て) ------")
    print(4 // 3)
    # 1

    print("------ 演算(plus, ++はできない) ------")
    v = 1
    v = v + 2
    v += 3
    print(v)

    print("------ 改行 ------")
    # fmt: off
    # スラッシュで改行できる
    v = 1 + 2 \
    + 3
    print(v)

    # カッコ内なら改行OK
    v = (
        1
        + 2
        + 3
    )

    print(v)
    # fmt: on

    print("------ 文字列繰り返し ------")
    print("=" * 10 + " abc " + "=" * 10)
    # ========== abc ==========

    print("------ スライス ------")
    base = "0123456789"
    # 先頭オフセットは含まれる、末尾オフセットは含まれない
    # 開始位置がプラスの場合は先頭を 0 とした位置から開始します。

    # all
    print(base[:])
    # 0123456789

    # 前から7つ目～末尾まで
    print(base[7:])
    # 789

    # 前から1つ目～7つ目まで
    print(base[1:8])
    # 1234567

    # 開始位置にマイナスを指定すると、後ろからn番目の要素から開始して、最後まで取得する」という動きになります
    # 「マイナスのときは -0 が存在しないため、-1 から数え始めます

    # 後ろから3つ目～末尾まで
    print(base[-3:])
    # 789

    # 後ろから6つ目～3つ目まで(文字列の末尾（右側）から数える、スライスのルールでは終了位置を含まない)
    print(base[-6:-2])  #
    # 4567

    # 後ろから4つ目以降を除く
    print(base[:-4])
    # 012345

    print("------ split, join------")
    # split
    tasks = "a,b,c,d"
    print(tasks.split(","))
    # ['a', 'b', 'c', 'd']

    # join
    print("-".join(["a", "b", "c", "d"]))
    # a-b-c-d

    print("------ list ------")
    print("-- リストの結合(+)")
    l1 = [1, 2, 3, 4]
    l2 = [5, 6, 7, 8]
    l3 = l1 + l2
    print(l3)
    # [1, 2, 3, 4, 5, 6, 7, 8]

    # リストの結合
    print("-- リストの結合(extend)")
    l1.extend(l2)
    print(l1)
    # [1, 2, 3, 4, 5, 6, 7, 8]

    print("------ dict ------")
    print("-- 辞書作成")
    d1 = {
        "a": "abc",
        "b": "def",
    }
    print(d1)
    # {'a': 'abc', 'b': 'def'}

    print("-- 空の辞書から作成")
    d1 = {}
    d1["z"] = "xyz"
    print(d1)
    # {'z': 'xyz'}

    print("-- 辞書を配列から生成")
    seeds = [["a", 1], ["b", 2]]
    d1 = dict(seeds)
    print(d1)
    # {'a': 1, 'b': 2}

    print("-- 取得")
    print(d1.get("a", "default value"))

    print("-- 取得(デフォルト)")
    print(d1.get("c", "default value"))

    print("-- 結合")
    d1 = {
        "a": "abc",
        "b": "def",
    }
    d2 = {
        "b": "ghi",
        "c": "jkl",
    }
    d1.update(d2)
    print(d1)
    # {'a': 'abc', 'b': 'ghi', 'c': 'jkl'}

    print("-- 削除")
    del d1["b"]
    print(d1)
    # {'a': 'abc', 'c': 'jkl'}

    print("------ 集合------")
    print("-- 定義{}")
    s1 = {1, 2, 3, 1, 2, 3}
    print(s1)

    print("-- add")
    s1 = set()
    s1.add(1)
    s1.add(2)
    print(s1)

    print("-- 和集合演算子(|)")
    a = {1, 2}
    b = {2, 3}
    print(a | b)
    print(a.union(b))
    # {1, 2, 3}

    print("-- 積集合演算子(&)")
    a = {1, 2}
    b = {2, 3}
    print(a & b)
    print(a.intersection(b))
    # {2}

    print("-- 差合演算子(&)")
    a = {1, 2}
    b = {2, 3}
    print(a - b)
    # {1}

    print("------ 関数 ------")
    print("-- *argsにTuppleとして設定")

    def func_a(*args):
        print(args)

    func_a(1, 2, 3, 4)
    # (1, 2, 3, 4)

    print("-- 末尾の*argsにTuppleとして設定")

    def func_b(r1, r2, *args):
        print(r1)
        print(r2)
        print(args)

    func_b(1, 2, 3, 4, 5)
    # 1
    # 2
    # (3, 4, 5)

    print("-- **キーワードによる辞書化")

    # 引数の前にアスタリスクを2つ（**）付けると、
    # 呼び出し側で指定した「名前=値」のセットが、
    # 関数内部では「辞書（dict）」としてまとめられます。
    # 通常の引数（位置引数）と一緒に使う場合は、必ず **kwargs を最後に書きます。
    def func_c(**kwargs):
        print(kwargs)
        for key, value in kwargs.items():
            print(f"key={key},value={value}")

    print("-- 辞書として受け取る")
    # func_c(a1=1, a2=2) と呼び出すと、
    # 関数の中では {'a1': 1, 'a2': 2} という辞書オブジェクトになります。
    func_c(a1=1, a2=2)
    # {'a1': 1, 'a2': 2}
    # key=a1,value=1
    # key=a2,value=2

    print("-- 辞書を引数として展開して渡す方法")
    # すでに辞書がある場合、呼び出し時に ** を付けると
    # 各要素をバラバラのキーワード引数として関数に流し込めます。
    params = {"a3": 3, "a4": 4}
    func_c(**params)
    # {"a3": 3, "a4": 4}
    # key=a3,value=3
    # key=a4,value=4

    print("-- クロージャ")
    # 動的に作成された関数
    # 関数(knight)の中で別の関数(inner)を定義し、それを「戻り値」として返しています。

    def knight(a1):
        def inner():
            print(f"param:{a1}")

        return inner

    a = knight("a")
    a()

    print("-- ラムダ")
    f = lambda x: x * 2
    print(f(10))

    print("-- ラムダ(定義しそのまま実行する)")
    print((lambda x, y: x + y)(10, 20))

    # ======================================================================
    print("\n<-- end main_03")
    # ======================================================================


if __name__ == "__main__":
    main()
