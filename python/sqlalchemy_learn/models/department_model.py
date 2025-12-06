from typing import Optional, List
from sqlalchemy import (
    create_engine,
    Column,
    Integer,
    String,
    ForeignKey,
    Date,
    desc,
    func,
)
from sqlalchemy.orm import sessionmaker, relationship, Mapped, mapped_column
from utils.db.database import Base


class Department(Base):
    """部門テーブル (department)"""

    __tablename__ = "department"

    # ----------------------------------------
    # カラム
    # ----------------------------------------
    # 主キーは mapped_column で定義 (型は Python の int)
    id: Mapped[int] = mapped_column(primary_key=True)

    # 文字列カラム (NOT NULL)
    name: Mapped[str] = mapped_column(String(50))

    # NULL許容のカラムは Optional[str] を使用
    location: Mapped[Optional[str]] = mapped_column(String(50), nullable=True)

    # ----------------------------------------
    # リレーションシップ (1対多)、(連携先の名前に注意)
    # ----------------------------------------
    employee = relationship("Employee", back_populates="department")  # 逆側に関連付ける

    def __repr__(self):
        return f"<Department(id={self.id}, name='{self.name}')>"
