from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from util.db import Base


class ItemCategory(Base):
    """item_categoryクラス"""

    # テーブル名称
    __tablename__ = "item_category"
    # カラム
    id = Column(Integer, primary_key=True)
    name = Column(String)
    memo = Column(String)
