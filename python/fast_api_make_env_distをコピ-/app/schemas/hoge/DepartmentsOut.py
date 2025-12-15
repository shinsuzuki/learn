from pydantic import BaseModel, Field
from app.schemas.hoge.DepartmentsCommon import Department

# class DepartmentOne(BaseModel):
#     department_id: int
#     department_name: str
#     location: str
#     model_config = {"from_attributes": True}  # これを追加


class DepartmentsOut(BaseModel):
    id: int
    department: Department
