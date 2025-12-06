from __future__ import annotations

# ----------------------------------------------------
# 1. 宣言的システムと型ヒントのための必須インポート
# ----------------------------------------------------
from typing import (
    Annotated,
    TYPE_CHECKING,
    List,
    Optional,
)

from sqlalchemy.orm import (
    DeclarativeBase,
    Mapped,
    registry,
    mapped_column,
)

# ----------------------------------------------------
# 2. データ型のインポート
# ----------------------------------------------------
# SQLが認識するデータベース固有の型を定義
from sqlalchemy import (
    Boolean,
    Column,
    Date,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    JSON,
    Numeric,
    String,
)

from datetime import date, datetime
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
