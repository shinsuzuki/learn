# 整数型の「型ヒント」
# 引数：整数型、戻り値：文字列型
def add(num1: int, num2: int) -> str:
    # 変数に「型ヒント」
    result:str = '足し算結果＝＞'
    return result + str(num1 + num2)

# 文字列型の「型ヒント」
# 引数：文字列型、戻り値：文字列型
def greet(name: str) -> str:
    return f"おはよう！{name}!"

# 浮動小数点型の「型ヒント」
# 引数：浮動小数点型、戻り値：浮動小数点型
def divide(dividend: float, divisor: float) -> float:
    return dividend / divisor

# リスト型の「型ヒント」
# 3.8以前の書き方
from typing import List
# 引数：リスト「整数型」、戻り値：リスト「整数型」
def get_first_three_elements(elements: List[int]) -> List[int]:
    return elements[:3]

# 辞書型の「型ヒント」
# 3.8以前の書き方
from typing import Dict
# 引数：辞書「文字列型、整数型」、文字列型、戻り値：整数型
def get_value(dictionary: Dict[str, int], key: str) -> int:
    return dictionary[key]

# Python 3.9からは、「型ヒント」でのリストや辞書などの
# 標準コレクションの指定方法が簡略化されました。
# リストの「型ヒント」
# 引数：リスト「文字列型」、戻り値：なし
def process_items(items: list[str]) -> None:
    for item in items:
        print(item)
        
# 辞書の「型ヒント」
# 引数：リスト「文字列型」、戻り値：辞書「文字列型、整数型」
def count_characters(word_list: list[str]) -> dict[str, int]:
    # 変数に「型ヒント」
    count_map: dict[str, int] = {}
    for word in word_list:
        # キー：文字列、値：文字列に対応する文字数
        count_map[word] = len(word)
    return count_map

# ==============================================================
# 呼び出し
# ==============================================================
# 整数型の「型ヒント」を使用する関数を呼び出す
result_add = add(10, 20)
print(result_add)

# 文字列型の「型ヒント」を使用する関数を呼び出す
greeting = greet("タロウ")
print( greeting)

# 浮動小数点型の「型ヒント」を使用する関数を呼び出す
result_divide = divide(10.0, 2.0)
print("割り算の結果＝＞", result_divide)

# リスト型の「型ヒント」を使用する関数を呼び出す（3.9以前の書き方）
elements = get_first_three_elements([1, 2, 3, 4, 5])
print("最初から値を3個取り出す＝＞", elements)

# 辞書型の「型ヒント」を使用する関数を呼び出す（3.9以前の書き方）
value = get_value({'a': 1, 'b': 2, 'c': 3}, 'b')
print("キーワード「b」に対する値は＝＞", value)

# リスト型の「型ヒント」を使用する関数を呼び出す（Python 3.9以降の書き方）
process_items(["リンゴ", "ゴリラ", "ラッパ"])

# 辞書型の「型ヒント」を使用する関数を呼び出す（Python 3.9以降の書き方）
character_counts = count_characters(["apple", "amazon", "google"])
print("文字に対する文字数は＝＞", character_counts)