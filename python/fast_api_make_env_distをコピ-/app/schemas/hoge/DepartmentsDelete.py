from pydantic import BaseModel, Field


class DepartmentsDelete(BaseModel):
    department_id: int = Field(..., description="ID")
