from typing import List
from pydantic import BaseModel, Field


# joinようにカラムをコメント
class Employees(BaseModel):
    # employee_id: int
    last_name: str
    # first_name: str
    # salary: int
    # department_id: int
    department_name: str | None
