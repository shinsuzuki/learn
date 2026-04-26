import traceback
from collections.abc import Callable

# 定数を定義したい
WORK_FILE = "main_10.py"
print(f"start {WORK_FILE}")


# 数値、あまり切り下げ
v1 = 10
print(f"wari:{v1 / 3}")
print(f"kirisage:{v1 // 3}")

# キャスト
f_v1 = float(v1)
print(f"int to float cast: type:{type(f_v1)},value:{f_v1}")

# エンコード
hello = "hello world"
encode_hello = hello.encode("utf-8")
print(f"encode_hello: {encode_hello}")
decode_hello = encode_hello.decode("utf-8")
print(f"decode_hello:{decode_hello}")

# 文字列
str1 = "ABCDEFGABCDABC"
print(f"count :{str1.count("ABC")}")
print(f"strip  :{str1.strip("A")}")
print(f"lstrip :{str1.lstrip("A")}")
print(f"rstrip :{str1.rstrip("C")}")
print(f"space strip:[{'  hello  '.strip()}]")

msg = "abc"
msg_r = msg.replace("abc", "xyz")
print(f"replace: {msg_r}")

str2 = "10"
print(f"str to int: {int(str2), type(int(str2))}")
str2 = "11.1"
print(f"str to float: {float(str2), type(float(str2))}")

# list
list1 = [1, 2, 3]
list1.append(4)
list1.append(5)
print(list1)
print(list1[-1])

print("list extend")
list2 = [7, 8, 9]
list1.extend(list2)

for item in list1:
    print(item)

# dic
print("dic")
dic1 = {}
dic1["a"] = 1
dic1["b"] = 2
dic1["c"] = 3
print(dic1.get("a"))

print(dic1.keys())
print(dic1.values())
for key, value in dic1.items():
    print(f"key:{key},value:{value}")

# リスト内包表記
list2 = [str(value) + "_edit" for value in list1]
print(list2)

# tuple
print("tuple")
tpl1 = (1, 2, 3)
print(tpl1)

# tupleを辞書に変換
print("tuple to dic")
tpl2 = (("name", "sato"), ("age", 20), ("rold", "admin"))
dic = dict(tpl2)
print(dic)

# 辞書内包表記
henkan_dic = {key.upper(): value for key, value in tpl2}
print(henkan_dic)


print("set")
set1 = {1, 2, 3, 4, 5}
print(set1)


list3 = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
set2 = set(list3)
print(set2)


# 条件分岐
is_attack1: bool = False
is_attack2: bool = True

if is_attack1:
    print(f"is_attack1 is true")
else:
    print(f"is_attack1 is false")

if is_attack1 or is_attack2:
    print(f"is_attack11 or is_attack12 is true")

# Noneの場合の書き方(is None, is not None)
my_score = None
if my_score is None:
    # if my_score is not None:
    print(f"my_score is None")

# 同じオブジェクトかどうかをチェック
a = [1, 2, 3]
b = [1, 2, 3]
if a is b:
    print(f"a is b")
else:
    print(f"a is not b")

# オブジェクトの型をチェック
if isinstance(dic1, dict):
    print(f"dic1 is dict")
else:
    print(f"dic1 is not dict")

# 3項演算子
is_status = False
status = "normal" if is_status else "error"
print(status)

# list > in, not in
fruits = ["apple", "orange", "banana"]
if "apple" in fruits:
    print(f"apple is in fruits")

if "mikan" not in fruits:
    print(f"mikan is not in fruits")

# dict > in
cars = {"type-1": "1000,", "type-2": "2000", "type-3": "3000"}
if "type-2" in cars:
    print(f"type-2 exist.")

if "type-4" in cars:
    print(f"type-4 exist.")
else:
    print(f"type-4 not exist.")


# all
print("all")
numbers = [1, 2, 3, 4, 5]
print(all(x < 10 for x in numbers))
print(all(x < 3 for x in numbers))

# any
print("any")
numbers2 = [1, 2, 3, 4, 5]
print(any(x >= 5 for x in numbers2))

# for
print("for")
fruits = ["apple", "orange", "banana"]
for f in fruits:
    print(f)

print("enumerate")
for index, name in enumerate(fruits):
    print(f"{index}:{name}")

# range
print("range")
for i in range(3):
    print(i)

# dic
print("for dic")
dic = {"a": 1, "b": 2, "c": 3}
for key in dic:
    print(f"{key}:{dic[key]}")

for key, value in dic.items():
    print(f"{key}:{value}")

# while
print("while")
count = 0
while count < 3:
    print(count)
    count += 1

# 例外処理
try:
    print(x)
except Exception as e:
    print(f"An exception occurred: {e}")
    print(f"stack:{traceback.format_exc()}")
finally:
    print("finally")


try:
    raise Exception("my-error")
except Exception as e:
    print(f"An exception occurred: {e}")


class MyException(Exception):
    def __init__(self, message):
        super().__init__(message)


try:
    raise MyException("my-exception")
except MyException as e:
    print(f"custom-error: {e}")


# 関数
def func1(p1: str, p2: bool) -> str:
    if p2:
        return p1
    else:
        return "p2 is false"


print(func1("test", True))
print(func1("test", False))


# 可変長引数(引数がタプルとして渡される)
def sum_all(*numbers):
    result = 0
    for num in numbers:
        result += num
    return result


print(f"sum: {sum_all(1, 2, 3, 4)}")


# キーワード可変長引数
# 「名前=値」という形式（キーワード引数）で渡されたものを、いくつでも受け取ることができる仕組みです。
# 辞書にまとめられる(Pack)
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}:{value}")


print_info(name="sato", age=20)

# 辞書をキーワード引数(「名前=値」)に展開して渡す
my_dict = {"name": "aoki", "age": 20}
print(my_dict)
print_info(**my_dict)


# **を引数時に設定すると展開(Unpack)される
def register_user(name: str, age: int, role: str):
    print(f"{name} ({age}歳) を {role} として登録しました")


user_data = {
    "name": "sato",
    "age": 20,
    "role": "admin",
}

register_user(**user_data)


# tupleを返す
def get_person():
    name = "sato"
    age = 30
    return name, age


name, age = get_person()
print(f"name:{name},age:{age}")


def get_list():
    return 1, 2, 3, 4


first, *rets, last = get_list()
print(f"first:{first},rets:{rets},last:{last}")


# 内部関数
def get_user(name):
    greeting = "hello"

    def print_greeting():
        print(f"greeting:{greeting},{name}")

    print_greeting()


get_user("sato")


# 状態を記憶する(クロージャ)
def create_tax_calculator(tax_rate: float) -> Callable[[int], float]:
    def calculate_tax(amount: int) -> float:
        return amount * tax_rate

    return calculate_tax


tax_10 = create_tax_calculator(0.1)
print(f"10%;{tax_10(110)}")
tax_20 = create_tax_calculator(0.2)
print(f"20%;{tax_20(110)}")


# 高階関数,簡単にラムダで渡したほうが見やすい
users = [{"name": "Taro", "age": 30}, {"name": "Jiro", "age": 20}, {"name": "Saburo", "age": 25}]
sorted_users = sorted(users, key=lambda x: x["age"])
print(sorted_users)

doubled = [x * 2 for x in range(10)]
doubled_over_10 = [x for x in doubled if x >= 10]
print(doubled_over_10)

# ラムダ式
double_func = lambda x: x * 2
print(double_func(10))

# リスト内表記
scores = [10, 20, 30, 40, 50]
results = ["OK" if score >= 30 else "NG" for score in scores]
print(results)


# デコレータについてサンプルを表示して
def my_decorator(func):
    def wrapper():
        print("before")
        func()
        print("after")

    return wrapper


@my_decorator
def do_work():
    print("work")


do_work()


# --------------------------------------------------------------------------------
# class
# --------------------------------------------------------------------------------
class User:
    count = 100
    job_name = "User"

    @classmethod
    def update_job_name(cls, new_job_name: str):
        print(f"update job_name: {new_job_name}")
        cls.job_name = new_job_name

    @classmethod
    def print_job_name(cls):
        print(f"job_name:{cls.job_name}")

    @classmethod
    def custom_user_factory(cls, line: str):
        name, age = line.split(",")
        return cls(name, int(age))

    @staticmethod
    def is_valid_age(age: int) -> bool:
        return age >= 0

    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age

    def say_hello(self):
        print(f"Hello, I am {self.name} and I am {self.age} years old.")

    # getter
    @property
    def age(self):
        return self._age

    # setter
    @age.setter
    def age(self, value: int):
        if value < 0:
            raise ValueError("Age cannot be negative")

        self._age = value


user1 = User("Tanaka", 25)
user1.say_hello()


# 継承
class AdminUser(User):
    def __init__(self, name: str, age: int, role: str):
        super().__init__(name, age)
        self.role = role

    def say_hello(self) -> None:
        print(f"Hello, I am {self.name} ({self.role})")


admin = AdminUser("Sato", 35, "Administrator")
admin.say_hello()
print(f"admin.age:{admin.age}")
print(f"AdminUser.count:{admin.count}")

User.print_job_name()

u1 = User.custom_user_factory("kimura,33")
print(f"{u1.name},{u1.age}")


# --------------------------------------------------------------------------------
# with
# --------------------------------------------------------------------------------
class FileManager:
    def __init__(self, filename, mode, encoding):
        print("__init__")
        self.filename = filename
        self.mode = mode
        self.encoding = encoding

    def __enter__(self):
        print("__enter__")
        # return 値が、as の右側の変数（例：as f の f）に入ります。
        self.file = open(self.filename, self.mode, encoding=self.encoding)
        return self.file

    def __exit__(self, exc_type, exc_val, exc_tb):
        # with ブロックを抜ける時、あるいは中でエラー（例外）が発生して強制終了した時でも、必ず最後に呼ばれる
        print("__exit__")
        self.file.close()


with FileManager("sample.txt", "r", "utf-8") as f:
    lines = f.readlines()
    print(lines)


# --------------------------------------------------------------------------------
# ヒント
# --------------------------------------------------------------------------------
aaa_name: str | None
# aaa_name = None
aaa_name = "kaito"
print(f"aaa_name: {aaa_name}")
