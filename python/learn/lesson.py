print("====> start")

# ======================================== 文字列について

# ========== スライス
print("abcdefg"[3:5])  # インデックスの　3以上、5未満

# ========== 文字列メソッド
# startswith
print("first".startswith("f"))  # 開始文字列がｆならTrueを返す

# find
print("first".find("s"))  # インデックスを返す
print("first".find("ｘ"))  # 見つからないなら -1 を返す

# ========== format
# type1、番号で指定する
print("{0},{1}".format(123, 456))

# type2、変数名を使える
num1 = 12
num2 = 34
print(f"{num1},{num2}")


# ======================================== 配列について
l = [1, 2, 3, 4]
print(l)

# ========== 操作
# 指定したインデックスに追加
l.insert(0, 100)
print(l)

# 末尾に追加
l.append(200)
print(l)

# POP(末尾)
l.pop()
print(l)

# 末尾に追加
l.append(999)
print(l)

# 配列の長さ
delIndex = len(l)
print(delIndex)

# インデックスを指定し削除
del l[delIndex - 1]
print(l)

# 指定した値を削除、値が存在しないとエラー
l.remove(3)
print(l)

# 配列を結合
arr1 = [1, 2, 3]
arr1 += [4, 5, 6]
print(arr1)

# 配列を結合
arr2 = [1, 2, 3]
arr2.extend([4, 5, 6])
print(arr2)

# 値のインデックスを取得
arr3 = [1, 2, 3, 1, 2, 3]
print(arr3.index(3))
# print(arr3.index(99)) # 値が存在しないとエラー

# カウント
print(arr3.count(3))

# 要素が含まれているかを確認
if 3 in arr3:
    print("exist 3 in arr3")

# sort
arr4 = [3, 4, 2, 3, 1, 5]
arr4.sort()
print(arr4)
arr4.reverse()
print(arr4)

# スプリット、結合
arr5 = "my name is xxx".split(" ")
print(arr5)
joinStr = ",".join(arr5)
print(joinStr)

# 配列のコピー
arr6 = [1, 2, 3, 4]
arr7 = arr6.copy()
arr6[0] = 99
print(arr6)
print(arr7)  # arr7に影響なし

# アンパック
ax1, ay1 = [1, 2]
print(ax1)
print(ay1)

# ======================================== タプルについて
# 変更できない、他はindex,countが使える
tp1 = (1, 2, 3, 4)
print(tp1)

# 結合
tp2 = (1, 2, 3) + (4, 5, 6)
print(tp2)

# アンパック
tpx, tpy = (1, 2)
print(tpx)
print(tpy)

# ======================================== 辞書について
# 辞書作成
d1 = {"x": 1, "y": 2}
print(d1["x"])
print(d1["y"])

d2 = dict(a=10, b=20, x=99)
print(d2["a"])
print(d2["b"])
print(d2["x"])

# update、結合、同じキーは更新される
d1.update(d2)
print(d1)

# キー、値参照
print(d1.keys())
print(d1.values())

# getによる値の取得
print(d1.get("x"))
print(d1.get("xxxx"))  # 存在しない場合はNoneを返す

# popを使用できる
print(d1.pop("x"))  # xをpop
print(d1)

# 削除
del d1["a"]
print(d1)

# 辞書をクリア
d1.clear()
print(d1)

# キーのチェック、存在すればTrue、そうでなければFalse
print("x" in d1)
print("b" in d2)

# 辞書のコピー
d3 = dict(a=10, b=20)
d4 = d3.copy()
d3["a"] = 99
print(d3)
print(d4)  # d4に影響なし


# ======================================== 集合について
s1 = {1, 2, 3, 4}
s2 = {2, 4, 5, 6}
print(s1 & s2)  # 両方にあるもの
print(s1 - s2)  # s1からs2にあるものを削除したもの
print(s1 | s2)  # s1,s2にあるもの


# ======================================== 制御について
# ========== if
fx = 3
if fx < 0:
    print("0未満")
elif fx < 10:
    print("0以上、10未満")
else:
    print("10以上")

# ========== if, 配列に含まれているかをチェック（in, not）
arr8 = [1, 2, 3]
if 2 in arr8:
    print("2 in arr8")

if 99 not in arr8:
    print("99 not in arr8")

# ========== 条件の書き方
# こちらよりも↓
isOk = False
if isOk == False:
    print("isOK is True")

# こちらが推奨
if not isOk:
    print("isOK is True")

# 条件は、0、空文字、空配列の場合、空タプル、空辞書、空集合値は False と判定される
isFx2 = 0
if not isFx2:
    print("0の場合False")

isFx2 = ""
if not isFx2:
    print("空文字の場合False")

isFx2 = []
if not isFx2:
    print("空配列の場合False")


# ========== Noneの書き方
isEmpty = None
if isEmpty is None:
    print("isEmpty is None")

isEmpty = "abc"
if isEmpty is not None:
    print("isEmpty is not None")

# ========== while (break,continue)
wc = 1
while True:
    wc += 1
    print(f"while({wc})")
    if wc > 3:
        break
else:
    print("exit while(break以外の場合は実行)")

# ========= input
# while True:
#     word = input("enter:")
#     print("input_word:" + word)
#     if word == "ok":
#         break

# ========== for
for item in range(3):
    print(item)
else:
    print("exit for(break以外の場合は実行)")

# enumerateでインデックスをとれる
list2 = ["appple", "banana", "orange"]
for i, item in enumerate(list2):
    print(f"index:{i},{item}")

# zip、複数のリストから取得できる
days = [1, 2, 3]
colors = ["red", "blue", "yellow"]
for day, color in zip(days, colors):
    print(f"{day},{color}")

# 辞書からキーと値を取得
dic2 = dict(a=1, b=2, c=3)
for k, item in dic2.items():
    print(f"{k},{item}")


# ======================================== 関数について
def something(msg):
    print("something msg:" + msg)
    return "result something"


print(something("hello"))


# キーワード引数
def something2(a=1, b=2):
    print(f"{a},{b}")


something2()
something2(a=99)
something2(b=99)
something2(a=99, b=100)


def something3(*args):
    for a in args:
        print(a)


list = ("say", "hello")
something3(*list)


def something4(**kwargs):
    for k, v in kwargs.items():
        print(f"{k},{v}")


dic = dict(a=1, b=2)
something4(**dic)


# デコレータ
def deco1(func):
    def wrapper(a, b):
        print("before")
        func(a, b)
        print("after")

    return wrapper


# @deco1
# def add_count(a, b):
#     print(a + b)

# add_count(1, 2)


def add_count(a, b):
    print(a + b)


deco1(add_count)(100, 200)


# ラムダ
f = lambda x: x * 2
print(f(30))


# ジェネレータ
def gen1():
    yield "apple"
    yield "banana"
    yield "orange"


for g in gen1():
    print(g)

# ======================================== 例外について
import traceback

try:
    raise Exception("myError!")
    print(x)
except Exception as ex:
    print(ex)
    traceback.print_exc()
finally:
    print("The try except is finished")


print("====> end")
