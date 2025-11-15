from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from util.db import Base


class Item(Base):
    """itemクラス"""

    # テーブル名称
    __tablename__ = "item"
    # カラム
    id = Column(Integer, primary_key=True)
    name = Column(String)
    price = Column(Integer)
    memo = Column(String)
    category_id = Column(Integer)

    @property
    def item_info(self):
        """itemクラスの属性を整形して返却"""
        return f"id: {self.id}, 商品名: {self.name}, 値段: {self.price}円, メモ: {self.memo}, カテゴリid: {self.category_id}"
