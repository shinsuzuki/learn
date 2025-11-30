from typing import List
from pydantic import BaseModel, Field
from app.schemas.hoge.EmployeesCommon import Employees


class EmployeesListOut(BaseModel):
    id: int
    employees: List[Employees] | None = []
