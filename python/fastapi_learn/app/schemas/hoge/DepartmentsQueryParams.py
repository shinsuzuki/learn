from pydantic import BaseModel, Field


class DepartmentsQueryParams(BaseModel):
    department_id: int = Field(..., description="ID")
