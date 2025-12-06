from __future__ import annotations
from typing import Optional, TYPE_CHECKING
from datetime import date
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

# 独自のbaseモジュールからのインポート
from models.base import Base, Mapped, mapped_column, relationship


# --------------------------------------------------------------------------
# 【重要】循環参照の回避と型チェックへの対応
# --------------------------------------------------------------------------
# Pythonの実行時 (runtime) には False になるため、インポートはスキップされます。
# Pylanceなどの静的型チェッカーが解析する時のみ True になり、インポートが実行されます。
if TYPE_CHECKING:
    from models.department_model import Department


class Employee(Base):
    """従業員テーブル (employee)"""

    __tablename__ = "employee"

    # ----------------------------------------
    # カラム
    # ----------------------------------------
    id: Mapped[int] = mapped_column(primary_key=True)

    name: Mapped[str] = mapped_column(String(100))

    # NULLを許容する職種と給与
    job_title: Mapped[Optional[str]] = mapped_column(String(50), nullable=True)

    # 型推論: mapped_column() を省略すると、デフォルトで Mapped[int] は Column(Integer) になる
    salary: Mapped[Optional[int]]

    # DATE型
    hire_date: Mapped[Optional[date]] = mapped_column(Date, nullable=True)

    # ----------------------------------------
    # 外部キー(連携先の名前に注意)
    # ----------------------------------------
    # department_id = Column(Integer, ForeignKey("department.id"))
    # department = relationship("Department", back_populates="employee")  # 逆側に関連付ける

    # -----------------------------------------------------------
    # v2用
    # -----------------------------------------------------------
    # 【前方参照】
    # Departmentクラスは既に定義されているが、一貫性のためにMapped の型ヒント部分を文字列で指定している。
    # -----------------------------------------------------------
    department_id: Mapped[Optional[int]] = mapped_column(ForeignKey("department.id"), nullable=True)

    department: Mapped[Optional["Department"]] = relationship(
        "Department", back_populates="employee"  # relationshipのターゲットも文字列
    )

    def __repr__(self):
        return f"<Employee(id={self.id}, name='{self.name}', salary={self.salary})>"
