from __future__ import annotations  # おまじない、python不要だが
from typing import Optional, List
from sqlalchemy.orm import relationship

# 独自のbaseモジュールからのインポート
from models.base import Base, Mapped, mapped_column, TYPE_CHECKING, String


# --------------------------------------------------------------------------
# 【重要】循環参照の回避と型チェックへの対応
# --------------------------------------------------------------------------
# Pythonの実行時 (runtime) には False になるため、インポートはスキップされます。
# Pylanceなどの静的型チェッカーが解析する時のみ True になり、インポートが実行されます。
if TYPE_CHECKING:
    from models.employee_model import Employee


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
    # employee = relationship("Employee", back_populates="department")  # 逆側に関連付ける

    # -----------------------------------------------------------
    # v2用
    # -----------------------------------------------------------
    # 【前方参照】
    # 後の行で定義されるEmployeeクラスを型ヒント (Mapped) と relationship の両方で文字列で指定している。
    # -----------------------------------------------------------
    employee: Mapped[List["Employee"]] = relationship(
        "Employee", back_populates="department"  # relationshipのターゲットも文字列
    )

    def __repr__(self):
        return f"<Department(id={self.id}, name='{self.name}')>"
