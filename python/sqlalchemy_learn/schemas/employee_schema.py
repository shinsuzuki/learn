from typing import Optional

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

from sqlalchemy.orm import (
    DeclarativeBase,
    Mapped,
    registry,
    mapped_column,
)

from datetime import date
from pydantic import BaseModel


class BaseSchema(DeclarativeBase):
    pass


# class EmployeeSchema(BaseSchema):
class EmployeeSchema(BaseModel):
    """従業員テーブル (employee)"""

    __tablename__ = "employee"

    # ----------------------------------------
    # カラム
    # ----------------------------------------
    id: int
    name: str
    job_title: Optional[str]
    salary: Optional[int]
    hire_date: Optional[date]
    department_id: Optional[int]

    model_config = {"from_attributes": True}
