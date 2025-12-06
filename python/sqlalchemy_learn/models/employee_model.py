from typing import Optional
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
from sqlalchemy.orm import sessionmaker, relationship, Mapped, mapped_column
from utils.db.database import Base


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
    department_id = Column(Integer, ForeignKey("department.id"))
    department = relationship("Department", back_populates="employee")  # 逆側に関連付ける

    def __repr__(self):
        return f"<Employee(id={self.id}, name='{self.name}', salary={self.salary})>"
