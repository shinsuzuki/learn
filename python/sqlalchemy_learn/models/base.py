from __future__ import annotations
from typing import List, Optional
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy import String, ForeignKey, Date
from datetime import date
from decimal import Decimal


# 1. すべてのモデルが継承する基底クラス (DeclarativeBaseから継承)
# これがメタデータを保持し、マッピングの出発点となります。
class Base(DeclarativeBase):
    """
    すべてのSQLAlchemyモデルが継承する基底クラス。

    DeclarativeBaseを継承し、メタデータ管理と型ヒントに必要な
    Mapped/mapped_column/relationshipなどを提供します。
    """

    pass


# 2. 共通して使用する型や関数をエクスポート
# 各モデルファイルでは、以下のようにインポートして使用します:
# from .base import Base, Mapped, mapped_column, relationship, String, ForeignKey, ...

# from __future__ import annotations を使用しているため、
# モデルクラス自体（Department, Employee）をここでインポートする必要はありません。
# relationship()のターゲットとして文字列指定が可能です。
