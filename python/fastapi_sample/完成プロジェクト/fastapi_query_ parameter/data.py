from typing import Optional

# 書籍情報を表すクラス
class Book:
    def __init__(self, id: str, title: str, category: str):
        # 書籍ID
        self.id = id
        # タイトル
        self.title = title
        # カテゴリ
        self.category = category

# ダミーの書籍情報リスト
# category"technical：技術書、comics：コミック、magazine：雑誌"
books = [
    Book(id="1", title="Python入門", category="technical"),
    Book(id="2", title="はじめてのプログラミング", category="technical"),
    Book(id="3", title="すすむ巨人", category="comics"),
    Book(id="4", title="DBおやじ", category="comics"),
    Book(id="5", title="週刊ダイヤモンド", category="magazine"),
    Book(id="6", title="ザ・社長", category="magazine")
]

# カテゴリに基づいて書籍を検索する関数
# もしcategoryがNoneなら、すべての書籍を返す
def get_books_by_category(
    category: Optional[str] = None
    )-> list[Book]:
    if category is None:
        # カテゴリが指定されていない場合は全ての書籍を返す
        return books
    else:
        # 指定されたカテゴリに一致する書籍だけを返す
        return [book for book in books if book.category == category]