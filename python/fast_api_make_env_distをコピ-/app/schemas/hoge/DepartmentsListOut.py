from typing import List
from pydantic import BaseModel, Field
from app.schemas.hoge.DepartmentsCommon import Department


class DepartmentsListOut(BaseModel):
    id: int
    departments: List[Department]
